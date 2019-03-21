#define DOUBLES(var1,var2) ##var1##_##var2
#define QUOTE(var) #var
#define QGVAR(var) QUOTE(DOUBLES(ace_refuel,var))
#define FUNC(var) ace_refuel_fnc_##var

params [["_unit", objNull, [objNull]], ["_nozzle", objNull, [objNull]]];

if (isNull _unit  ||
    {isNull _nozzle} ||
    {!(_unit isKindOf "CAManBase")} ||
    {!local _unit}) exitWith {false};

!(_nozzle getVariable [QGVAR(isRefueling), false]) &&
    {[_nozzle getVariable QGVAR(source)] call FUNC(getFuel) != 0} &&
    {!isNull (_nozzle getVariable [QGVAR(sink), objNull])}
