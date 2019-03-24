params ["_vehicle", "_side"];

if (!isServer) exitWith {};

_vehicle setVariable ["FF_originalSide", _side, true];

_vehicle addEventHandler ["Killed", {
        params ["_unit", "_killer", "_instigator", "_useEffects"];

        private _side = _unit getVariable ["FF_originalSide", sideUnknown];
        private _sideKiller = side _killer;
        if (_side != _sideKiller) then {
            _newPoints = [_sideKiller, 200, "VEHICLEKILLED"] call grad_points_fnc_addPoints;
        };
}];