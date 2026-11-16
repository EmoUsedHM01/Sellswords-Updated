// how a dual wielder holds the two weapons, used by mod_sellswords\hooks\entity\tactical\actor.nut
// Legends draws them crossed, these put them side by side and held out
// only used while a unit holds a weapon in each hand, everything goes back to normal otherwise
::Mod_Sellswords.DualWield <- {
	Distance = 64,	// pixels between the main hand and the off hand weapon
	Forward = 42,	// pixels both weapons are moved towards where the unit is facing
	Down = 0,		// pixels both weapons are moved down
	Tilt = 25,		// degrees both weapons are tilted downward, they turn around the middle of the unit

	// one-handed weapons that SSU units carry in pairs, one in each hand
	Paired = [
		"weapons/barbarians/crude_axe",
		"weapons/barbarians/blunt_cleaver",
		"weapons/barbarians/ssu_war_axe"
	]
};

// true while the character holds one of the Bloodfang Twinblades in each hand
::Mod_Sellswords.DualWield.hasUnitedTwinblades <- function( _actor )
{
	local main = _actor.getItems().getItemAtSlot(::Const.ItemSlot.Mainhand);
	local off = _actor.getItems().getItemAtSlot(::Const.ItemSlot.Offhand);

	return main != null && off != null && main.getID() == "weapon.ssu_legendary_cleaver" && off.getID() == "weapon.ssu_legendary_cleaver";
}
