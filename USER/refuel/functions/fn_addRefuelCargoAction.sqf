#define REFUEL_NOZZLE_ACTION_DISTANCE 2

private _action = [
    "RefuelStorage",
    "Tankwagenkessel befüllen",
    "",
    {
        private _virtualPosASL = (eyePos player) vectorAdd (positionCameraToWorld [0,0,0.6]) vectorDiff (positionCameraToWorld [0,0,0]);
        [
            player,
            _target,
            _virtualPosASL,
            player getVariable ["ace_refuel_nozzle", objNull]
        ] call refuel_fnc_connectAndRefuelCargo;
    }, {
        private _nozzle = player getVariable ["ace_refuel_nozzle", objNull];
        !(isNull _nozzle)/* && ((player distance _target) <= REFUEL_NOZZLE_ACTION_DISTANCE)*/ && !(_nozzle getVariable ["ace_refuel_isConnected", false])
    }] call ace_interact_menu_fnc_createAction;


private _endPointAction = [
    "RefuelStorage",
    "Treibstoff verkaufen",
    "",
    {
        private _virtualPosASL = (eyePos player) vectorAdd (positionCameraToWorld [0,0,0.6]) vectorDiff (positionCameraToWorld [0,0,0]);
        [
            player,
            _target,
            _virtualPosASL,
            player getVariable ["ace_refuel_nozzle", objNull]
        ] call refuel_fnc_connectAndRefuelCargo;
    }, {
        private _nozzle = player getVariable ["ace_refuel_nozzle", objNull];
        !(isNull _nozzle)/* && ((player distance _target) <= REFUEL_NOZZLE_ACTION_DISTANCE)*/ && !(_nozzle getVariable ["ace_refuel_isConnected", false])
    },{},nil,"",3,[false,false,false,false,false]] call ace_interact_menu_fnc_createAction;

[
    "Car", /*"StorageBladder_base_F"*/
    0,
    ["ACE_MainActions"],
    _action,
    true
] call ace_interact_menu_fnc_addActionToClass;

// helper object
[
    "Land_BoreSighter_01_F",
    0,
    ["ACE_MainActions"],
    _endPointAction,
    true
] call ace_interact_menu_fnc_addActionToClass;




[
    "ace_common_addCargoFuel",
    {
        params ["_sink", "_amount"];
        diag_log "yay fueling";
         private _newValue = ([_sink] call ace_refuel_fnc_getFuel) + _amount;
        [_sink, _newValue] call ace_refuel_fnc_setFuel;
    }
] call CBA_fnc_addEventHandler;
