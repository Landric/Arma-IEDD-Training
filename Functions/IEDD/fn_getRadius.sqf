scriptName "LND\Functions\fn_getRadius.sqf";
/*
	Author:
		Landric

	Description:
		"Helper" function to calculate the radius of an IED zone, based on player and IED numbers
		Tries to get 1 IED per 2000 square meters (e.g. 1 IED = radius 25m (ish))

	Parameter(s):
		none
	Returns:
		none
	Example Usage:
		call LND_fnc_getRadius;
*/


sqrt((2000*(count allPlayers)*(["IEDsPerZone", 1] call BIS_fnc_getParamValue))/3.14) 