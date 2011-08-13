class DoshWeaponMut extends Mutator;

function PostBeginPlay() {
    local KFGameType KF;

    KF = KFGameType(Level.Game);

    if (KF == none) {
        Destroy();
        return;
    }

}

defaultproperties {
    GroupName="KFDoshWeapon"
    FriendlyName="Dosh Weapon"
    Description="Deal damage to enemies with dosh!"
}
