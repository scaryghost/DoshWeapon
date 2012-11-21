class DoshWeaponMut extends Mutator;

var() config int doshDamage;

function PostBeginPlay() {
    local KFGameType KF;

    KF = KFGameType(Level.Game);
    if (Level.NetMode != NM_Standalone)
        AddToPackageMap("DoshWeapon");

    if (KF == none) {
        Destroy();
        return;
    }
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
    local CashPickup CashPickup ;
    local Vector TossVel;
    local int Amount;

    Amount= int(MutateString);
    if( Amount<=0 )
        Amount = 50;
    Sender.PlayerReplicationInfo.Score = int(Sender.PlayerReplicationInfo.Score); // To fix issue with throwing 0 pounds.
    if( Sender.PlayerReplicationInfo.Score<=0 || Amount<=0 )
        return;
    Amount = Min(Amount,int(Sender.PlayerReplicationInfo.Score));

    Sender.Pawn.GetAxes(Rotation,X,Y,Z);

    TossVel = Vector(Sender.Pawn.GetViewRotation());
    TossVel = TossVel * ((Sender.Pawn.Velocity Dot TossVel) + 500) + Vect(0,0,200);

    CashPickup = Spawn(class'DoshWeapon.DoshPickupWeapon',,, Sender.Pawn.Location + 0.8 * Sender.Pawn.CollisionRadius * X - 0.5 * Sender.Pawn.CollisionRadius * Y);

    if(CashPickup != none) {
        CashPickup.CashAmount = Amount;
        CashPickup.bDroppedCash = true;
        CashPickup.RespawnTime = 0;   // Dropped cash doesnt respawn. For obvious reasons.
        CashPickup.Velocity = TossVel;
        CashPickup.DroppedBy = Sender;
        CashPickup.InitDroppedPickupFor(None);
        Sender.PlayerReplicationInfo.Score -= Amount;

        if ( Level.Game.NumPlayers > 1 && Level.TimeSeconds - KFPawn(Sender.Pawn).LastDropCashMessageTime > KFPawn(Sender.Pawn).DropCashMessageDelay ) {
            Sender.Speech('AUTO', 4, "");
        }
    }
}

static function FillPlayInfo(PlayInfo PlayInfo) {
    Super.FillPlayInfo(PlayInfo);
    PlayInfo.AddSetting("DoshWeapon", "doshDamage","Dosh Damage Amount", 0, 1, "Text");
}

static event string GetDescriptionText(string property) {
    switch(property) {
        case "doshDamage":
            return "Sets how much damage each pile of dosh will deal";
        default:
            return Super.GetDescriptionText(property);
    }
}


defaultproperties {
    GroupName="KFDoshMut"
    FriendlyName="Dosh Weapon"
    Description="Deal damage to enemies with dosh!  Version 1.0.1"
    
    doshDamage= 35

    RemoteRole= ROLE_SimulatedProxy
    bAlwaysRelevant= true
}
