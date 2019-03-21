/*  Wird zum Missionsstart auf Server und Clients ausgeführt.
*   Funktioniert wie die init.sqf.
*/

[] call refuel_fnc_addRefuelCargoAction;
grad_refuel_rate = 25;


["ace_common_setCargoFuel", {
    systemChat str _this;
    diag_log str _this;
}] call CBA_fnc_addEventHandler;



["mrk_safeZone_west", west] execVM "USER\safezone\createSafeZone.sqf";
["mrk_safeZone_east", east] execVM "USER\safezone\createSafeZone.sqf";

if (isServer) then {

        if (isServer) then {
            [fuelSellPoint, 0] call ace_refuel_fnc_makeSource; 
            fuelSellPoint setVariable ["ace_refuel_fuelMaxCargo", 2000, true]; 
        };

        private _fuelTrucksEast = entities "O_G_Van_01_fuel_F";
        private _fuelTrucksWest = entities "RHS_Ural_Fuel_VDV_01";

        private _fuelTrucks = _fuelTrucksEast + _fuelTrucksWest;

        {
          [_x, 0] call ace_refuel_fnc_setfuel;
          _x setVariable ["ace_refuel_fuelMaxCargo", 3000];
        } forEach _fuelTrucks;


        private _fuelStations = nearestTerrainObjects [[worldSize/2, worldSize/2], ["Fuelstation"], worldSize/2] select { !isObjectHidden _x};

        // debug of detected stations
        {   
            private _fuelStation = _x;
            private _fuelCargo = 3000;
            private _position = position _fuelStation;
            _fuelStation setVariable ["ace_refuel_fuelMaxCargo", 3000];
            private _marker = createMarker [format ["fuelstation_%1", _position], _position];
            _marker setMarkerShape "ICON";
            _marker setMarkerType "DOT";
        } forEach _fuelStations;

};