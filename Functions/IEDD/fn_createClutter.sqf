scriptName "LND\Functions\fn_createClutter.sqf";
/*
	Author:
		Landric

	Description:
		Spawns clutter around the zone

	Parameter(s):
		_pos - center position of the zone
	Returns:
		none

	Example Usage:
		[_pos] call LND_fnc_createClutter;
*/

params ["_pos"];

private _radius = call LND_fnc_getRadius;

// Create clutter
private _clutterAmount = 3.14 * _radius * _radius * 0.02;
for "_i" from 1 to _clutterAmount do {
	private _safePos = [_pos, 0, _radius, 0, 0, 0.5, 0, [], [[0,0], [0,0]]] call BIS_fnc_findSafePos;

	if(_safePos isEqualTo [0,0]) then { // Ran out of safe places
		break;
	};

	private _sizeChance = random 1;
	private _clutter = switch (true) do {
		case (_sizeChance > 0.95): { selectRandom LND_iedd_largeClutter };
		case (_sizeChance > 0.66): { selectRandom LND_iedd_mediumClutter };
		default { selectRandom LND_iedd_smallClutter };
	};
	_clutter = _clutter createVehicle _safePos;
	_clutter setDir (random 360);
	//_clutter enableSimulationGlobal false;
 	LND_iedd_createdClutter pushback _clutter;
};


// Do a second pass for less dense clutter surrounding the zone itself (just to make the boundary a bit less stark)
_clutterAmount = _clutterAmount * 0.5;
for "_i" from 1 to _clutterAmount do {
	private _safePos = [_pos, _radius, _radius*2, 0, 0, 0.5, 0, [], [[0,0], [0,0]]] call BIS_fnc_findSafePos;

	if(_safePos isEqualTo [0,0]) then { // Ran out of safe places
		break;
	};

	private _sizeChance = random 1;
	private _clutter = switch (true) do {
		case (_sizeChance > 0.66): { selectRandom LND_iedd_mediumClutter };
		default { selectRandom LND_iedd_smallClutter };
	};
	_clutter = _clutter createVehicle _safePos;
	_clutter setDir (random 360);
	//_clutter enableSimulationGlobal false;
 	LND_iedd_createdClutter pushback _clutter;
};