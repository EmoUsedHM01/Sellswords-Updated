::Mod_Sellswords.HooksMod.hook("scripts/factions/actions/build_unique_locations_action", function ( q ) {

	// one flag per entry in mod_sellswords\config\ssu_legendary_locations.nut, Legends does the building
	q.m.BuildSsuSellswordTower <- true;
	q.m.BuildSsuOrcFortress <- true;
	q.m.BuildSsuUndeadStronghold <- true;
	q.m.BuildSsuDryadTree <- true;

});
