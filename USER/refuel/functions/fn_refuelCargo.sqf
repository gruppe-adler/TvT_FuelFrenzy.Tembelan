
/*
 * Refuels the fuel **source**
 * copied & adjusted from ACE3/addons/refuel/functions/fnc_refuel.sqf
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Vehicle <OBJECT>
 * 2: Nozzle <OBJECT>
 * 3: Connection Point <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [bob, kevin, nozzle, [2, 1, 5]] call ace_refuel_fnc_refuel
 *
 * Public: No
 */

/*
    prepare static object:
    this setVariable ["ace_refuel_cargoRate", 25];
    this setVariable ["ace_refuel_fuelMaxCargo", 10000];
*/

 #define REFUEL_INFINITE_FUEL -10

params [["_unit", objNull, [objNull]], ["_sink", objNull, [objNull]], ["_nozzle", objNull, [objNull]], ["_connectToPoint", [0,0,0], [[]], 3]];

private _config = configFile >> "CfgVehicles" >> typeOf _sink;

private _rate =  getNumber (_config >> "ace_refuel_flowRate") * grad_refuel_rate;

if (_rate == 0) then {
    _rate = _sink getVariable ["ace_refuel_cargoRate", 0];
};
private _maxFuel = _sink getVariable ["ace_refuel_fuelMaxCargo", 0]; // getNumber (_config >> "ace_refuel_fuelCargo")
private _startFuel = [_sink] call ace_refuel_fnc_getFuel;

[{
    params ["_args", "_pfID"];
    _args params [["_source", objNull, [objNull]], ["_sink", objNull, [objNull]], ["_unit", objNull, [objNull]], ["_nozzle", objNull, [objNull]], ["_rate", 1, [0]], ["_startFuel", 0, [0]], ["_maxFuel", 0, [0]], ["_connectFromPoint", [0,0,0], [[]], 3], ["_connectToPoint", [0,0,0], [[]], 3]];
    if !(_nozzle getVariable ["ace_refuel_isConnected", false]) exitWith {
        [_pfID] call CBA_fnc_removePerFrameHandler;
    };

    if (!alive _source || {!alive _sink}) exitWith {
        [objNull, _nozzle] call ace_refuel_fnc_dropNozzle;
        _nozzle setVariable ["ace_refuel_isConnected", false, true];
        if (_nozzle isKindOf "Land_CanisterFuel_F") then { _nozzle setVariable ["ace_cargo_canLoad", true, true]; };
        _nozzle setVariable ["ace_refuel_sink", nil, true];
        _sink setVariable ["ace_refuel_nozzle", nil, true];
        [_pfID] call CBA_fnc_removePerFrameHandler;
    };
    private _hoseLength = _source getVariable ["ace_refuel_hoseLength", ace_refuel_hoseLength];
    private _tooFar = ((_sink modelToWorld _connectToPoint) distance (_source modelToWorld _connectFromPoint)) > (_hoseLength - 2);
    if (_tooFar && {!(_nozzle getVariable ["ace_refuel_jerryCan", false])}) exitWith {
        ["too far away", 2, _unit] call ace_common_fnc_displayTextStructured;

        [objNull, _nozzle] call ace_refuel_fnc_dropNozzle;
        _nozzle setVariable ["ace_refuel_isConnected", false, true];
        if (_nozzle isKindOf "Land_CanisterFuel_F") then { _nozzle setVariable ["ace_cargo_canLoad", true, true]; };
        _nozzle setVariable ["ace_refuel_sink", nil, true];
        _sink setVariable ["ace_refuel_nozzle", nil, true];
        [_pfID] call CBA_fnc_removePerFrameHandler;
    };

    private _finished = false;
    private _rateTime = CBA_missionTime;
    private _fuelInSink = 0;

    private _fueling = _nozzle getVariable ["ace_refuel_isRefueling", false];
    if (_fueling) then {
        private _fuelInSource = [_source] call ace_refuel_fnc_getFuel;
        if (_fuelInSource == 0) exitWith {
            ["source tank is empty!", 2, _unit] call ace_common_fnc_displayTextStructured;
            _nozzle setVariable ["ace_refuel_lastTickMissionTime", nil];
            _nozzle setVariable ["ace_refuel_isRefueling", false, true];
        };

        // Calculate rate using mission time to take time acceleration and pause into account
        _rateTime = _rate * (CBA_missionTime - (_nozzle getVariable ["ace_refuel_lastTickMissionTime", CBA_missionTime]));
        _nozzle setVariable ["ace_refuel_lastTickMissionTime", CBA_missionTime];

        if !(_fuelInSource == REFUEL_INFINITE_FUEL) then {
            if (_rateTime > _fuelInSource) then {
                _rateTime = _fuelInSource;
                _fuelInSource = 0;
            } else {
                _fuelInSource = _fuelInSource - _rateTime;
            };
        } else {
            _source setVariable ["ace_refuel_fuelCounter", (_source getVariable ["ace_refuel_fuelCounter", 0]) + _rateTime, true];
        };

        _fuelInSink = (_unit getVariable ["ace_refuel_tempFuel", _startFuel]) + _rateTime;

        if (_fuelInSource <= 0 && {_fuelInSource > REFUEL_INFINITE_FUEL}) then {
            _fuelInSource = 0;
            _finished = true;
            ["source tank is empty!", 2, _unit] call ace_common_fnc_displayTextStructured;
        };
  
        if (_fuelInSink > _maxFuel) then {
            _fuelInSink = _maxFuel;
            _finished = true;
            ["refueling completed", 2, _unit] call ace_common_fnc_displayTextStructured;
            
        };
        _unit setVariable ["ace_refuel_tempFuel", _fuelInSink];
        ["ace_common_addCargoFuel", [_sink, _rateTime], _unit] call CBA_fnc_targetEvent;
        [_source, _fuelInSource] call ace_refuel_fnc_setFuel;
    } else {       
        diag_log "not fueling";
        _unit setVariable ["ace_refuel_tempFuel", [_sink] call ace_refuel_fnc_getFuel];
    };
    diag_log "refuelSource2";
    if (_finished) exitWith {
        _nozzle setVariable ["ace_refuel_lastTickMissionTime", nil];
        _nozzle setVariable ["ace_refuel_isRefueling", false, true];
        ["ace_common_addCargoFuelFinished", [_sink, _startFuel, _fuelInSink], _unit] call CBA_fnc_targetEvent;
    };
}, 1, [
    _nozzle getVariable "ace_refuel_source",
    _sink,
    _unit,
    _nozzle,
    _rate,
    _startFuel,
    _maxFuel,
    _nozzle getVariable ["ace_refuel_attachPos", [0,0,0]],
    _connectToPoint
]] call CBA_fnc_addPerFrameHandler;