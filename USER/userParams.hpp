/*  Hier können eigene Missionsparameter eingebunden werden.
*   Ist in missionConfig >> Params included.
*/

class TIME_OF_DAY
{
    title = "Time of Day";
    values[] = {0,1,2,3,4,5,6,6.5,7,8,9,10,11,12,13,14,15,16,16.5,17,17.5,18,19,20,21,22,23};
    texts[] = {"00:00","01:00","02:00","03:00","04:00","05:00 - Full Moon","06:00","06:30 - Dawn","07:00 - Sunrise","08:00","09:00","10:00","11:00","12:00","13:00","14:00","15:00","16:00","16:30 - Sunset will arrive","17:00 - Sunset","17:30 - Dusk","18:00 - really dark already","19:00","20:00","21:00","22:00","23:00 - Moon Rise"};
    default = 8;
};

class WEATHER_OVERCAST
{
    title = "Overcast Settings";
    values[] = {0, 0.4, 0.5, 1, -1};
    texts[] = {"SUNNY", "CLOUDY", "SLIGHT RAIN", "HEAVY RAIN", "RANDOM"};
    default = 0;
};

class WEATHER_FOG
{
    title = "Fog Settings";
    values[] = {0, 0.05, 0.1, 0.2, 0.5, 1, -1};
    texts[] = {"None", "0.05", "0.1", "0.2", "0.5", "maximum perversum", "random"};
    default = 0.05;
};

class WEATHER_WIND
{
    title = "Wind Settings";
    values[] = {0, 1, 2, 4, 8, 32, -1};
    texts[] = {"None", "1 m/s", "2 m/s", "4 m/s", "8 m/s", "maximum perversum", "random"};
    default = 1;
};

class ENABLE_CIVS
{
    title = "Enable Civs";
    values[] = {0, 1};
    texts[] = {"OFF", "ON"};
    default = 1;
};