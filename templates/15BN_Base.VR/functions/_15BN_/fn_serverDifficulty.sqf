/*
	Description:
		Show server difficulty settings as CBA settings

	Parameter(s):
		None

	Returns:
		Nothing
		The settings are available in the CBA settings system

	Example:
		0 call ALEF_fnc_serverDifficulty
*/
//#define DEBUG_MODE_FULL
#define PREFIX ALEF
#define COMPONENT base
#define THIS_FILE fn_serverDifficulty.sqf
#include "\x\cba\addons\main\script_macros_common.hpp"
LOG("Begin");
{
	TRACE_2("difficulty/value", configName _x,difficultyOption configName _x );
	[
		 "ALEF_15BN_difficulty_" + configName _x
		,"LIST"
		,configName _x
		,"Server Difficulty"
		,[ [0,1,2], ["0","1","2"], difficultyOption configName _x]
		,1
		,{}
	] call CBA_Settings_fnc_init;
} foreach configProperties [configfile >> "CfgDifficultyPresets" >> "Custom" >> "Options"];
LOG("End");
