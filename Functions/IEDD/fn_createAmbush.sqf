scriptName "LND\Functions\fn_createAmbush.sqf";
/*
	Author:
		Landric

	Description:
		Spawns an ambush of 

	Parameter(s):
		_pos - center position of the zone
	Returns:
		none

	Example Usage:
		[_pos] call LND_fnc_createAmbush;
*/
params ["_pos"];

// Spawn ambush after a delay, so the players aren't immediately murdered
[_pos] spawn {
	params ["_pos"];

	sleep ((random 80) + 20);

	private _insurgents = [
		"O_G_Soldier_SL_F", 
		"O_G_Soldier_AR_F", 
		"O_G_Soldier_GL_F", 
		"O_G_Soldier_M_F", 
		"O_G_Soldier_F", 
		"O_G_medic_F"
	];

	private _radius = call LND_fnc_getRadius;

	for "_i" from 1 to count allPlayers do {
		
		private _spawnPos = [[[_pos, _radius*6]], [[_pos, _radius*3]], { !([_this] call LND_fnc_isVisible) }] call BIS_fnc_randomPos;

		if(_spawnPos isEqualTo [0,0]) exitWith { diag_log "[Warning] LND_iedd: Could not spawn ambush, no safe position found"; };

		private _group = createGroup [opfor, true];
		for "_j" from 1 to (random 3)+2 do {
			private _unit = _group createUnit [(selectRandom _insurgents), _spawnPos, [], 20, "NONE"];
			LND_iedd_createdUnits pushBack _unit;
		};

		_group setBehaviourStrong "STEALTH";
		_group setCombatMode "WHITE";
		private _wp = _group addWaypoint [_pos, 0];
		_wp setWaypointType "SAD";
		_wp setWaypointBehaviour "STEALTH";
	};
};
