params [
    ["_side", sideUnknown]
];

private _fuelPoints = [_side] call (compile preprocessFileLineNumbers "USER\getFuelPoints.sqf");
private _infPointsPlayer = [_side, "Players killed"] call grad_points_fnc_getPointsCategory;
private _infPointsAI = [_side, "AI killed"] call grad_points_fnc_getPointsCategory;
private _infPoints = _infPointsAI + _infPointsPlayer;
private _softPoints = [_side, "VEHICLEKILLED"] call grad_points_fnc_getPointsCategory;

private _result = _fuelPoints + _infPoints + _softPoints;
// systemChat str _pointsCategorized;
// systemChat str _result;
// ["Kills",19],["Vehicles destroyed",10],["Other",5]

_result
