scriptName "LND\Functions\fn_newSector.sqf";
/*
	Author:
		Landric

	Description:
		"Helper" function to both teardown any exist old sector, spawn the new one,
		and move the player to the new zone

	Parameter(s):
		none
	Returns:
		none
	Example Usage:
		call LND_fnc_newSector;
*/

// Fade the player's view out
private _playerEffect = {
	if (!hasInterface) exitWith {};
	private _spawn = [] spawn {
		cutText ["", "BLACK OUT", 0.1];
	};
};
{ [[], _playerEffect] remoteExec ["call", _x]; } forEach allPlayers;




private _radius = call LND_fnc_getRadius;


if ((["AdvanceTime", 1] call BIS_fnc_getParamValue) == 1 && {!isNil "LND_iedd_missionStarted"}) then {
	skipTime 6;
	LND_iedd_missionStarted = true;
};



private "_pos";
while { LND_iedd_IEDsRemaining <= 0 || {_pos isEqualTo [0,0]} } do {

	deleteMarker "LND_iedd_zone";
	{ deleteVehicle _x; } forEach LND_iedd_createdClutter;
	{ deleteVehicle _x; } forEach LND_iedd_createdUnits;
	{ deleteVehicle _x; } forEach LND_iedd_createdIEDs;

	_pos = [nil, ["water"], {isOnRoad  _this}] call BIS_fnc_randomPos;

	[_pos] call LND_fnc_createIEDs;
};


// Create zone marker
_zoneMarker = createMarkerLocal ["LND_iedd_zone", _pos];
_zoneMarker setMarkerShapeLocal "ELLIPSE";
_zoneMarker setMarkerSizeLocal [_radius, _radius];
_zoneMarker setMarkerAlphaLocal 0.5;
_zoneMarker setMarkerColor "ColorRed";



// Set up start position - not near any IEDs!
private _blacklist = [];
{ _blacklist pushBack [getPos _x, 20]; } forEach LND_iedd_createdIEDs;
private _radius = call LND_fnc_getRadius;
LND_iedd_startPos = [[[_pos, _radius]], _blacklist, {isOnRoad  _this}] call BIS_fnc_randomPos;
if(LND_iedd_startPos isEqualTo [0,0]) then {
	debugLog "[Warning] LND_iedd: Could not find a valid start position, falling back to centre of zone by default";
	LND_iedd_startPos = _pos;
};


// Create "decoy" clutter
[_pos] call LND_fnc_createClutter;


// Optionally create an ambush
if(random 100 < (["AmbushChance", 5] call BIS_fnc_getParamValue)) then {
	[_pos] call LND_fnc_createAmbush;
};


// Move the players to the start and fade back in
_playerEffect = {
	if (!hasInterface) exitWith {};
	private _spawn = [_pos] spawn {
		params ["_centre"];
		sleep 1.5;
		player setPos LND_iedd_startPos;
		player setDir (player getRelDir _centre);
		cutText ["", "BLACK IN", 1];
	};
};
{ [[], _playerEffect] remoteExec ["call", _x]; } forEach allPlayers;