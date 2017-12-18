dolf_paradrop_MapPos = 0;
dolf_Map_WaypointNumber = 0;
dolf_paradrop_ui_waypoints_BUSY = false;

dolf_paradropWaypointsLabels = [];
dolf_paradropWaypoints = [];

dolf_paradrop_newAltitude = 2000;
dolf_paradrop_Airports = [1,0];
dolf_paradrop_AirportsLabels = ["Loy Manara","Rasman"];

dolf_paradrop_ui_waypoints_picture_logo = ["Picture",

    ["Position",[1,1]],
    ["Picture","img\15bn_flag_512x256.paa"],
    ["Size",[8,6]]
] call Zen_CreateControl;

dolf_paradrop_ui_waypoints_text_LabelParadrop = ["Text",
    ["Text", "Paradrop Waypoints"],
    ["Position", [1, 7]],
    ["Size", [8,2]]
] call Zen_CreateControl;

dolf_paradrop_ui_waypoints_list_Waypoints = ["List",

    ["List", dolf_paradropWaypointsLabels],
    ["ListData", dolf_paradropWaypoints],

    ["Position", [1, 10]],
    ["Size", [8,17]]
] call Zen_CreateControl;


dolf_paradrop_ui_waypoints_text_LabelLandinAirport = ["Text",
    ["Text", "Land at"],
    ["Position", [10, 1]],
    ["Size", [6,2]]
] call Zen_CreateControl;

dolf_paradrop_ui_waypoints_list_Airports = ["DropList",

    ["List", dolf_paradrop_AirportsLabels],
    ["ListData", dolf_paradrop_Airports],

    ["Position", [17, 1]],
    ["Size", [8,2]]
] call Zen_CreateControl;


dolf_paradrop_ui_waypoints_map_Position = ["Map",
	["Position",[9,4]],
	["Size",[30,34]],    
    ["Event",[["MOUSEBUTTONCLICK","dolf_ui_waypoints_fnc_MapClick"]]]
] call Zen_CreateControl;


dolf_paradrop_ui_waypoints_button_Start = ["Button",

    ["Text", "Start"],

    ["Position", [1, 36]],
    ["Size", [8,2]],

    /**  This is a special type of property that doesn't affect how the button looks.  It allows the button to be event-driven; activation refers to when the button is clicked, and the function is given as a string.  You can use any global function here, including framework functions.  Zen_CloseDialog is provided by the dialog system, you should always use it to ensure the dialog closes properly. */
    ["ActivationFunction", "dolf_ui_waypoints_fnc_ParadropSetupStart"],
    ["LinksTo",[dolf_paradrop_ui_waypoints_list_Airports]]
] call Zen_CreateControl;

dolf_paradrop_ui_waypoints_button_Close = ["Button",

    ["Text", "X"],

    ["Position", [37, 1]],
    ["Size", [2,2]],

    /**  This is a special type of property that doesn't affect how the button looks.  It allows the button to be event-driven; activation refers to when the button is clicked, and the function is given as a string.  You can use any global function here, including framework functions.  Zen_CloseDialog is provided by the dialog system, you should always use it to ensure the dialog closes properly. */
    ["ActivationFunction", "Zen_CloseDialog"]
] call Zen_CreateControl;

dolf_paradrop_ui_waypoints_button_MoveUp = ["Button",
    ["Text", "Move up"],
    ["Position", [1, 28]],
    ["Size", [8,2]],

    ["ActivationFunction", "dolf_ui_waypoints_fnc_MoveUp"],

    ["LinksTo", [dolf_paradrop_ui_waypoints_list_Waypoints]]
] call Zen_CreateControl;

dolf_paradrop_ui_waypoints_button_MoveDown = ["Button",
    ["Text", "Move down"],
    ["Position", [1, 30]],
    ["Size", [8,2]],

    ["ActivationFunction", "dolf_ui_waypoints_fnc_MoveDown"],

    ["LinksTo", [dolf_paradrop_ui_waypoints_list_Waypoints]]
] call Zen_CreateControl;

dolf_paradrop_ui_waypoints_button_Debug = ["Button",
    ["Text", "DEBUG"],
    ["Position", [32, 0]],
    ["Size", [8,1]],

    ["ActivationFunction", "dolf_ui_waypoints_fnc_Debug"],

    ["LinksTo", [dolf_paradrop_ui_waypoints_list_Waypoints]]
] call Zen_CreateControl;

dolf_paradrop_ui_waypoints_button_Reorder = ["Button",
    ["Text", "Reorder"],
    ["Position", [1, 32]],
    ["Size", [8,2]],

    ["ActivationFunction", "dolf_ui_waypoints_fnc_Reorder"],

    ["LinksTo", [dolf_paradrop_ui_waypoints_list_Waypoints]]
] call Zen_CreateControl;

dolf_paradrop_ui_waypoints_button_RemoveWaypoint = ["Button",
    ["Text", "Remove"],
    ["Position", [1, 34]],
    ["Size", [8,2]],

    ["ActivationFunction", "dolf_ui_waypoints_fnc_RemoveWaypoint"],
	["LinksTo", [dolf_paradrop_ui_waypoints_list_Waypoints]]

] call Zen_CreateControl;


dolf_ui_waypoints_fnc_MapClick = {        

    waitUntil {!dolf_paradrop_ui_waypoints_BUSY};
    dolf_paradrop_ui_waypoints_BUSY = true;

    waitUntil {
        (typeName dolf_paradrop_MapPos == "ARRAY")
    };

    _local_Map_Pos = dolf_paradrop_MapPos; 
    
    _markerText = format ["paradrop_wp_%1",dolf_Map_WaypointNumber];
    dolf_Map_WaypointNumber = dolf_Map_WaypointNumber + 1;
    
    _nuovoMarker = createMarkerLocal [_markerText, _local_Map_Pos];
	_nuovoMarker setMarkerType "hd_dot";
	_nuovoMarker setMarkerColor "ColorRed";
	_nuovoMarker setMarkerText _markerText;

    [dolf_paradropWaypoints, getMarkerPos _nuovoMarker] call Zen_ArrayAppend;
    [dolf_paradropWaypointsLabels, _markerText] call Zen_ArrayAppend;

    
    [0, [dolf_paradrop_ui_waypoints_list_Waypoints]] call Zen_RefreshDialog;
    
    dolf_paradrop_ui_waypoints_BUSY = false;
};

dolf_ui_waypoints_fnc_MoveUp = {

    waitUntil {!dolf_paradrop_ui_waypoints_BUSY};
    dolf_paradrop_ui_waypoints_BUSY = true;

    _wp = _this select 0;
     if (!(isNil "_wp")) then {
   
        if (count dolf_paradropWaypoints > 0) then {

            

            _i = [_wp, dolf_paradropWaypoints] call Zen_ValueFindInArray;
            _newIndex = _i - 1;
            
            if (_newIndex <0) then {
                _newIndex = 0;
            };

            [dolf_paradropWaypointsLabels,_newIndex,_i] call Zen_ArraySwapValues;
            [dolf_paradropWaypoints,_newIndex,_i] call Zen_ArraySwapValues;

            [0, [dolf_paradrop_ui_waypoints_list_Waypoints]] call Zen_RefreshDialog;
        };

        dolf_paradrop_ui_waypoints_BUSY = false;
    };
};

dolf_ui_waypoints_fnc_MoveDown = {

    waitUntil {!dolf_paradrop_ui_waypoints_BUSY};
    dolf_paradrop_ui_waypoints_BUSY = true;

    _wp = _this select 0;
    if (!(isNil "_wp")) then {

        if (count dolf_paradropWaypoints > 0) then {

            

            _i = [_wp, dolf_paradropWaypoints] call Zen_ValueFindInArray;
            _newIndex = _i + 1;
            
            if (_newIndex >= count dolf_paradropWaypointsLabels) then {
                _newIndex = count dolf_paradropWaypointsLabels - 1;
            };

            [dolf_paradropWaypointsLabels,_newIndex,_i] call Zen_ArraySwapValues;
            [dolf_paradropWaypoints,_newIndex,_i] call Zen_ArraySwapValues;

            [0, [dolf_paradrop_ui_waypoints_list_Waypoints]] call Zen_RefreshDialog;
        };

        dolf_paradrop_ui_waypoints_BUSY = false;
    };

};

dolf_ui_waypoints_fnc_RemoveWaypoint = {
    
    waitUntil {!dolf_paradrop_ui_waypoints_BUSY};
    dolf_paradrop_ui_waypoints_BUSY = true;
    
    
    _wp = _this select 0;

    if (!(isNil "_wp")) then {
        if (count dolf_paradropWaypointsLabels > 0 ) then {
            _i = [_wp, dolf_paradropWaypoints] call Zen_ValueFindInArray;

            _markerName = dolf_paradropWaypointsLabels select _i;

            deleteMarkerLocal _markerName;

            [dolf_paradropWaypoints, _i] call Zen_ArrayRemoveIndex;
            [dolf_paradropWaypointsLabels, _i] call Zen_ArrayRemoveIndex;

            [0, [dolf_paradrop_ui_waypoints_list_Waypoints]] call Zen_RefreshDialog;
        
        };
        
        if(count dolf_paradropWaypoints == 0) then {
            dolf_Map_WaypointNumber = 0;
        };        
    };
    dolf_paradrop_ui_waypoints_BUSY = false;
};

dolf_ui_waypoints_fnc_Reorder = {
    
    waitUntil {!dolf_paradrop_ui_waypoints_BUSY};
    dolf_paradrop_ui_waypoints_BUSY = true;
   
    _nWaypoints = count dolf_paradropWaypoints;

    {
        deleteMarkerLocal _x;
        
    } forEach dolf_paradropWaypointsLabels;

    for [{_i = 0},{_i < _nWaypoints},{_i = _i+1}] do {

        _markerText = format ["paradrop_wp_%1",_i];
        dolf_paradropWaypointsLabels set [_i,_markerText];
        _nuovoMarker = createMarkerLocal [_markerText, dolf_paradropWaypoints select _i];
	    _nuovoMarker setMarkerType "hd_dot";
	    _nuovoMarker setMarkerColor "ColorRed";
	    _nuovoMarker setMarkerText _markerText;

    };

    dolf_Map_WaypointNumber = _nWaypoints;

    [0, [dolf_paradrop_ui_waypoints_list_Waypoints]] call Zen_RefreshDialog;
    
    dolf_paradrop_ui_waypoints_BUSY = false;
};

dolf_ui_waypoints_fnc_ParadropSetupStart = {    

    [dolf_paradropWaypoints, dolf_paradropWaypointsLabels, _this select 0] remoteExec ["dolf_paradrop_fnc_setupParadrop", 2, false];
    0 = call Zen_CloseDialog;
};

dolf_ui_waypoints_fnc_Debug = {
    hint "LABELS";
    sleep 1;
    hint str dolf_paradropWaypointsLabels;
    sleep 5;
    hint "WAYPOINTS";
    sleep 1;
    hint str dolf_paradropWaypoints;
    sleep 5;
};



dolf_paradrop_ui_waypoints_dialog = [] call Zen_CreateDialog;

{
    0 = [dolf_paradrop_ui_waypoints_dialog, _x] call Zen_LinkControl;
} forEach [dolf_paradrop_ui_waypoints_list_Airports, dolf_paradrop_ui_waypoints_text_LabelLandinAirport, dolf_paradrop_ui_waypoints_button_Start,dolf_paradrop_ui_waypoints_text_LabelParadrop, dolf_paradrop_ui_waypoints_picture_logo,dolf_paradrop_ui_waypoints_list_Waypoints, dolf_paradrop_ui_waypoints_map_Position, dolf_paradrop_ui_waypoints_button_MoveUp,dolf_paradrop_ui_waypoints_button_MoveDown,dolf_paradrop_ui_waypoints_button_Reorder, dolf_paradrop_ui_waypoints_button_RemoveWaypoint, dolf_paradrop_ui_waypoints_button_Close];


dolf_paradropOfficier addAction ["Paradrop setup panel", {0 = [_this select 3] spawn Zen_InvokeDialog;}, dolf_paradrop_ui_waypoints_dialog];