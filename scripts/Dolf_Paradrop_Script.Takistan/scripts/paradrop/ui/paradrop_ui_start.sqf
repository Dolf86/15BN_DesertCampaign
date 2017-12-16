dolf_paradropPlayersOnPlaneLabels = [];
dolf_paradropPlayersOnPlane = [];


dolf_paradrop_ui_start_picture_logo = ["Picture",

    ["Position",[16,0]],
    ["Picture","img\15bn_flag_512x256.paa"],
    ["Size",[8,6]]
] call Zen_CreateControl;

dolf_paradrop_ui_start_text_Label = ["Text",
    ["Text", "Paradrop start panel"],
    ["Position", [16, 7]],
    ["Size", [8,2]]
] call Zen_CreateControl;


dolf_paradrop_ui_start_button_Start = ["Button",

    ["Text", "Start"],

    ["Position", [16, 10]],
    ["Size", [8,2]],

    /**  This is a special type of property that doesn't affect how the button looks.  It allows the button to be event-driven; activation refers to when the button is clicked, and the function is given as a string.  You can use any global function here, including framework functions.  Zen_CloseDialog is provided by the dialog system, you should always use it to ensure the dialog closes properly. */
    ["ActivationFunction", "dolf_paradrop_ui_start_fnc_Start"]
] call Zen_CreateControl;


dolf_paradrop_ui_start_button_Close = ["Button",

    ["Text", "X"],

    ["Position", [25, 0]],
    ["Size", [2,2]],

    /**  This is a special type of property that doesn't affect how the button looks.  It allows the button to be event-driven; activation refers to when the button is clicked, and the function is given as a string.  You can use any global function here, including framework functions.  Zen_CloseDialog is provided by the dialog system, you should always use it to ensure the dialog closes properly. */
    ["ActivationFunction", "Zen_CloseDialog"]
] call Zen_CreateControl;


//DISABLED
dolf_paradrop_ui_start_list_PlayersOnPlane = ["List",

    ["Position", [1, 12]],
    ["Size", [8,17]],

    ["List", dolf_paradropPlayersOnPlaneLabels],
    ["ListData", dolf_paradropPlayersOnPlane]
] call Zen_CreateControl;

//DISABLED
dolf_paradrop_ui_start_map = ["Map",
	["Position",[9,1]],
	["Size",[30,38]]
] call Zen_CreateControl;

//DISABLED
dolf_paradrop_ui_start_button_RefreshPlayerList = ["Button",

    ["Text", "Refresh passenger list"],

    ["Position", [1, 10]],
    ["Size", [8,2]],

    ["ActivationFunction", "dolf_paradrop_ui_start_fnc_RefreshPlayerList"],
    ["LinksTo",[dolf_paradrop_ui_start_list_PlayersOnPlane]]
] call Zen_CreateControl;


dolf_paradrop_ui_start_fnc_Start = {
    0 = [] remoteExec ["dolf_paradrop_fnc_startParadrop", 2, false];
    0 = call Zen_CloseDialog;
};

dolf_paradrop_ui_start_fnc_RefreshPlayerList = {
    
    dolf_paradropPlayersOnPlaneLabels = [];
    dolf_paradropPlayersOnPlane = [];

    {        
        _unitName = name _x;

        
        [dolf_paradropPlayersOnPlane, _x] call Zen_ArrayAppend;

        if (!("Steerable_Parachute_F" in (vestItems _x + uniformItems _x + backpackItems _x + assignedItems _x))) then {
            _unitName = format ["%1 (SENZA PARACADUTE)", name _x];
        };

        hint "unitName:";
        sleep 1;
        hint _unitName;
        sleep 2;

        [dolf_paradropPlayersOnPlaneLabels, _unitName] call Zen_ArrayAppend;
        
    } forEach (crew dolf_aereoParadrop);

    [0, [dolf_paradrop_ui_start_list_PlayersOnPlane]] call Zen_RefreshDialog;
};

dolf_paradrop_ui_start_dialog = [] call Zen_CreateDialog;

{
    0 = [dolf_paradrop_ui_start_dialog, _x] call Zen_LinkControl;
} forEach [dolf_paradrop_ui_start_picture_logo, dolf_paradrop_ui_start_text_Label, dolf_paradrop_ui_start_button_Close, dolf_paradrop_ui_start_button_Start ];


dolf_paradrop_aereo addAction ["Paradrop control panel", {0 = [_this select 3] spawn Zen_InvokeDialog;}, dolf_paradrop_ui_start_dialog];