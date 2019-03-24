if (!isServer) exitWith {};

params ["_vehicle"];

{
    _x params ["_type", "_turretpath", "_ammoCount", "_id", "_creator"];

    private _ammo = [configfile >> "CfgMagazines" >> _type >> "ammo", "string", ""] call CBA_fnc_getConfigEntry;
    private _splashDamage = [configfile >> "CfgAmmo" >> _ammo >> "indirectHit", "number", 0] call CBA_fnc_getConfigEntry;
    private _splashRange = [configfile >> "CfgAmmo" >> _ammo >> "indirectHitRange", "number", 0] call CBA_fnc_getConfigEntry;
    
    if (_splashRange > 3 && _splashDamage > 0) then {
        _vehicle removeMagazinesTurret [_type, _turretpath];
        diag_log format ["removing ammo %1 from %2, splash damage is %3 and range %4", 
        _ammo, _vehicle, _splashDamage, _splashRange];
    };

} forEach (magazinesAllTurrets _vehicle);