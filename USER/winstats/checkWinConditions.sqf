if (!isServer) exitWith {};

private _fuelTrucksEast = entities "O_G_Van_01_fuel_F";
private _fuelTrucksWest = entities "RHS_Ural_Fuel_VDV_01";

private _allFuelTrucks = (_fuelTrucksWest + _fuelTrucksEast);

[{

    params ["_args", "_handle"];
    _args params ["_allFuelTrucks"];

    private _fuelStations = missionNamespace getVariable ["FF_allFuelStations", []];
    private _fuelStationsAreEmpty = true;
    private _allFuelTrucksDestroyedOrEmpty = false;
    private _allTrucksDestroyed = count (_allFuelTrucks select { (!(canMove _x)) })  == count _allFuelTrucks;

    {
        if (_x getVariable ["ace_refuel_currentFuelCargo", 0] > 1) exitWith {
        // if ([_x] call ace_refuel_fnc_getFuel > 1) exitWith {
            _fuelStationsAreEmpty = false;
        };
    } forEach _fuelStations;

    if (_allTrucksDestroyed) exitWith {
         ["USER\winstats\showStats.sqf"] remoteExec ["execVM", 0, true];
        systemChat "all trucks destroyed or empty";
        diag_log "all trucks destroyed or empty";
        [_handle] call CBA_fnc_removePerFrameHandler;
    };

    if (_fuelStationsAreEmpty) then {
        systemChat "all fuel stations are empty";
        diag_log "all fuel stations are empty";

        private _trucksStillRunning = count (_allFuelTrucks select { (canMove _x) && (_x getVariable ["ace_refuel_currentFuelCargo", 0] > 1) }) > 0;
        
        if (!_trucksStillRunning) then {
            ["USER\winstats\showStats.sqf"] remoteExec ["execVM", 0, true];
            systemChat "all trucks destroyed or empty";
            diag_log "all trucks destroyed or empty";
            [_handle] call CBA_fnc_removePerFrameHandler;
        };
    };
    
}, 1, [_allFuelTrucks]] call CBA_fnc_addPerFramehandler;