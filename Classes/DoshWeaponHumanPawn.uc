class DoshWeaponHumanPawn extends KFHumanPawn;

exec function TossCash( int Amount ) {
    local Vector X,Y,Z;
    local CashPickup CashPickup ;
    local Vector TossVel;

    if( Amount<=0 )
        Amount = 50;
    Controller.PlayerReplicationInfo.Score = int(Controller.PlayerReplicationInfo.Score); // To fix issue with throwing 0 pounds.
    if( Controller.PlayerReplicationInfo.Score<=0 || Amount<=0 )
        return;
    Amount = Min(Amount,int(Controller.PlayerReplicationInfo.Score));

    GetAxes(Rotation,X,Y,Z);

    TossVel = Vector(GetViewRotation());
    TossVel = TossVel * ((Velocity Dot TossVel) + 500) + Vect(0,0,200);

    CashPickup = Spawn(class'DoshWeapon.DoshPickupWeapon',,, Location + 0.8 * CollisionRadius * X - 0.5 * CollisionRadius * Y);

    if(CashPickup != none) {
        CashPickup.CashAmount = Amount;
        CashPickup.bDroppedCash = true;
        CashPickup.RespawnTime = 0;   // Dropped cash doesnt respawn. For obvious reasons.
        CashPickup.Velocity = TossVel;
        CashPickup.DroppedBy = Controller;
        CashPickup.InitDroppedPickupFor(None);
        Controller.PlayerReplicationInfo.Score -= Amount;

        if ( Level.Game.NumPlayers > 1 && Level.TimeSeconds - LastDropCashMessageTime > DropCashMessageDelay ) {
            PlayerController(Controller).Speech('AUTO', 4, "");
        }
    }
}

