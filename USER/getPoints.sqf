params [
    ["_side", sideUnknown]
];

private _fuelPoints = [_side] call (compile preprocessFileLineNumbers "USER\getFuelPoints.sqf");

_fuelPoints
