class DoshWeaponMut extends Mutator;

function PostBeginPlay() {
    if (KFGameType(Level.Game) == none) {
        Destroy();
        return;
    }
    if (Level.NetMode != NM_Standalone)
        AddToPackageMap("DoshWeapon");
}

simulated function Tick(float DeltaTime) {
    local PlayerController PC;

    PC= Level.GetLocalPlayerController();
    if (PC != none) {
        PC.Player.InteractionMaster.AddInteraction("DoshWeapon.DWInteraction", PC.Player);
    }
    Disable('Tick');
}
 

function Mutate(string MutateString, PlayerController Sender) {
    local Vector X,Y,Z;
    local DoshPickupWeapon CashPickup;
    local Vector TossVel;
    local array<string> parts;
    local int Amount;
    local KFPawn kfPawn;

    kfPawn= KFPawn(Sender.Pawn);
    Split(MutateString, " ", parts);
    if (kfPawn != none && parts[0] ~= "tosscash") {
        if (parts.Length == 1) {
            Amount= 50;
        } else {
            Amount= int(parts[1]);
            if( Amount<=0 )
                Amount= 50;
        }
        Sender.PlayerReplicationInfo.Score= int(Sender.PlayerReplicationInfo.Score); // To fix issue with throwing 0 pounds.
        if (Sender.PlayerReplicationInfo.Score > 0 && Amount > 0) {
            Amount= Min(Amount,int(Sender.PlayerReplicationInfo.Score));
            kfPawn.GetAxes(Rotation,X,Y,Z);
    
            TossVel= Vector(kfPawn.GetViewRotation());
            TossVel= TossVel * ((kfPawn.Velocity Dot TossVel) + 500) + Vect(0,0,200);
    
            CashPickup= Spawn(class'DoshWeapon.DoshPickupWeapon',,, 
                kfPawn.Location + 0.8 * kfPawn.CollisionRadius * X - 0.5 * kfPawn.CollisionRadius * Y);
    
            if(CashPickup != none) {
                CashPickup.CashAmount= Amount;
                CashPickup.bDroppedCash= true;
                CashPickup.RespawnTime= 0;   // Dropped cash doesnt respawn. For obvious reasons.
                CashPickup.Velocity= TossVel;
                CashPickup.DroppedBy= Sender;
                CashPickup.InitDroppedPickupFor(None);
                Sender.PlayerReplicationInfo.Score-= Amount;
    
                if (Level.Game.NumPlayers > 1 && Level.TimeSeconds - kfPawn.LastDropCashMessageTime > kfPawn.DropCashMessageDelay ) {
                    Sender.Speech('AUTO', 4, "");
                }
            }
        }
    } else {
        super.Mutate(MutateString, Sender);
    }
}
    
defaultproperties {
    GroupName="KFDoshMut"
    FriendlyName="Dosh Weapon v2.0"
    Description="Deal damage to enemies with dosh!  Version 2.0"
    
    RemoteRole= ROLE_SimulatedProxy
    bAlwaysRelevant= true
}
