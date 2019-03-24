/*  Wird zum Missionsstart auf Server und Clients ausgeführt.
*   Funktioniert wie die init.sqf.
*/

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
                        <t color='#009999'><t size='2'><t align='left'>" + _fuelCount + "</t><br/>
                        <t size='1'><t align='left'><t color='#ffffff'>L Treibstoff</t><br/><br/>
                        <t color='#009999'><t size='2'><t align='left'>" + _totalPoints + "</t><br/>
                        <t size='1'><t align='left'><t color='#ffffff'>Siegpunkte</t><br/>");
               
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


        TIME_OF_DAY = ["TIME_OF_DAY", 10] call BIS_fnc_getParamValue;
        publicVariable "TIME_OF_DAY";

        WEATHER_OVERCAST = ["WEATHER_OVERCAST", -1] call BIS_fnc_getParamValue;
        publicVariable "WEATHER_OVERCAST";

        WEATHER_FOG = ["WEATHER_FOG", -1] call BIS_fnc_getParamValue;
        publicVariable "WEATHER_FOG";

        WEATHER_WIND = ["WEATHER_WIND", -1] call BIS_fnc_getParamValue;
        publicVariable "WEATHER_WIND";

        setCustomWeather = {

          // get random shit
          if (str WEATHER_OVERCAST isEqualTo "-1") then {
            WEATHER_OVERCAST = [[
            0.0,
            0.1,
            0.2,
            0.3,
            0.4,
            0.5,
            0.6,
            0.7,
            0.8,
            0.9,
            1.0
            ], [
            0.3,
            0.3,
            0.1,
            0.1,
            0.05,
            0.025,
            0.025,
            0.025,
            0.025,
            0.025,
            0.025]] call BIS_fnc_selectRandomWeighted;
          };

          if (str WEATHER_FOG isEqualTo "-1") then {
            WEATHER_FOG = [[
            0.0,
            0.05,
            0.1,
            0.2,
            0.3,
            0.4,
            0.5,
            0.6,
            0.7,
            0.8,
            1.0
            ], [
            0.5,
            0.3,
            0.1,
            0.075,
            0.01,
            0.005,
            0.005,
            0.004,
            0.003,
            0.002,
            0.001]] call BIS_fnc_selectRandomWeighted;
          };

          if (str WEATHER_WIND isEqualTo "-1") then {
            WEATHER_WIND = (random 2) - (random 4);
          };

          diag_log format ["BC setup: setting wind to %1", WEATHER_WIND];

          // basics
          10 setOvercast WEATHER_OVERCAST;
          10 setFog WEATHER_FOG;
          setWind [WEATHER_WIND, WEATHER_WIND, true];
          10 setWindForce 0.1;

          // add specials dependent on values
          if (WEATHER_OVERCAST > 0.5 && WEATHER_OVERCAST < 0.8) then {
            10 setRain 0.5;
            10 setRainbow 0.8;
          };

          if (WEATHER_OVERCAST >= 0.8) then {
            10 setRain 1;
            10 setLightnings 0.8;
          };

          // enforce changes
          forceWeatherChange;
        };


        // allow view distance to be up to 10k

        // set to full moon date
        setDate [2015, 2, 1, TIME_OF_DAY, 1]; // set to 5:00 for perfect full moon

        call setCustomWeather;
};