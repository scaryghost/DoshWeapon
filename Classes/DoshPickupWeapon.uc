class DoshPickupWeapon extends CashPickup;

var int damage;
var class<DamageType> DoshDamType;
var vector dummyHitLocation, dummyMomentum;

/**
 *  If an enemy touches dosh on the ground, hurt him too!
 */
auto state Pickup {
    function Touch( actor Other ) {
        if ( ValidTouch(Other) ) {
            GiveCashTo(Pawn(Other));
        } else if (KFMonster(Other) != none) {
            KFMonster(Other).TakeDamage(damage, KFHumanPawn(DroppedBy.Pawn), dummyHitLocation, dummyMomentum, DoshDamType);
            SetRespawn();
        }
    }
}

/**
 *  If the actor is a valid, give them money (default behavior).
 *  Otherwise, if the actor is a KFMonster, hurt them!
 */
state FallingPickup {
    function Touch(actor Other) {
        if (ValidTouch(Other)) {
            GiveCashTo(Pawn(Other));
        } else if (KFMonster(Other) != none) {
            KFMonster(Other).TakeDamage(damage, KFHumanPawn(DroppedBy.Pawn), dummyHitLocation, dummyMomentum, DoshDamType);
            SetRespawn();
        }
    }
}

defaultproperties {
    damage= 35
    DoshDamType= class'DoshWeapon.DamTypeDoshWeapon'
}
