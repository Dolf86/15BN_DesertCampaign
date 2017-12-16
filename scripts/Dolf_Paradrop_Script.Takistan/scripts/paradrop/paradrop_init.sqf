//Parametri (da fare: selezionabili da UI)

dolf_paradrop_Altitudine = 1000;
dolf_paradrop_MaxSpeed = 150;
dolf_paradrop_landAt = 1;


//INIT
dolf_paradropOfficier disableai "move";
dolf_paradrop_go = false;
dolf_paradrop_started = false;

dolf_paradrop_aereo_startPos = getPos dolf_paradrop_aereo;
dolf_paradrop_aereo_startDir = getDir dolf_paradrop_aereo;

dolf_paradrop_pilota_startPos = getPos dolf_paradrop_pilota;
dolf_paradrop_pilota_startDir = getDir dolf_paradrop_pilota;


//FUNCTIONS

dolf_paradrop_fnc_setupParadrop = {

	if (dolf_paradrop_started) exitWith {};
	dolf_paradrop_started = true;

	_dolf_paradropWaypoints = _this select 0;
	_dolf_paradropWaypointsLabels = _this select 1;

	if (count _dolf_paradropWaypoints == 0) exitWith { hint "Nessun waypoint"};


	dolf_paradrop_aereo setPos dolf_paradrop_aereo_startPos;
	dolf_paradrop_aereo setDir dolf_paradrop_aereo_startDir;
	dolf_paradrop_aereo setDamage 0;


	dolf_paradrop_pilota setPos dolf_paradrop_pilota_startPos;
	dolf_paradrop_pilota setDir dolf_paradrop_pilota_startDir;


	dolf_paradrop_aereo setFuel 0;

	_numeroMarkers = count _dolf_paradropWaypoints;
	hint format ["Numero marker: %1",_numeroMarkers];
	sleep 1;

	dolf_paradrop_go = false;
	dolf_paradrop_pilota assignAsDriver dolf_paradrop_aereo;
	[dolf_paradrop_pilota] orderGetIn true;
	

	while {!(dolf_paradrop_pilota in dolf_paradrop_aereo)} do {
		sleep 3;		
	};

	while {!dolf_paradrop_go} do {
		sleep 3;	
		hint "Aspetto il via";		
	};


	dolf_paradrop_aereo setFuel 1;

	[] execVM "scripts\paradrop\limitSpeedParadrop.sqf";

	{
		_movimento = [dolf_paradrop_aereo, _x, 'normal', dolf_paradrop_Altitudine, false, false] spawn Zen_OrderVehicleMove;
			
		waitUntil { scriptDone _movimento; };			

	} forEach _dolf_paradropWaypoints;

	if (alive dolf_paradrop_aereo) then {
		dolf_paradrop_aereo landAt dolf_paradrop_landAt;
	};

	{
		// Current result is saved in variable _x
		deleteMarker _x;
	} forEach _dolf_paradropWaypointsLabels;

	_dolf_paradropWaypoints = [];
	_dolf_paradropWaypointsLabels = [];

	dolf_paradrop_go = false;
	dolf_paradrop_started = false;
};

dolf_paradrop_fnc_startParadrop = {
	dolf_paradrop_go = true;
};

dolf_paradrop_fnc_createUIStart = {
	0 = [] execVM "scripts\paradrop\ui\paradrop_ui_start.sqf";
}

