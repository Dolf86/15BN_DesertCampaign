// ------------------------
// Definisco i tipi di gruppi di unità da spawanare
// ------------------------
_groupClass_InfantryTeam = [
	"LOP_TKA_Infantry_TL",
	"LOP_TKA_Infantry_MG",
	"LOP_TKA_Infantry_MG_Asst",
	"LOP_TKA_Infantry_Rifleman",
	"LOP_TKA_Infantry_Rifleman_3",
	"LOP_TKA_Infantry_Corpsman"
	];

_groupClass_InfantryTeamSmall = [
	"LOP_TKA_Infantry_TL",
	"LOP_TKA_Infantry_MG",
	"LOP_TKA_Infantry_MG_Asst",
	"LOP_TKA_Infantry_Rifleman"
	];

_groupClass_InfantryTeamSentinel = [
	"LOP_TKA_Infantry_Rifleman_2",
	"LOP_TKA_Infantry_Rifleman_2"
	];


	
// ------------------------
// Creo le unità e ordino di pattugliare le strade
// ------------------------
for [{_i=0;}, {_i < 3;}, {_i = _i + 1;}] do {

	_pos = ["dolf_marker_escape"] call Zen_FindGroundPosition;
	_gruppo = [_pos, _groupClass_InfantryTeam] call Zen_SpawnGroup;
	[_gruppo, "dolf_marker_loymanara", [], [0,360], "normal","aware",true,false,false] spawn Zen_OrderInfantryPatrol;
	[dolf_gruppiNemici,_gruppo] call Zen_ArrayAppend;
};

sleep 1;

for [{_i=0;}, {_i < 6;}, {_i = _i + 1;}] do {

	_pos = ["dolf_marker_escape"] call Zen_FindGroundPosition;
	_gruppo = [_pos, _groupClass_InfantryTeamSmall] call Zen_SpawnGroup;
	[_gruppo, "dolf_marker_loymanara", [], [0,360], "normal","aware",true,false,false] spawn Zen_OrderInfantryPatrol;
	[dolf_gruppiNemici,_gruppo] call Zen_ArrayAppend;
};

sleep 1;


