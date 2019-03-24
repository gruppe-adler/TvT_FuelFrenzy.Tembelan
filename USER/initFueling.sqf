
[] call refuel_fnc_addRefuelCargoAction;
grad_refuel_rate = 10;

private _soundPath = [(str missionConfigFile), 0, -15] call BIS_fnc_trimString;
private _refuelingSoundPath = _soundPath + "USER\sounds\fueling.ogg";
private _refuelingSoundPathEnd = _soundPath + "USER\sounds\fueling_end.ogg";
missionNamespace setVariable ["FF_fuelingSound", _refuelingSoundPath];
missionNamespace setVariable ["FF_fuelingSoundEnd", _refuelingSoundPathEnd];

["ace_common_fueling", {
    params ["_sourceObject", "_amount", "_sinkObject"];

    private _liters = [_sinkObject] call ace_refuel_fnc_getFuel;
    hintSilent parseText ("<t color='#FF0000'><t size='2'><t align='center'>" + (str (floor _liters)) + "<br/><br/><t align='center'><t size='1'><t color='#ffffff'>Liter");

    private _refuelingSoundPath = missionNamespace getVariable ["FF_fuelingSound", ""];
    playSound3D [_refuelingSoundPath, _sourceObject, false, getPos _sourceObject, 10, 1, 100];
}] call CBA_fnc_addEventHandler;

["ace_common_addCargoFuelFinished", {
    // systemChat str _this;
    // diag_log str _this;
    params ["_sourceObject", "_startFuel", "_newFuel"];
    private _newPoints = _newFuel - _startFuel;
    private _refuelingSoundPathEnd = missionNamespace getVariable ["FF_fuelingSoundEnd", ""];
    playSound3D [_refuelingSoundPathEnd, _sourceObject, false, getPos _sourceObject, 10, 1, 100];

    systemChat ("made " + (str (_points + _newPoints)) + " points");

    if (_sourceObject == fuelSellPoint_west || _sourceObject == fuelSellPoint_east) then {
        [
            {
                private _fuelCount  = format ["%1", [side player] call (compile preprocessFileLineNumbers "USER\getFuelPoints.sqf")];
                private _totalPoints = format ["%1", [side player] call (compile preprocessFileLineNumbers "USER\getPoints.sqf")];
                hintSilent parseText ("
                        <t color='#009999'><t size='2'><t align='center'>" + _fuelCount + "<br/>
                        <t align='center'><t size='1'><t color='#ffffff'>L Treibstoff<br/><br/>
                        <t color='#009999'><t size='2'><t align='center'>" + _totalPoints + "<br/>
                        <t align='center'><t size='1'><t color='#ffffff'>Siegpunkte<br/><br/>");

            },
            [],
            1
        ] call CBA_fnc_waitAndExecute;
    };
}] call CBA_fnc_addEventHandler;


["mrk_safeZone_west", west] execVM "USER\safezone\createSafeZone.sqf";
["mrk_safeZone_east", east] execVM "USER\safezone\createSafeZone.sqf";

if (isServer) then {

        if (isServer) then {
            [fuelSellPoint_east, 0] call ace_refuel_fnc_makeSource;
            fuelSellPoint_east setVariable ["ace_refuel_fuelMaxCargo", 1000000, true];
            fuelSellPoint_east setVariable ["ace_refuel_cargoRate", 200, true];
            fuelSellPoint_east setVariable ["FF_sellingPoint", east, true];

            [fuelSellPoint_west, 0] call ace_refuel_fnc_makeSource;
            fuelSellPoint_west setVariable ["ace_refuel_fuelMaxCargo", 1000000, true];
            fuelSellPoint_west setVariable ["ace_refuel_cargoRate", 200, true];
            fuelSellPoint_west setVariable ["FF_sellingPoint", west, true];
        };

        private _fuelTrucksEast = entities "O_G_Van_01_fuel_F";
        private _fuelTrucksWest = entities "RHS_Ural_Fuel_VDV_01";

        private _fuelTrucks = _fuelTrucksEast + _fuelTrucksWest;

        {
          [_x, 0] call ace_refuel_fnc_setfuel;
          _x setVariable ["ace_refuel_fuelMaxCargo", 3000, true];
        } forEach _fuelTrucks;


        private _fuelStations = nearestTerrainObjects [[worldSize/2, worldSize/2], ["Fuelstation"], worldSize/2] select { !isObjectHidden _x};

        {
            private _fuelStation = _x;
            private _fuelCargo = 3000;
            private _position = position _fuelStation;
            _fuelStation setVariable ["ace_refuel_fuelMaxCargo", 3000, true];
            _fuelStation setVariable ["ace_refuel_currentFuelCargo", 3000, true];

            /*
            private _marker = createMarker [format ["fuelstation_%1", _position], _position];
            _marker setMarkerShape "ICON";
            _marker setMarkerType "hd_dot";
            */
        } forEach _fuelStations;

        missionNamespace setVariable ["FF_allFuelStations", _fuelStations, true];

        

        [] execVM "USER\winstats\checkWinConditions.sqf";
};
