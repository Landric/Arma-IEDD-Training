
LND_iedd_iedClasses = if((["TrainingIEDs", 0] call BIS_fnc_getParamValue) == 0) then {
	[
		//"C_Offroad_01_F",
		"iedd_ied_Bucket", 
		"iedd_ied_Cardboard", 
		"iedd_ied_Cinder", 
		"iedd_ied_CanisterFuel", 
		"iedd_ied_Metal", 
		"iedd_ied_Metal_English", 
		"iedd_ied_Barrel", 
		"iedd_ied_Barrel_Grey", 
		"iedd_ied_CanisterPlastic"
	]
} else {
	[
		"iedd_ied_Training_Bucket", 
		"iedd_ied_Training_Cardboard", 
		"iedd_ied_Training_Cinder", 
		"iedd_ied_Training_CanisterFuel", 
		"iedd_ied_Training_Metal", 
		"iedd_ied_Training_Metal_English", 
		"iedd_ied_Training_Barrel", 
		"iedd_ied_Training_Barrel_Grey", 
		"iedd_ied_Training_CanisterPlastic"
	]
};

[] call LND_fnc_loadClutter;


LND_iedd_createdClutter = [];
LND_iedd_createdIEDs = [];
LND_iedd_IEDsRemaining = 0;
LND_iedd_createdUnits = [];

LND_iedd_iedsDefused = 0;



["iedd_ied_defused", {
    params ["_unit", "_object"];

    // Could just check if the varaible is not defined/set and default to "false"
    // instead of setting it to false when created and defaulting to "true" in this check;
    // Only benefit of doing it this way around is that it only counts the IEDs spawned by this mission as 
    // counting towards the mission complete
    if(!(_object getVariable ["LND_iedd_defused", true])) then {
    	_object setVariable ["LND_iedd_defused", true];
    	LND_iedd_iedsDefused = LND_iedd_iedsDefused + 1;
    	LND_iedd_IEDsRemaining = LND_iedd_IEDsRemaining - 1;
    	(format ["IED defused!\nTotal IEDs defused: %1", LND_iedd_iedsDefused]) remoteExec ["hint"];
    	deleteVehicle (_object getVariable ["LND_iedd_arrow", objNull]); // Remove the indicator arrow, if present
    	if(LND_iedd_IEDsRemaining <= 0) then {
    		[] spawn {
    			(format ["IED defused!\nTotal IEDs defused: %1\nMoving to next zone - stand by...", LND_iedd_iedsDefused]) remoteExec ["hint"];
    			sleep 5;
	    		[] call LND_fnc_newSector;
	    	};
    	};
    };
}] call CBA_fnc_addEventHandler;



// (This works for proximity detonations as well now - thanks @Prisoner!)
["iedd_ied_explosion", {
    params ["_target"];

    // If they're training IEDs, let them reset and try again
    if((["TrainingIEDs", 0] call BIS_fnc_getParamValue) != 0) exitWith {};

    // Else, boom!
	if(LND_iedd_iedsDefused == 1) then {
		"DETONATE" setDebriefingText ["Scenario Over", "Training complete! You successfully defused 1 IED. Play again and try to beat your highscore!", "IEDD Training Complete - 1 IED defused"];
	} else {
		"DETONATE" setDebriefingText ["Scenario Over", format ["Training complete! You successfully defused %1 IEDs. Play again and try to beat your highscore!", LND_iedd_iedsDefused], format["IEDD Training Complete - %1 IEDs defused", LND_iedd_iedsDefused]];
	};

    ["DETONATE", true] remoteExec ["BIS_fnc_endMission"];
}] call CBA_fnc_addEventHandler;



// Start the mission!
[] call LND_fnc_newSector;

