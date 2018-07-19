//#define DEBUG_MODE_FULL
#define PREFIX BIS
#define COMPONENT event
#define THIS_FILE initPlayerLocal.sqf
#include "\x\cba\addons\main\script_macros_common.hpp"

LOG("Begin");
private ["_p", "_didJIP"];
_p = param [0, objNull];
_didJIP = param [1, false];

[] call ALEF_fnc_chestpack;
[] call ALEF_fnc_serverDifficulty;

hcRemoveAllGroups player;
["InitializePlayer", [player, true]] call BIS_fnc_dynamicGroups;
endLoadingScreen;
[["_15BN_Base","Istruzioni"],35,"",35,"",true,false,false,true] call BIS_fnc_advHint;


LOG("End");
