#include "Zen_FrameworkFunctions\Zen_InitHeader.sqf"
enableSaving [false, false];

// -------------------------------
// Codice eseguito dal server e dai clients
// -------------------------------





// -------------------------------
// Codice termine dello script per i clients
// -------------------------------
if (!isServer) exitWith {};
sleep 1;



// -------------------------------
// Codice eseguito solo dal server
// -------------------------------
[] execVM "scripts\scripts_init.sqf";