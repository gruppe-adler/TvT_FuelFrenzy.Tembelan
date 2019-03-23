private _screenWidth = safeZoneW;
private _screenHeight = safeZoneH;

private _columnWidth = _screenWidth/26;
private _rowHeight = _screenHeight/40;

disableSerialization;

private _display = findDisplay 46 createDisplay "RscDisplayEmpty";

private _background = _display ctrlCreate ["RscText", -1];
_background ctrlSetPosition [safezoneX, safeZoneY, _screenWidth, _screenHeight];
_background ctrlSetBackgroundColor [0,0,0,0.9];
_background ctrlCommit 0;

private _backgroundHeader = _display ctrlCreate ["RscText", -1];
_backgroundHeader ctrlSetPosition [safezoneX, safeZoneY, _screenWidth, _rowHeight*4];
_backgroundHeader ctrlSetBackgroundColor [0,0,0,1];
_backgroundHeader ctrlCommit 0;

private _bgHeadline = _display ctrlCreate ["RscStructuredText", -1];
_bgHeadline ctrlsetFont "RobotoCondensedBold";
_bgHeadline ctrlSetBackgroundColor [0,0,0,0];
_bgHeadline ctrlSetStructuredText parseText ("<t size='3' align='center' color='#333333'>Auswertung</t>");
_bgHeadline ctrlSetPosition [safezoneX, safeZoneY, _screenWidth, _rowHeight*3];
_bgHeadline ctrlCommit 0;


// private _iconKilled = "\A3\ui_f\data\igui\cfg\mptable\killed_ca.paa";
private _iconInf = "\A3\ui_f\data\igui\cfg\mptable\infantry_ca.paa";
private _iconSoft = "\A3\ui_f\data\igui\cfg\mptable\soft_ca.paa";
// private _iconArmored = "\A3\ui_f\data\igui\cfg\mptable\armored_ca.paa";
private _iconFuel = "USER\winstats\drop2.paa";
private _iconTotal = "\A3\ui_f\data\igui\cfg\mptable\total_ca.paa";
// text = "\A3\ui_f\data\igui\cfg\mptable\air_ca.paa";

private _columns = ["", "Italiener", "Russen"];
private _picturePath = ["", _iconInf, _iconSoft, _iconFuel, _iconTotal];
private _picturePathDescription = ["", "Infanterie", "Autos", "Treibstoff", "Insgesamt"];

private _resultInf_west = "5000";
private _resultSoft_west = "1000";
// private _resultArmored = ["", "1", "2", "3", "4"];
private _resultFuel_west = "2000";
private _resultTotal_west = "25000";

private _resultInf_east = "4000";
private _resultSoft_east = "4000";
// private _resultArmored = ["", "1", "2", "3", "4"];
private _resultFuel_east = "4000";
private _resultTotal_east = "30000";


private _results_west = ["", _resultInf_west, _resultSoft_west, _resultFuel_west, _resultTotal_west];
private _results_east = ["", _resultInf_east, _resultSoft_east, _resultFuel_east, _resultTotal_east];

for "_i" from 1 to 3 do {

    private _multiplicator = _i * 5;

    private _column = _display ctrlCreate ["RscText", -1];
    _column ctrlSetPosition [
        _columnWidth * _multiplicator + safezoneX + _columnWidth,
        _rowHeight + safezoneY,
        _columnWidth * 4,
        _screenHeight + safezoneY
    ];
    _column ctrlSetBackgroundColor [1,1,1,0];
    _column ctrlCommit 0;

    private _headline = _display ctrlCreate ["RscStructuredText", -1];
    _headline ctrlsetFont "RobotoCondensedBold";
    _headline ctrlSetBackgroundColor [0,0,0,0];
    _headline ctrlSetTextColor [1,1,1,1];
    _headline ctrlSetStructuredText parseText ("<t size='2' align='center' color='#333333'>" + (_columns select (_i-1)) + "</t>");
    _headline ctrlSetPosition [
        _columnWidth * _multiplicator + safezoneX + _columnWidth, 
        _rowHeight * 4 + safezoneY + _rowHeight * 2, 
        _columnWidth * 4,
        _rowHeight * 2.5 
    ];
    _headline ctrlCommit 0;


    for "_j" from 1 to 4 do {   

            if (_i == 1) then {
                private _picture = _display ctrlCreate ["RscPictureKeepAspect", -1];
                _picture ctrlSetPosition [
                    _columnWidth * _multiplicator + safezoneX  + _columnWidth + _columnWidth/2, 
                    (_j * (_rowHeight * 6) + safezoneY) + _rowHeight * 6,
                    _columnWidth * 2, 
                    _rowHeight * 2
                ];
                _picture ctrlSetBackgroundColor [0,0,0,0];
                _picture ctrlSetText (_picturePath select _j);
                _picture ctrlSetTooltip (_picturePathDescription select _j);
                _picture ctrlCommit 0;
            };

            if (_i == 2) then {
                private _subline = _display ctrlCreate ["RscStructuredText", -1];
                _subline ctrlsetFont "RobotoCondensedBold";
                _subline ctrlSetBackgroundColor [0,0,0,0];
                _subline ctrlSetStructuredText parseText ("<t size='2' align='center' shadow='0' color='#999999'>" + (_results_east select _j) + "</t>");
                _subline ctrlSetPosition [
                    _columnWidth * _multiplicator + safezoneX  + _columnWidth, 
                    (_j * (_rowHeight * 6) + safezoneY) + _rowHeight * 6,
                    _columnWidth * 4,
                    _rowHeight * 2
                ];
                _subline ctrlCommit 0;
            };

            if (_i == 3) then {
                private _subline = _display ctrlCreate ["RscStructuredText", -1];
                _subline ctrlsetFont "RobotoCondensedBold";
                _subline ctrlSetBackgroundColor [0,0,0,0];
                _subline ctrlSetStructuredText parseText ("<t size='2' align='center' shadow='0' color='#999999'>" + (_results_west select _j) + "</t>");
                _subline ctrlSetPosition [
                    _columnWidth * _multiplicator + safezoneX  + _columnWidth, 
                    (_j * (_rowHeight * 6) + safezoneY) + _rowHeight * 6,
                    _columnWidth * 4,
                    _rowHeight * 2
                ];
                _subline ctrlCommit 0;
            };



            private _divider = _display ctrlCreate ["RscStructuredText", -1];
            _divider ctrlSetPosition [
                safezoneX,
                (_j * (_rowHeight * 6) + safezoneY) + _rowHeight * 4,
                _screenWidth,
                _rowHeight / 20
            ];
            _divider ctrlSetBackgroundColor [1,1,1,0.03];
            _divider ctrlCommit 0;
    };
};