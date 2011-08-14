class DoshWeaponPlayerController extends KFPCServ;

function SetPawnClass(string inClass, string inCharacter) {
    PawnClass = Class'DoshWeapon.DoshWeaponHumanPawn';
    inCharacter = Class'KFGameType'.Static.GetValidCharacter(inCharacter);
    PawnSetupRecord = class'xUtil'.static.FindPlayerRecord(inCharacter);
    PlayerReplicationInfo.SetCharacterName(inCharacter);
}

