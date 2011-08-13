class CashPickupWeapon extends CashPickup;

var int damage;
var class<DamageType> DoshDamType;

state FallingPickup {
    function Touch(actor Other) {
        local vector dummyHitLocation, dummyMomentum;
        /**
         *  If the actor is a valid, give them money (default behavior).
         *  Otherwise, if the actor is a KFMonster, hurt them!
         */
        if (ValidTouch(Other)) {
            GiveCashTo(Pawn(Other));
        } else if (KFMonster(Other) != none) {
            KFMonster(Other).TakeDamage(damage, KFHumanPawn(DroppedBy.Pawn), dummyHitLocation, dummyMomentum, DoshDamType);
        }
    }
}

defaultproperties {
    damage= 35
    DoshDamType= class'DoshWeapon.DamTypeDoshWeapon'
}
