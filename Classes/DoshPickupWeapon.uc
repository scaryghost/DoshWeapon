class DoshPickupWeapon extends CashPickup;

var class<DamageType> DoshDamType;
var float damageScale;

/** If an enemy touches dosh on the ground, hurt him too! */
auto state Pickup {
    function Touch( actor Other ) {
        local vector Dummy;
        if ( ValidTouch(Other) ) {
            GiveCashTo(Pawn(Other));
        } else if (KFMonster(Other) != none && KFMonster(Other).Health > 0) {
            //Added second conditional to avoid ragdolls absorbing dosh
            KFMonster(Other).TakeDamage(CashAmount * damageScale, KFHumanPawn(DroppedBy.Pawn), Location, Dummy, DoshDamType);
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
        local vector Dummy;
        if (ValidTouch(Other)) {
            GiveCashTo(Pawn(Other));
        } else if (KFMonster(Other) != none && KFMonster(Other).Health > 0) {
            KFMonster(Other).TakeDamage(CashAmount * damageScale, KFHumanPawn(DroppedBy.Pawn), Location, Dummy, DoshDamType);
            SetRespawn();
        }
    }
}

defaultproperties {
    damageScale= 1.0;
    DoshDamType= class'DoshWeapon.DamTypeDoshWeapon'
}
