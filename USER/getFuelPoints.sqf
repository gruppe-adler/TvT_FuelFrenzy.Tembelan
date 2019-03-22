params [
    ["_side", sideUnknown]
];
switch (_side) do {
    case blufor: {[fuelSellPoint_west] call ace_refuel_fnc_getFuel };
    case opfor: {[fuelSellPoint_east] call ace_refuel_fnc_getFuel };
    default {0};
};
