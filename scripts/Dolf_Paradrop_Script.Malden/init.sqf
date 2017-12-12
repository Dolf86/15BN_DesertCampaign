#include "Zen_FrameworkFunctions\Zen_InitHeader.sqf"

// Some functions may not continue running properly after loading a saved game, do not delete this line
enableSaving [false, false];
// Dolf Coop 1 by Dolf
// Version = 0.1
// Tested with ArmA 3 ???




// All clients stop executing here, do not delete this line
if (!isServer) exitWith {};
sleep 1;

// Enter the mission code here
[] execVM "scripts\paradrop\paradrop_init.sqf";