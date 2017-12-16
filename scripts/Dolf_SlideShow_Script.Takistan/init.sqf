#include "Zen_FrameworkFunctions\Zen_InitHeader.sqf"
enableSaving [false, false];


if (!isServer) exitWith {};
sleep 1;

// Enter the mission code here

[] execVM "scripts\slideshow\slideshow_init.sqf";


