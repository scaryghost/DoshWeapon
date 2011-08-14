class DoshPickupWeapon extends CashPickup;

var class<DamageType> DoshDamType;
var vector dummyHitLocation, dummyMomentum;

/**
 *  If an enemy touches dosh on the ground, hurt him too!
 */
auto state Pickup {
    function Touch( actor Other ) {
        if ( ValidTouch(Other) ) {
            GiveCashTo(Pawn(Other));
        } else if (KFMonster(Other) != none && KFMonster(Other).Health > 0) {
            //Added second conditional to avoid ragdolls absorbing dosh
            KFMonster(Other).TakeDamage(class'DoshWeapon.DoshWeaponMut'.default.doshDamage, KFHumanPawn(DroppedBy.Pawn), dummyHitLocation, dummyMomentum, DoshDamType);
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
        } else if (KFMonster(Other) != none && KFMonster(Other).Health > 0) {
            KFMonster(Other).TakeDamage(class'DoshWeapon.DoshWeaponMut'.default.doshDamage, KFHumanPawn(DroppedBy.Pawn), dummyHitLocation, dummyMomentum, DoshDamType);
            SetRespawn();
        }
    }
}

defaultproperties {
    DoshDamType= class'DoshWeapon.DamTypeDoshWeapon'
}
