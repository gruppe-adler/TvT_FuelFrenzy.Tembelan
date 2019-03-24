#define REFUEL_NOZZLE_ACTION_DISTANCE 2

private _cacheRefuelClasses = call (uiNamespace getVariable ["ace_refuel_cacheRefuelClasses", {[[],[]]}]);
_cacheRefuelClasses params [["_staticClasses", [], [[]]], ["_dynamicClasses", [], [[]]]];

private _fillCargoTankAction = [
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
    },{},nil,"",3,[false,false,false,false,false]
] call ace_interact_menu_fnc_createAction;


private _returnNozzleAction = [
    "ReturnNozzle",
    "Zapfpistole zurückstecken",
    "",
    {
        [player, _target] call ace_refuel_fnc_returnNozzle
    }, {
        [player, _target] call ace_refuel_fnc_canReturnNozzle
}] call ace_interact_menu_fnc_createAction;


["Land_BoreSighter_01_F", 0, ["ACE_MainActions"], _endPointAction, true] call ace_interact_menu_fnc_addActionToClass;
["Land_BoreSighter_01_F", 0, ["ACE_MainActions", "ace_refuel_Refuel"], _returnNozzleAction] call ace_interact_menu_fnc_addActionToClass;

{
    private _className = _x;
    {
        [_className, 0, ["ACE_MainActions", "ace_refuel_Refuel"], _x] call ace_interact_menu_fnc_addActionToClass;
    } forEach [_fillCargoTankAction, _returnNozzleAction];
} forEach _staticClasses;

{
    private _className = _x;
    {
        [_className, 0, ["ACE_MainActions", "ace_refuel_Refuel"], _x, true] call ace_interact_menu_fnc_addActionToClass;
    } forEach [_fillCargoTankAction, _returnNozzleAction];
} forEach _dynamicClasses;

[
    "ace_common_addCargoFuel",
    {
        params ["_tank", "_amount"];
         private _newValue = ([_tank] call ace_refuel_fnc_getFuel) + _amount;
        [_tank, _newValue] call ace_refuel_fnc_setFuel;
    }
] call CBA_fnc_addEventHandler;
