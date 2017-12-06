//Esci se non sono sul server
if (!isServer) exitWith {};

// ------------------------
// Rendo invisibili le fortificazioni
// ------------------------

_areaFortificazionePos = getMarkerPos "dolf_marker_Fortificazioni";
_raggio = (getMarkerSize "dolf_marker_Fortificazioni") select 0;

_oggetti = _areaFortificazionePos nearObjects _raggio; //Ritorna tutti gli oggetti vicino, ma anche gli oggetti della mappa (case ecc.)
_oggettiAmbiente = nearestTerrainObjects [_areaFortificazionePos, [], _raggio]; //ritorna solo gli oggetti dell mappa

{
	[_oggetti,_x] call Zen_ArrayRemoveValue;	
} forEach _oggettiAmbiente; //tolgo gli oggetti dell mappa all'array di tutti gli oggetti per ottenere solo le fortificazioni

{
	_x hideObjectGlobal true;	
} forEach _oggetti;

// ------------------------
// Spawn truppe iniziali
// ------------------------
_script_spawnUnita = [] execVM "scripts\conquestandhold\spawnUnita.sqf";
waitUntil {scriptDone _script_spawnUnita};


// ------------------------
// Conto le IA vive tra quelle spawnate, se sono meno di 5 le faccio scappare se no aspetto
// ------------------------
_numeroNemici = 100;

while {_numeroNemici > 5 } do {	
	_numeroNemici = 0;
	{
		_gruppoIesimo = _x;
		{
			_y = _x;
			if (alive _y) then {
				_numeroNemici = _numeroNemici + 1;
			};			
		} forEach (units _gruppoIesimo);
		
	} forEach dolf_gruppiNemici;
	hint str _numeroNemici;
	sleep 5;		
};

{
	// Current result is saved in variable _x
	[_x, "dolf_marker_escape", [], [0,360], "full","combat",true,false,false] spawn Zen_OrderInfantryPatrol;
} forEach dolf_gruppiNemici;

// ------------------------
// Spawn elicotteri trasporto, portano fortificazioni su marker "dolf_marker_Fortificazioni", se ne vanno
// ------------------------
_startPos = getPos dolf_elicotteroTrasporto;
_dropPos = getMarkerPos "dolf_marker_dropMaterials";


_trasportoInCorso = [dolf_elicotteroTrasporto, dolf_container, _dropPos] spawn Zen_OrderSlingLoad;
waitUntil { scriptDone _trasportoInCorso };


[dolf_elicotteroTrasporto, _startPos, "full", 40, false,true] spawn Zen_OrderHelicopterLand;

sleep 90;

// ------------------------
// Tempo avanti 24 ore e rendo visibili le fortificazioni
// ------------------------

sleep 2;
titleText ["Il giorno dopo...", "BLACK IN", 2];
sleep 2;
skipTime 24;
titleText ["Il giorno dopo...", "BLACK FADED", 2];

{
	deleteGroup _x;	
} forEach dolf_gruppiNemici;

deleteVehicle dolf_container;
{
	_x hideObjectGlobal false;	
} forEach _oggetti;

titleFadeOut 2;

// ------------------------
// Spawn truppe rinforzi
// ------------------------
_script_spawnUnita = [] execVM "scripts\conquestandhold\spawnRinforzi.sqf";

