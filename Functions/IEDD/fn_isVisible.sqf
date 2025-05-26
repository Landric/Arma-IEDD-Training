scriptName "LND\Functions\fn_isVisible.sqf";
/*
    Author:
        ZEN

    Description:
        Determines if a position is visible to players
        Adapted from ZEN/addons/visibility/functions/fnc_draw.sqf

    Parameter(s):
        _pos - the position to check
    Returns:
        bool - whether the position can be seen by any player

    Example Usage:
        if ([_pos] call LND_fnc_isVisible) then { ... };
*/

private _posHigh = _pos vectorAdd [0, 0, 1.5];


private _visible = false;
{
    // Check if the cursor's position is in the player's view
    private _dir = _x getRelDir _pos;
    private _eyePos = eyePos _x;

    if ((_dir <= 90 || {_dir >= 270}) && {
        lineIntersectsSurfaces [_eyePos, _pos, _x] isEqualTo [] || {lineIntersectsSurfaces [_eyePos, _posHigh, _x] isEqualTo []}
    }) then {
        _visible = true;
        break;
    };
} forEach allPlayers;


_visible
