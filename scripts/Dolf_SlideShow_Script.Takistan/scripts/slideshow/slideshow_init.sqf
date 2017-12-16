[[schermo1, schermo2], //schermi
[pc], //oggetto che controlla le slide
["img\slides\1.paa", "img\slides\2.paa","img\slides\3.paa"], //percorso alle immagini
["Slide 1", "Slide 2", "Slide 3"], 0, //nomi delle slide e secondi per transizione automatica (0 se manuale)
"Slides"] //voce menu interazione ACE
call ace_slideshow_fnc_createSlideshow;