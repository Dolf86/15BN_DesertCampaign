if(!isServer) exitWith{};

DEBUG = false;

dolf_aereoParadropClassName = "RHS_C130J";
dolf_altitudine = 2000;
dolf_maxSpeed = 175;

//Ogni mappa ha numerato gli aeroporti, va trovato il numero dell'aeroporto su internet o per tentativi usando numeri interi partendo da 0.
//Per le portaerei è più complicato perché va creata una pista di atterraggio custom. Cercare sulla Wiki di ArmA per sapere come fare.
dolf_numeroAeroporto = 1;

dolf_paradropOfficier disableai "move";
[dolf_paradropOfficier, ["Prepara l'aereo per il paradrop", {[0,["scripts\paradrop\setupParadrop.sqf"] remoteExec["execVM",2]]}]] remoteExec ["addAction", 0, dolf_paradropOfficier];



