//WAVE RESPAWN =================================================================
waveRespawnEnabled = 1;                                                         //Wave Respawn ein-/ausschalten (1/0)

bluforWaveSize = 3;                                                            //Wellengröße Blufor (-1 == automatisch)
opforWaveSize = 3;                                                             //Wellengröße Opfor (-1 == automatisch)
indepWaveSize = 3;                                                             //Wellengröße Independent (-1 == automatisch)

bluforWaveLifes = 9999;                                                         //Wie oft ein Blufor Spieler respawnen kann
opforWaveLifes = 9999;                                                          //Wie oft ein Opfor Spieler respawnen kann
indepWaveLifes = 9999;                                                          //Wie oft ein Independent Spieler respawnen kann

bluforInterruptCondition = "missionNameSpace getVariable ['tembelanTrap_lastFight', false]";                                             //Bedingung nach der der Blufor Waverespawn deaktiviert wird
opforInterruptCondition = "missionNameSpace getVariable ['tembelanTrap_lastFight', false]";                                              //Bedingung nach der der Opfor Waverespawn deaktiviert wird
indepInterruptCondition = "missionNameSpace getVariable ['tembelanTrap_lastFight', false]";                                              //Bedingung nach der der Independent Waverespawn deaktiviert wird

waverespawntimePlayer = 10;                                                     //Spielerrespawnzeit, bevor er der Welle hinzugefügt wird

waverespawntimeBlu = 240;                                                        //Wellenrespawnzeit Blufor in Sekunden
waverespawntimeOpf = 240;                                                        //Wellenrespawnzeit Opfor in Sekunden
waverespawntimeInd = 240;                                                        //Wellenrespawnzeit Independent in Sekunden


//NORMALER RESPAWN =============================================================//Diese Einträge sind nur bei ausgeschaltetem Wave Respawn wichtig
respawntimeBlu = 9999;                                                          //Respawnzeit Blufor in Sekunden
respawntimeOpf = 9999;                                                          //Respawnzeit Opfor in Sekunden
respawntimeInd = 9999;                                                          //Respawnzeit Independent in Sekunden
