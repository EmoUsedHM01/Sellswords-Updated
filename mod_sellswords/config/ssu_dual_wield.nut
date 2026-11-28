::Mod_Sellswords.DualWield <- {
	Distance = 64,			// pixels between the main hand and the off hand weapon
	Forward = 42,			// pixels both weapons are moved towards where the unit is facing
	Down = 0,				// pixels both weapons are moved down
	Tilt = 25,				// degrees both weapons are tilted downward, they turn around the middle of the unit

	PortraitDistance = 24,	// pixels the off hand weapon sits behind the main hand weapon
	PortraitDown = 14,		// pixels the off hand weapon sits below the main hand weapon

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

// when both weapons have the skill that was just used, the other hand follows up with that skill instead of its cheapest attack
// e.g. two Qatal Daggers both use Deathblow, rather than Deathblow and then Stab
::Mod_Sellswords.DualWield.MatchSkillID <- null;

::Mod_Sellswords.DualWield.findMatchingSkill <- function( _actor, _weapon, _id )
{
	foreach (skill in _weapon.m.SkillPtrs)
	{
		if (skill == null || skill.isGarbage() || skill.getID() != _id)
		{
			continue;
		}

		if (skill.getContainer() == null || !("getActor" in skill.getContainer()))
		{
			skill.setContainer(_actor.getSkills());
		}

		if (!skill.isActive() || !skill.isAttack() || !skill.isTargeted() || skill.isDisabled() || !skill.isUsable() || skill.getMinRange() > 1 || skill.isRanged())
		{
			return null;
		}

		return skill;
	}

	return null;
}

local findPrimaryAttackSkill = ::Legends.Weapons.findPrimaryAttackSkill;
::Legends.Weapons.findPrimaryAttackSkill = function( _actor, _weapon )
{
	if (::Mod_Sellswords.DualWield.MatchSkillID != null && _actor != null && _weapon != null)
	{
		local skill = ::Mod_Sellswords.DualWield.findMatchingSkill(_actor, _weapon, ::Mod_Sellswords.DualWield.MatchSkillID);

		if (skill != null)
		{
			return skill;
		}
	}

	return findPrimaryAttackSkill(_actor, _weapon);
}

::Mod_Sellswords.DualWield.equipPotAndSpare <- function( _actor, _spare )
{
	local items = _actor.getItems();

	if (items.hasEmptySlot(::Const.ItemSlot.Offhand))
	{
		items.equip(::Legends.Items.pickItem([
			[3, "tools/daze_bomb_item"],
			[1, "tools/fire_bomb_item"],
			[1, "tools/smoke_bomb_item"]
		], "scripts/items/"));
	}

	items.addToBag(::new("scripts/items/" + _spare));

	if (!_actor.isPlayerControlled() && _actor.getAIAgent() != null && _actor.getAIAgent().findBehavior(::Const.AI.Behavior.ID.SsuEquipOffhand) == null)
	{
		_actor.getAIAgent().addBehavior(::new("scripts/ai/tactical/behaviors/ssu_ai_equip_offhand"));
		_actor.getAIAgent().finalizeBehaviors();
	}
}
