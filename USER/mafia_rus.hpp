class mafia_rus {
    class AllUnits {
        uniform[] = {"rds_uniform_Woodlander1", "rds_uniform_Woodlander2", "rds_uniform_Woodlander3", "rds_uniform_Woodlander4", "rds_uniform_rocker1", "rds_uniform_rocker2", "rds_uniform_rocker3"};
        vest = "V_LegStrapBag_black_F";
        backpack = "B_LegStrapBag_black_F";
        headgear[] = {"rds_Woodlander_cap1", "rds_Woodlander_cap2", "rds_Woodlander_cap3", "rds_Woodlander_cap4", "rhs_beanie_green", "H_Booniehat_oli"};
        goggles = "";

        primaryWeapon = "rhs_weap_akm";
        primaryWeaponOptics = "";
        primaryWeaponMagazine = "rhs_30Rnd_762x39mm";
        primaryWeaponPointer = "";
        primaryWeaponMuzzle = "";
        primaryWeaponUnderbarrel = "";
        primaryWeaponUnderbarrelMagazine = "";

        secondaryWeapon = "";
        secondaryWeaponMagazine = "";

        handgunWeapon = "";
        handgunWeaponMagazine = "";

        binoculars = "Binocular";
        map = "ItemMap";
        compass = "ItemCompass";
        watch = "ItemWatch";
        gps = "ItemGPS";
        radio = "tf_fadak";
        nvgoggles = "";

        addItemsToUniform[] = {
            LIST_6("ACE_fieldDressing"),
            LIST_4("ACE_morphine"),
            LIST_3("ACE_CableTie"),
            "ACE_epinephrine",
            "ACE_Flashlight_KSF1",
            "ACE_MapTools",
            "ACE_key_lockpick",
            "ACE_key_east"
        };
        addItemsToVest[] = {};
        addItemsToBackpack[] = {};
    };
    class Type {
        //Rifleman
        class Soldier_F {
            addItemsToBackpack[] = {
                LIST_7("rhs_30Rnd_762x39mm"),
                LIST_2("rhs_mag_rdg2_white"),
                LIST_2("rhs_mag_rgd5")
            };
        };

        //Asst. Autorifleman
        class soldier_AAR_F: Soldier_F {
            addVest = "LOP_6sh46";
            addItemsToVest[] = {
                LIST_7("rhs_30Rnd_762x39mm"),
                LIST_2("rhs_mag_rgd5"),
                LIST_1("rhs_mag_rdg2_white")
            };
            addItemsToBackpack[] = {
                LIST_3("rhs_100Rnd_762x54mmR")
            };
        };

        //Autorifleman
        class soldier_AR_F: Soldier_F {
            primaryWeapon = "rhs_weap_pkp";
            primaryWeaponMagazine = "rhs_100Rnd_762x54mmR";
            addItemsToBackpack[] = {
                LIST_3("rhs_100Rnd_762x54mmR")
            };
        };

        //Combat Life Saver
        class medic_F: Soldier_F {
            vest = "rhs_6sh46";
            addItemsToVest[] = {
                LIST_15("ACE_fieldDressing"),
                LIST_8("ACE_morphine"),
                LIST_8("ACE_epinephrine"),
                LIST_1("ACE_salineIV_500"),
                LIST_1("ACE_salineIV_250")
            };
        };

        //Rifleman (AT)
        class soldier_LAT_F: Soldier_F {
            secondaryWeapon = "rhs_weap_rpg26";
        };

        //Team Leader
        class Soldier_TL_F: Soldier_F {
            
            primaryWeapon = "rhs_weap_akm_gp25";
            primaryWeaponUnderbarrelMagazine = "rhs_GRD40_White";

            addItemsToBackpack[] = {
                LIST_7("rhs_30Rnd_762x39mm"),
                LIST_2("rhs_mag_rdg2_white"),
                LIST_2("rhs_mag_rgd5"),
                LIST_2("rhs_GRD40_White"),
                LIST_2("rhs_GRD40_Red")
            };
        };

        //Squad Leader
        class Soldier_SL_F: Soldier_TL_F {
            uniform= "U_Marshal";
        };
    };

    class Rank {
        class LIEUTENANT {
        };
    };
};