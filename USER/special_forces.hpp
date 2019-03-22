class special_forces_w {
    class AllUnits {
        uniform[] = {
                "U_B_GEN_Commander_F",
                "U_B_GEN_Soldier_F"
            };
        vest = "V_Chestrig_blk";
        backpack = "";
        headgear = "rhsusf_opscore_bk_pelt";
        goggles = "rhs_googles_black";

        primaryWeapon = "rhs_weap_mk18_bk";
        primaryWeaponOptics = "rhsusf_acc_compm4";
        primaryWeaponMagazine = "rhs_mag_30Rnd_556x45_Mk318_Stanag";
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
        radio = "tf_anprc152";
        nvgoggles = "";

        addItemsToUniform[] = {
            LIST_6("ACE_fieldDressing"),
            LIST_4("ACE_morphine"),
            LIST_3("ACE_CableTie"),
            "ACE_epinephrine",
            "ACE_Flashlight_MX991",
            "ACE_MapTools",
            "ACE_key_lockpick",
            "ACE_key_west"
        };
        addItemsToVest[] = {};
        addItemsToBackpack[] = {};
    };
    class Type {
        //Rifleman
        class Soldier_F {
            addItemsToVest[] = {
                LIST_7("rhs_mag_30Rnd_556x45_Mk318_Stanag"),
                LIST_2("rhs_mag_an_m8hc"),
                LIST_2("rhs_mag_m67"),
                LIST_1("ACE_M84")
            };
        };

        //Asst. Autorifleman
        class soldier_AAR_F: Soldier_F {
            backpack = "B_AssaultPack_blk";
            addItemsToBackpack[] = {
                LIST_10("rhs_mag_30Rnd_556x45_Mk318_Stanag"),
                LIST_1("ACE_EntrenchingTool")
            };
        };

        //Autorifleman
        class soldier_AR_F: Soldier_F {
            primaryWeapon = "rhs_weap_m27iar";
            primaryWeaponMagazine = "rhs_mag_30Rnd_556x45_Mk318_Stanag";
            primaryWeaponUnderbarrel = "rhsusf_acc_harris_bipod";
            addItemsToVest[] = {
                LIST_10("rhs_mag_30Rnd_556x45_Mk318_Stanag"),
                LIST_2("rhs_mag_an_m8hc"),
                LIST_2("rhs_mag_m67")
            };
        };

        //Combat Life Saver
        class medic_F: Soldier_F {
            backpack = "B_AssaultPack_blk";
            addItemsToBackpack[] = {
                LIST_15("ACE_fieldDressing"),
                LIST_10("ACE_morphine"),
                LIST_10("ACE_epinephrine"),
                LIST_2("ACE_salineIV")
            };
        };

        //Rifleman (AT)
        class soldier_LAT_F: Soldier_F {
            secondaryWeapon = "rhs_weap_m72a7";
        };

        //Squad Leader
        class Soldier_SL_F: Soldier_F {
            handgunWeapon = "rhs_weap_M320";
            handgunWeaponMagazine = "1Rnd_SmokeRed_Grenade_shell";

            addItemsToVest[] = {
                LIST_7("rhs_mag_30Rnd_556x45_Mk318_Stanag"),
                LIST_2("rhs_mag_an_m8hc"),
                LIST_2("rhs_mag_m67"),
                LIST_2("1Rnd_Smoke_Grenade_shell"),
                LIST_1("1Rnd_SmokeRed_Grenade_shell"),
                LIST_1("ACE_M84")
            };
        };

        //Team Leader
        class Soldier_TL_F: Soldier_SL_F {

        };
    };
};

class special_forces_d: special_forces_w {
    class AllUnits: AllUnits {
        uniform = "rhs_uniform_g3_tan";
        vest = "V_Chestrig_khk";
        headgear = "rhsusf_opscore_ut_pelt";
        primaryWeapon = "rhs_weap_mk18_d";
    };
    class Type: Type {
        class Soldier_F: Soldier_F {};

        class soldier_AAR_F: soldier_AAR_F {
            backpack = "B_AssaultPack_cbr";
        };

        class soldier_AR_F: soldier_AR_F {};

        class medic_F: medic_F {
            backpack = "B_AssaultPack_cbr";
        };

        class soldier_LAT_F: soldier_LAT_F {};

        class Soldier_SL_F: Soldier_SL_F {};

        class Soldier_TL_F: Soldier_TL_F {};
    };
};