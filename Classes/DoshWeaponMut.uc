class DoshWeaponMut extends Mutator;

function PostBeginPlay() {
    local KFGameType KF;

    KF = KFGameType(Level.Game);

    if (KF == none) {
        Destroy();
        return;
    }

    /**
     *  Overwrite the pawn with the beta pawn.  
     *  See the class for details.
     */
    KF.PlayerControllerClass= class'DoshWeapon.DoshWeaponPlayerController';
    KF.PlayerControllerClassName= "DoshWeapon.DoshWeaponPlayerController";


}

defaultproperties {
    GroupName="KFDoshWeapon"
    FriendlyName="Dosh Weapon"
    Description="Deal damage to enemies with dosh!"
}
