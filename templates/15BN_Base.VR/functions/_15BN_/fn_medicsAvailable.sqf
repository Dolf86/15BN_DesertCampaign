// #define DEBUG_MODE_FULL
/*
	Description:
		Checks if all player medics are alive. 
		If not, warns all unconscious units.
		Only from server.

	Parameter(s):
		Nothing

	Example:
		from initServer.sqf: call ALEF_fnc_medicsAvailable ;

	Returns:
		Nothing

*/

#define PREFIX ALEF
#define COMPONENT base
#define THIS_FILE fn_medicsAvailable.sqf
#include "\x\cba\addons\main\script_macros_common.hpp"

LOG("Begin");
private ["_us", "_m", "_u"];
_us = [];
scopeName "main";
{
	_m = [_x] call ACE_Medical_fnc_isMedic;
	_u = !([_x] call ACE_common_fnc_isAwake);
	TRACE_3("unit, isMedic, isUnc: ", _x, _m, _u);
	if (_u) then { _us = _us + [_x] ; };
	if ( _m && ! _u ) then {breakOut "main";} ;
} foreach call BIS_fnc_listPlayers;
{
	TRACE_1("Nessun medico to ", _x);
	[ ["Nessun medico"],
	  "BIS_fnc_infoText",
	  _x
	] call BIS_fnc_MP;
} foreach _us;
LOG("End");
