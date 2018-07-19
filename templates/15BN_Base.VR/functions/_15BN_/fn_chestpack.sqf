// #define DEBUG_MODE_FULL
#define PREFIX ALEF
#define COMPONENT base
#define THIS_FILE fn_chestpack.sqf
#include "\x\cba\addons\main\script_macros_common.hpp"

_BPoC = ["BackPack_on_Chest", "Backpack on chest"
	,"a3\ui_f\data\map\VehicleIcons\iconbackpack_ca.paa"
	, { // statement
		private _container = "Weapon_Empty" createVehicleLocal [0,0,0];
		ACE_player setVariable [QGVAR(container), _container];
		private _chestpack = createSimpleObject [backpack ACE_player, AGLtoASL position player];
		ACE_player setVariable [QGVAR(chestpack), _chestpack];
		ACE_player action ["DropBag", _container, backpack ACE_player];
		_chestpack attachTo [ACE_player, [0,-.06,-.6], "spine3"];
		_chestpack setVectorDirAndUp [ [0,-1,0], [0,0,1] ];
	} , { // condition
		(vehicle ACE_player == ACE_player) &&
		("" != backpack ACE_player) &&  
		{ isNull (ACE_player getVariable [QGVAR(chestpack), objNull]) }
	}
] call ace_interact_menu_fnc_createAction;

_CPoB = ["ChestPack_on_Back", "Chestpack on back" 
	,"a3\ui_f\data\map\VehicleIcons\iconbackpack_ca.paa"
	, { // statement
		private _container = ACE_player getVariable QGVAR(container);
		private _backpack = firstbackpack _container; 
		ACE_player addEventHandler ["AnimDone", {
			TRACE_1("AnimDone", _this);
			private _container = ACE_player getVariable QGVAR(container);
			if (isNull firstbackpack _container) then {
				deleteVehicle _container;
				private _chestpack = ACE_player getVariable QGVAR(chestpack);
				detach _chestpack; deleteVehicle _chestpack;
				ACE_player removeEventHandler ["AnimDone", _thisEventHandler];
			};
		}];
		ACE_player action ["TakeBag", _backpack];
	} , { // condition
		(vehicle ACE_player == ACE_player) &&
		("" == backpack ACE_player) && 
		{! isNull (ACE_player getVariable [QGVAR(chestpack), objNull]) }
	}
] call ace_interact_menu_fnc_createAction;

[(typeOf ACE_player), 1, ["ACE_SelfActions"], _BPoC] call ace_interact_menu_fnc_addActionToClass;
[(typeOf ACE_player), 1, ["ACE_SelfActions"], _CPoB] call ace_interact_menu_fnc_addActionToClass;

GVAR(GetInMan) = ACE_player addEventHandler ["GetInMan", {
	(ACE_player getVariable [QGVAR(chestpack), objNull]) hideObject true;
}];
GVAR(GetOutMan) = ACE_player addEventHandler ["GetOutMan", {
	(ACE_player getVariable [QGVAR(chestpack), objNull]) hideObject false;
}];
