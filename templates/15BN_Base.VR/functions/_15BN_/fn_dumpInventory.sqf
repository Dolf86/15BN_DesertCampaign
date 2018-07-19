/*
	Description:
		Copy to clipboard a text version of the unit inventory
		Somethine like this:
			Peso: 23.21Kg
			Uniforme: FROG MARPAT-WD
			1 x Tappi
			10 x Bendaggio
			3 x Morfina
			1 x Adrenalina
			2 x Fascetta
			1 x GPS MicroDAGR
			1 x Strumenti cartografici
			1 x AN/PRC 343

			Giubbotto: SPC (Rifleman)
			1 x Fulton MX-991
			2 x AN-M8HC White smoke
			2 x M67 Frag. Grenade
			10 x 5.56mm M855A1 30rnd

			Zaino: Eagle A-III Coyote
			2 x M18 Green Smoke
			2 x M18 Red Smoke

			Arma:
			M4A1 + 5.56mm M855A1 30rnd + AN/PVQ-31A (ARD) + TD Vertical Grip

			Copricapo:
			LWH MARPAT-WD

	Parameter(s):
		Unit

	Example:
		[player] call ALEF_fnc_dumpInventory ;

	Returns:
		Nothing

*/

// #define DEBUG_MODE_FULL
#define PREFIX ALEF
#define COMPONENT base
#define THIS_FILE fn_dumpInventory.sqf
#include "\x\cba\addons\main\script_macros_common.hpp"

LOG("Begin");
params [["_unit", player]];
private ["_t", "_a","_c"]; _t = [];
_c = {
	params ["_a", "_cfg"];
	{ _t pushBack format [" %1 x %2", (_a select 1) select _forEachIndex, getText (configFile >> _cfg >> _x >> "displayName")];
	} forEach (_a select 0);
};

_t pushBack format ["Peso: %1", [_unit] call ace_common_fnc_getWeight ];
if (uniform _unit != "") then {
	_t pushBack format ["Uniforme: %1", getText (configFile >> "CfgWeapons" >> uniform _unit >> "displayName")];
	_a = getItemCargo uniformContainer _unit;     [_a, "CfgWeapons"] call _c;
	_a = getWeaponCargo uniformContainer _unit;   [_a, "CfgWeapons"] call _c;
	_a = getMagazineCargo uniformContainer _unit; [_a, "CfgMagazines"] call _c;
};

if (vest _unit != "") then {
	_t pushBack format ["Giubbotto: %1", getText (configFile >> "CfgWeapons" >> vest _unit >> "displayName")];
	_a = getItemCargo vestContainer _unit;     [_a, "CfgWeapons"] call _c;
	_a = getWeaponCargo vestContainer _unit;   [_a, "CfgWeapons"] call _c;
	_a = getMagazineCargo vestContainer _unit; [_a, "CfgMagazines"] call _c;
};

if (backpack _unit != "") then {
	_t pushBack format ["Zaino: %1", getText (configFile >> "CfgVehicles" >> backpack _unit >> "displayName")];
	_a = getItemCargo backpackContainer _unit;     [_a, "CfgWeapons"] call _c;
	_a = getWeaponCargo backpackContainer _unit;   [_a, "CfgWeapons"] call _c;
	_a = getMagazineCargo backpackContainer _unit; [_a, "CfgMagazines"] call _c;
};

if (primaryWeapon _unit != "") then {
	_t pushBack format ["Arma: %1", getText (configFile >> "CfgWeapons" >> primaryWeapon _unit >> "displayName")];
	{ _t pushBack format [" 1 x %1", getText (configFile >> "CfgMagazines" >> _x >> "displayName")];
	} forEach primaryWeaponMagazine _unit;
	{ if (_x != "") then {
		_t pushBack format [" 1 x %1", getText (configFile >> "CfgWeapons" >> _x >> "displayName")];
	};
	} forEach primaryWeaponItems _unit;
};

if (secondaryWeapon _unit != "") then {
	_t pushBack format ["Lanciarazzi: %1", getText (configFile >> "CfgWeapons" >> secondaryWeapon _unit >> "displayName")];
	{ _t pushBack format [" 1 x %1", getText (configFile >> "CfgMagazines" >> _x >> "displayName")];
	} forEach secondaryWeaponMagazine _unit;
	{ if (_x != "") then {
		_t pushBack format [" 1 x %1", getText (configFile >> "CfgWeapons" >> _x >> "displayName")];
	};
	} forEach secondaryWeaponItems _unit;
};

if (binocular _unit != "") then {
	_t pushBack format ["Binocolo: %1", getText (configFile >> "CfgWeapons" >> binocular _unit >> "displayName")];
};

if (headgear _unit != "") then {
	_t pushBack format ["Copricapo: %1", getText (configFile >> "CfgWeapons" >> headgear _unit >> "displayName")];
};

copyToClipboard (_t joinString toString [13,10]);
LOG("End");
