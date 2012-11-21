class DWInteraction extends Interaction;

event NotifyLevelChange() {
    Master.RemoveInteraction(self);
}

function bool KeyEvent(EInputKey Key, EInputAction Action, float Delta ) {
    local string alias;

    alias= ViewportOwner.Actor.ConsoleCommand("KEYBINDING"@ViewportOwner.Actor.ConsoleCommand("KEYNAME"@Key));
    if (Action == IST_Press && alias ~= "tosscash") {
        ViewportOwner.Actor.ConsoleCommand("mutate 50");
        return true;
    }
}

defaultproperties {
    bActive= true
}
