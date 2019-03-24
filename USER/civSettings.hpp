/*
*   Legt Einstellungen für grad-civs Zivilisten fest.
*   In der Klasse "userEquipment" können eigene Ausrüstungsgegenstände für die Zivilisten definiert werden.
*/
enableCivs = 1;

debugCivState = 0;
backpackProbability = 0.15;

maxCivsResidents = 20;
spawnDistancesResidents[] = {750, 1500};

maxCivsOnFoot = 10;
spawnDistancesOnFoot[] = {1000,4500};

enableInVehicles = 1;
automaticVehicleGroupSize = 1;
maxCivsInVehicles = 5;
spawnDistancesInVehicles[] = {1800,5000};

class userEquipment {
    // Soll die hier definierte Ausrüstung die vordefinierte, inselabhängige Ausrüstung ersetzen oder zu dieser hinzugefügt werden? (0: hinzufügen, 1: ersetzen)
    replace = 0;

    // Uniformen
    clothes[] = {

    };

    // Helme, Mützen
    headgear[] = {

    };

    // Gesichter
    faces[] = {

    };

    // Brillen, Masken, Halstücher
    goggles[] = {

    };

    // Rucksäcke
    backpacks[] = {

    };

    vehicles[] = {

    };
};
