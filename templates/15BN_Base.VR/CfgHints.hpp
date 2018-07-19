class _15BN_Base {
displayName = "15° Ricognitori Bande Nere";
class Istruzioni
{
	logicalOrder = 1;
	displayName = "15° Ricognitori Bande Nere";
	noImage = false;
	image = "img\15logo_BW.paa";
	description = "\
Benvenuto %11.<br/>\
Premi %3[ESC]%4 e scegli %3MANUALE OPERATIVO%4\
 per leggere queste ed ulteriori istruzioni.<br/>\
L'%3Arsenale Virtuale%4 è disponibile in base<br/>\
presso i cartelli delle squadre.\
";
	tip = "\
Buon divertimento!<br/>\
";
	arguments[] = {
		"name player"
	};
};
class ProntoSoccorso
{
	logicalOrder = 2;
	displayName = "Pronto Soccorso";
	noImage = false;
	image = "\z\ace\addons\medical\UI\icons\medical_cross.paa";
	description = "\
%2 Il medico rimane al coperto, non troppo vicino ai muri, lontano dalle finestre<br/>\
%2 I feriti vanno bendati appena possibile da uno o più commilitoni contemporaneamente<br/>\
%2 I feriti vanno personalmente dal medico a farsi curare<br/>\
%2 I feriti incoscenti vengono portati in spalla o trascinati<br/>\
%2 Il paziente ignora ordini dallo SL o TL fino a fine della cura del medico<br/>\
%2 Il medico comunica a voce cosa sta facendo per farlo sapere sia al paziente che agli altri che stanno intorno<br/>\
%2 Nessuno deve posizionarsi tra il medico ed il paziente, il menu interazioni di ACE diventa altrimenti inutilizzabile<br/>\
%2 Il paziente può tornare a muoversi solo dopo che il medico glielo permette<br/>\
%2 Il paziente comunica allo SL o TL che è di nuovo ai suoi ordini<br/>\
%2 In caso di ferite multiple, il medico può ordinare ad altri di bendare il paziente<br/>\
%2 Nessuno inietta ad altri morfine o epinefrine senza l'approvazione del medico\
";
	tip = "\
<a underline='true' href='http://www.15bandenere.com/forum/index.php?threads/medico.450/'>Medico</a><br/>\
";
};
class Equipaggiamenti
{
	logicalOrder = 3;
	displayName = "Equipaggiamenti";
	noImage = false;
	// image = "img\15logo_BW.paa";
	image = "\a3\ui_f\data\gui\cfg\hints\Gear_ca.paa";
	description = "\
Carica un equipaggiamento predefinito:<br/>\
%2 Con la rotellina del mouse seleziona %3Arsenale ACE%4<br/>\
%2 Clicca %3EQUIPAGGIAMENTI%4<br/>\
%2 Clicca %3EQUIPAGGIAMENTI STANDARD%4<br/>\
%2 Seleziona un equipaggiamento marcato %3[=15BN=]%4<br/>\
%2 Clicca %3CARICA%4<br/>\
%2 Clicca %3CHIUDI%4<br/>\
%2 Clicca %3CHIUDI%4<br/>\
";
	tip = "\
Puoi salvare nella sezione 'I MIEI EQUIPAGGIAMENTI'<br/>\
";
};
class RadioTruppa
{
	logicalOrder = 4;
	displayName = "Radio Truppa";
	noImage = false;
	image = "\a3\ui_f\data\gui\cfg\hints\CallSupport_CA.paa";
	description = "\
<img size='8' shadow='1' image='\task_force_radio_items\rf7800str\rf7800str_icon.paa' /><br/>\
RF-7800S-TR 30-152 MHz / 2 km<br/>\
%2 Alpha-1 sui 110.0 MHz<br/>\
%2 Alpha-2 sui 120.0 MHz<br/>\
%2 Alpha-3 sui 130.0 MHz<br/>\
In caso di ulteriori squadre, si decide in gioco\
"; 
};
class RadioComando
{
	logicalOrder = 5;
	displayName = "Radio Comando";
	noImage = false;
	image = "\a3\ui_f\data\gui\cfg\hints\CallSupport_CA.paa";
	description = "\
<img size='8' shadow='1' image='\task_force_radio_items\rt1523g\rt1523g_icon.paa' /><br/>\
RT-1523G (ASIP) 30-152 MHz / 20 km<br/>\
%2 Comando squadra sui 100.0 MHz<br/>\
";
};
class Forum
{
	logicalOrder = 7;
	displayName = "Forum";
	noImage = false;
	image = "img\15logo_BW.paa";
	description = "\
Clicca per aprire il thread dal tuo browser Internet.<br/>\
%2 <a underline='true' href='http://www.15bandenere.com/forum/index.php?threads/manuale-di-campo.2/'>Manuale di Campo</a><br/>\
%2 <a underline='true' href='http://www.15bandenere.com/forum/index.php?threads/determinare-la-distanza-di-un-bersaglio.5/'>Distanza bersaglio</a><br/>\
%2 <a underline='true' href='http://www.15bandenere.com/forum/threads/thread-di-riferimento-per-tfar.1105/'>TFAR</a><br/>\
%2 <a underline='true' href='http://www.15bandenere.com/forum/index.php?threads/base-per-altis-stratis-e-bornholm.408/'>Questa missione</a><br/>\
";
	tip = "\
Premi %3[Alt+Tab]%4 per tornare dal browser al gioco.<br/>\
";
};
};
