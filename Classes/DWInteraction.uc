class DWInteraction extends Interaction;

event NotifyLevelChange() {
    Master.RemoveInteraction(self);
}

function bool KeyEvent(EInputKey Key, EInputAction Action, float Delta ) {
    local string alias;

    alias= ViewportOwner.Actor.ConsoleCommand("KEYBINDING"@ViewportOwner.Actor.ConsoleCommand("KEYNAME"@Key));
    if (Action == IST_Press && InStr(locs(alias), "tosscash") != -1) {
        ViewportOwner.Actor.ConsoleCommand("mutate"@alias);
        return true;
    }
}

defaultproperties {
    bActive= true
}
