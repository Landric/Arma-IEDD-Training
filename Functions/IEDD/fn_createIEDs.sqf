scriptName "LND\Functions\fn_createIEDZone.sqf";
/*
	Author:
		Landric

	Description:
		Creates clutter, decoys, and IEDs within the specified area
		Also (optionally) spawn an ambush

	Parameter(s):
		pos
	
	Returns:
		none

	Example Usage:
		call LND_fnc_spawnIEDZone;
*/

params [ ["_pos", [0,0], [[]], [2, 3]]];


private _radius = call LND_fnc_getRadius;
private _iedsPerPlayerPerZone = ["IEDsPerZone", 1] call BIS_fnc_getParamValue;
private _totalIEDs = _iedsPerPlayerPerZone*(count allPlayers);

// Create IED(s)
for "_i" from 1 to _totalIEDs do {


	// Create IED
	private _iedPos = [_pos, 0, _radius, 0.5, 0, 0, 0, [], [[0,0], [0,0]]] call BIS_fnc_findSafePos;
	if(_iedPos isEqualTo [0,0]) then { 
		// Ran out of safe places before we ran out of IEDs - panic!
		diag_log "[Warning] LND IEDD Training: Ran out of safe places to spawn IEDs";
		break;
	};

	private _iedType = selectRandom LND_iedd_iedClasses;
	private _ied = createVehicle [_iedType, _iedPos];

	if((["IndicatorArrow", 0] call BIS_fnc_getParamValue) == 1) then {
		private _arrow = createVehicle ["Sign_Arrow_Large_F", [_iedPos#0,_iedPos#1,4], [], 0, "CAN_COLLIDE"];
		_ied setVariable ["LND_iedd_arrow", _arrow];
		[{
			params ["_args", "_handle"];
			_args params ["_ied", "_arrow"];
			if(alive _arrow) then {
				private _iedPos = getPos _ied;
				_arrow setPos [_iedPos#0,_iedPos#1,4];
				_arrow setVectorUp [0,0,1];
			} else {
				[_handle] call CBA_fnc_removePerFrameHandler;
			};
		}, 1, [_ied, _arrow]] call CBA_fnc_addPerFrameHandler;
	};
	

	
	if(_iedType isEqualTo "C_Offroad_01_F") then {
		// TODO: include VBIEDs
		//[_ied, _variation, _pos, _dir, _up, _dud, _size, _isTimer, _timerTime, _isRandom, _distance, _isGetIn, _isEngineOn, _isMove, _speed] call iedd_vbied_fnc_setVbied;
	};


	// Set up variables
	_ied setVariable ["LND_iedd_defused", false]; // Stop players defusing the same (Training) IED over and over
	_ied setVariable ["iedd_ied_dud", 0, true];
	_ied setVariable ["iedd_ied_fake", 0, true];
	_ied setVariable ["iedd_ied_time",(["IEDTimerValue", 60] call BIS_fnc_getParamValue),true];
	_ied setVariable ["iedd_ied_timer",(["IEDTimer", 2] call BIS_fnc_getParamValue),true];


	LND_iedd_createdIEDs pushback _ied;
};

LND_iedd_IEDsRemaining = count LND_iedd_createdIEDs;
