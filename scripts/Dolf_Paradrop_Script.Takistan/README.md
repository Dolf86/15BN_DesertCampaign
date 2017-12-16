# Paradrop Script v0.2

## Istruzioni per il mission maker (v0.2)
Per aggiungere lo script ad una missione è necessario:
- copiare la cartella "Zen_FrameworkFunctions" nella cartella della missione (se mancante);
- copiare la cartella "img" nella cartella della missione (o unirne il contenuto se già presente);
- creare un file chiamato "init.sqf" e aggiungere le seguenti righe (se mancanti):

```
#include "Zen_FrameworkFunctions\Zen_InitHeader.sqf"
enableSaving [false, false];

0 = ["Dialog_Map_Click", "onMapSingleClick", {dolf_paradrop_MapPos = _pos}, []] call BIS_fnc_addStackedEventHandler;
[] execVM "scripts\paradrop\ui\paradrop_ui_waypoints.sqf";
[] execVM "scripts\paradrop\ui\paradrop_ui_start.sqf";

if (isServer) then {
  [] execVM "scripts\paradrop\paradrop_init.sqf";
};
sleep 1;
```
- creare un file chiamato "description.ext" e aggiungere le seguenti righe (se mancanti):
```
#include "Zen_FrameworkFunctions\Zen_DialogSystem\Zen_Dialog.hpp"
class CfgNotifications {
    #include "Zen_FrameworkFunctions\Zen_TaskSystem\Zen_TaskNotifications.hpp"
};
```
- aggiungere un singolo uomo della classe desiderata (ufficiale) e chiamarlo "dolf_paradropOfficier";
- aggiungere un singolo uomo della classe desiderata (pilota) e chiamarlo "dolf_paradrop_pilota";
- aggiungere un aereo, nominarlo "dolf_paradrop_aereo" e posizionarlo all'inizio della pista;
- impostare i parametri desiderati (altitudine, velocità e aeroporto di atterraggio) nel file "scripts/paradrop/paradrop_init.sqf";

## Istruzioni per il giocatore (v0.2)
- avvicinarsi all'unità scelta come "ufficiale" dal mission maker ("dolf_paradropOfficier");
- selezionare la voce "Paradrop setup panel", impostare i waypoint e premere il pulsante "Start";
- salire sull'aereo;
- selezionare la voce "Paradrop control panel" e premere il pulsante "Start" quando tutti i passeggeri sono a bordo.

### Changelog 0.2
- Rinominate tutte le variabili per evitare problemi di compatibilità;
- Aggiunta UI di base per la creazione dei waypoint e l'avvio dell'aereo;
- Modificato il setup dello script (rimosso lo spawn dell'aereo e pilota, ora vanno aggiunti da editor).
