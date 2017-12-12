//TROVO I MARKERS DEL TRAGITTO, LI AGGIUNGO ALL'ARRAY "dolf_markersPercorso", CONTO I MARKERS E HINT
if(!isServer) exitWith{};

if (DEBUG) then {
	["Start"] remoteExec ["hint",-2];
	sleep 2;
};


dolf_resettato = false;
[dolf_paradropOfficier] remoteExec ["removeAllActions",-2];

if (DEBUG) then {
	["Tolte action"] remoteExec ["hint",-2];
	sleep 2;
};


dolf_markersPercorso = [];
{
	// Current result is saved in variable _x
	_markerText = markerText _x;
	_isMarkerPercorso = ["paradrop",_markerText] call Zen_StringIsInString;
	
	if (DEBUG) then {	
		[_markerText] remoteExec ["hint",-2];
		sleep 2;
		[_isMarkerPercorso] remoteExec ["hint",-2];
		sleep 2;
	};


	if (_isMarkerPercorso) then {
		_nuovoMarker = createMarker [_markerText, getMarkerPos _x];
		_nuovoMarker setMarkerType "hd_dot";
		_nuovoMarker setMarkerColor "ColorRed";
		_nuovoMarker setMarkerText _markerText;
		0 = [dolf_markersPercorso,_nuovoMarker] call Zen_ArrayAppend;
		deleteMarker _x;
	};
} forEach allMapMarkers;

if (DEBUG) then {	
	["Riempito dolf_markersPercorso"] remoteExec ["hint",-2];
	sleep 2;
};


if (count dolf_markersPercorso == 0) exitWith {
	[dolf_paradropOfficier, ["Prepara l'aereo per il paradrop", {[0,["scripts\paradrop\setupParadrop.sqf"] remoteExec["execVM",2]]}]] remoteExec ["addAction", 0, dolf_paradropOfficier];

	if (DEBUG) then {
	["Nessun maker percorso, esco"] remoteExec ["hint",-2];
	sleep 2;
};

};


dolf_markersPercorso sort true;

_numeroMarkers = count dolf_markersPercorso;
hint format ["Numero marker: %1",_numeroMarkers];
sleep 2;
//------------------------------------------------------------

_pos = getMarkerPos "dolf_paradropstart";
_dir = markerDir "dolf_paradropstart";
dolf_aereoParadrop = [_pos, "RHS_C130J", 0, _dir,true] call Zen_SpawnVehicle;	
dolf_aereoParadrop setFuel 0;

//Spawn dolf_pilota
_pos = getMarkerPos "dolf_paradropPilotSpawn";
_dolf_pilotaGroup = [_pos, "rhsusf_airforce_pilot"] call Zen_SpawnGroup;
dolf_pilota = (units _dolf_pilotaGroup) select 0;

dolf_pilota assignAsDriver dolf_aereoParadrop;
[dolf_pilota] orderGetIn true;

[dolf_paradropOfficier, ["Reset paradrop", {[0,["scripts\paradrop\resetParadrop.sqf"] remoteExec["execVM",2]]}]] remoteExec ["addAction",0, dolf_paradropOfficier];

while {!(dolf_pilota in dolf_aereoParadrop)} do {
	sleep 3;
	hint "Aspetto il dolf_pilota";	
};


dolf_via = false;

[dolf_aereoParadrop, ["Avvia Paradrop", {[0,["scripts\paradrop\startParadrop.sqf"] remoteExec["execVM",2]]}]] remoteExec ["addAction", 0, dolf_aereoParadrop];

while {!dolf_via} do {
	sleep 1;	
	hint "Aspetto il via";		
};

if(dolf_resettato) exitWith{};

[dolf_paradropOfficier] remoteExec ["removeAllActions",0];

dolf_aereoParadrop setFuel 1;

[] execVM "scripts\paradrop\limitSpeedParadrop.sqf";

{
	0 = [dolf_aereoParadrop, _x, 'normal', dolf_altitudine, false, false] spawn Zen_OrderVehicleMove;
	hint format["Vado al marker: %1", markerText _x];
	_waypointPos = getMarkerPos _x;
	while {(_waypointPos distance2D dolf_aereoParadrop) > 100} do {
		sleep 3;
	};
} forEach dolf_markersPercorso;

if (alive dolf_aereoParadrop) then {
	dolf_aereoParadrop landAt dolf_numeroAeroporto;
};


while {speed dolf_aereoParadrop > 2} do {
	sleep 5;	 
};

deleteVehicle dolf_pilota;
deleteVehicle dolf_aereoParadrop;

{
	// Current result is saved in variable _x
	deleteMarker _x;
} forEach dolf_markersPercorso;

[dolf_paradropOfficier, ["Prepara l'aereo per il paradrop", {[0,["scripts\paradrop\setupParadrop.sqf"] remoteExec["execVM",2]]}]] remoteExec ["addAction",0, dolf_paradropOfficier];
