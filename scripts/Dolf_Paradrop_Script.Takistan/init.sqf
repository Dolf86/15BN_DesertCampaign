#include "Zen_FrameworkFunctions\Zen_InitHeader.sqf"
enableSaving [false, false];


//Fai se client
0 = ["Dialog_Map_Click", "onMapSingleClick", {dolf_paradrop_MapPos = _pos}, []] call BIS_fnc_addStackedEventHandler;
[] execVM "scripts\paradrop\ui\paradrop_ui_waypoints.sqf";
[] execVM "scripts\paradrop\ui\paradrop_ui_start.sqf";
// All clients stop executing here, do not delete this line
if (!isServer) exitWith {};
sleep 1;

// Enter the mission code here

[] execVM "scripts\paradrop\paradrop_init.sqf";


