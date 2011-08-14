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

    /**
     *  Overwrite the pawn with the beta pawn.  
     *  See the class for details.
     */
    KF.PlayerControllerClass= class'DoshWeapon.DoshWeaponPlayerController';
    KF.PlayerControllerClassName= "DoshWeapon.DoshWeaponPlayerController";
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
    GroupName="KFDoshWeapon"
    FriendlyName="Dosh Weapon"
    Description="Deal damage to enemies with dosh!  Version 1.0.0"
    
    doshDamage= 35
}
