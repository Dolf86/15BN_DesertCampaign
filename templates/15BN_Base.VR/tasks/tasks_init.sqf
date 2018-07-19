/* 

Task System
https://community.bistudio.com/wiki/Arma_3_Tasks_Overhaul


*/

if(!isServer) exitWith {};

//TASK
_owner = "WEST";
_taskid = "task_1";
_marker = "dolf_marker_task_1";

_testo =[
	"Descrizione del task",
	"Titolo del task",
	_marker
];

_destinazione = _marker;
_taskCorrente = true;
_priorita = 1;
_mostraNotifiche = true;
_tipoTask = "move"; 


[_owner, _taskid, _testo, _destinazione, _taskCorrente, _priorita, _mostraNotifiche, _tipoTask, false] call BIS_fnc_taskCreate;
