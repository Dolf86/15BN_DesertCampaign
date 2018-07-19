class ALEF {
	tag = "ALEF";
	class _15BN_ {
	class 3DEN_Replace
	{
		description = "Replace this mission objects with merged template mission.";
	};
	class medicsAvailable
	{
		description = "Check if all medics are alive.";
	};
      	class preInit
      	{
      		description = "Things to do before mission inits.";
      		preInit = 1;
      	};
	class skipBriefingScreen
	{
		description = "Clicks on CONTINUE";
		preInit = 1;
	};
	class chestpack {
		description = "Add a chestpack possibility";
	};
	class dumpInventory {
		description = "Copy to clipboard a text version of the unit inventory";
	};
	class arsenal {
		description = "Add or remove both BIS and ACE arsenals to or from the menu";
	};
	class serverDifficulty {
		description = "Show server difficulty settings as CBA settings";
	};
	};
};
