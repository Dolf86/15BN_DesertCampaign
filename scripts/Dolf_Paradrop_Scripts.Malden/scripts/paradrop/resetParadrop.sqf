dolf_resettato = true;
deleteVehicle dolf_pilota;
deleteVehicle dolf_aereoParadrop;

{
	// Current result is saved in variable _x
	deleteMarker _x;
} forEach dolf_markersPercorso;

[dolf_paradropOfficier] remoteExec ["removeAllActions",0];
[dolf_paradropOfficier, ["Prepara l'aereo per il paradrop", {[0,["scripts\paradrop\setupParadrop.sqf"] remoteExec["execVM",2]]}]] remoteExec ["addAction", 0, dolf_paradropOfficier];
