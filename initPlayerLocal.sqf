params ["_player", "_didJIP"];

// Set up "Diary"
_player createDiaryRecord ["Diary", ["IEDD Training", "Welcome to IEDD Training!<br/><br/>Practice defusing an infinite amount of explosive devices in order to hone your skills in a variety of situations.<br/><br/>Some important tips:<br/>Make sure to always consult your defusal notebook - open it with Ctrl+Windows and navigate to 'Equipment'<br/>WALK(!) in the presence of explosive devices<br/>If you see a watch attached to an IED, that's a good indication that a timer will start once you cut the first wire<br/>Sometimes you'll fail to cut a wire! Make sure the wire is fully cut before proceeding<br/>Watch out for ambushes - insurgents will often stake out IEDs and wait for friendly to try and disarm them<br/><br/>This training mission would not be possible without the excellent IEDD Notebook mod"]];

// Set up equipment
if((["MinesweeperItem", 1] call BIS_fnc_getParamValue) == 1) then {
	_player addItem "MineDetector";
};
if((["AceMinesweeperItem", 1] call BIS_fnc_getParamValue) == 1) then {
	_player addWeapon "ACE_VMM3";
};
if((["NVGItem", 1] call BIS_fnc_getParamValue) == 1) then {
	_player addItem "NVGoggles";
	_player assignItem "NVGoggles";
};
if((["TorchItem", 1] call BIS_fnc_getParamValue) == 1) then {
	_player addPrimaryWeaponItem "acc_flashlight";
};


// Move player
if(_didJIP && !isNil "LND_iedd_startPos") then {
	_player setPos LND_iedd_startPos;
};