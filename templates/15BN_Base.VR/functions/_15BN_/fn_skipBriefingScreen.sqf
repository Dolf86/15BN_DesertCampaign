// #define DEBUG_MODE_FULL
/*
	Description:
		Clicks the "CONTINUE" button in an MP game
		Adapted from http://killzonekid.com/arma-scripting-tutorials-how-to-skip-briefing-screen-in-mp/

	Parameter(s):
		Nothing

	Example:
		from preInit EH

	Returns:
		Nothing

*/
#define PREFIX BIS
#define COMPONENT event
#define THIS_FILE fn_skipBriefingScreen.sqf
#include "\x\cba\addons\main\script_macros_common.hpp"

LOG("Begin");
if (hasInterface) then {
    if (!isNumber (missionConfigFile >> "briefing")) exitWith {};
    if (getNumber (missionConfigFile >> "briefing") == 1) exitWith {};
    ["ALEF_15BN_CLICK_CONTINUE", "onEachFrame", { // TODO this break TFAR
	// "MISSION RECEIVED"
	// "GAME LOADED"
	// "BRIEFING SHOWN"
	// cancel: "MISSION ASKED"
	switch (getClientState) do {
	    case "MISSION ASKED"; // CANCEL
	    case "LOGGED IN"; // in 3DEN 
	    case "NONE": // SP
		{ ["ALEF_15BN_CLICK_CONTINUE", "onEachFrame"] call BIS_fnc_removeStackedEventHandler; };
	    case "BRIEFING SHOWN": // here
		{
		    if (!isNull findDisplay 52) then {
			ctrlActivate (findDisplay 52 displayCtrl 1);
			findDisplay 52 closeDisplay 1;
			startLoadingScreen ["Attendere prego ..."];
			["ALEF_15BN_CLICK_CONTINUE", "onEachFrame"] call BIS_fnc_removeStackedEventHandler;
		    };
		};
	};
    }] call BIS_fnc_addStackedEventHandler;
};
LOG("End");
