::mods_hookExactClass("skills/perks/perk_str_phalanx", function ( o )
{
	o.getTooltip = function ()
	{
		local tooltip = this.skill.getTooltip();
		local bonus = this.getBonus();
		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/melee_defense.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + bonus + "[/color] Melee Defense"
		});
		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon != null && (weapon.isWeaponType(this.Const.Items.WeaponType.Spear) || weapon.isWeaponType(this.Const.Items.WeaponType.Sword)))
		{
			tooltip.push({
				type = "text",
				id = 10,
				icon = "ui/icons/melee_skill.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + bonus + "[/color] Melee Skill"
			});
		}
		return tooltip;
	}
	o.onUpdate = function (_properties)
	{
		this.m.Count = 0;
		local actor = this.getContainer().getActor();
		if (!actor.isPlacedOnMap() || !actor.isArmedWithShield() || !actor.isEngagedInMelee())
		{
			return;
		}
		if (::Tactical.isActive())
		{
			local adjacentAllies = ::Tactical.Entities.getAlliedActors(actor.getFaction(), actor.getTile(), 1);

			foreach (ally in adjacentAllies)
			{
				if (!ally.isArmedWithShield() || !ally.isEngagedInMelee() || ally.getID() == actor.getID())
				{
					continue;
				}

				this.m.Count += 1;
			}
		}
		local bonus = this.getBonus();
		_properties.MeleeDefense += bonus;
		local weapon = actor.getMainhandItem();
		if (weapon != null && (weapon.isWeaponType(this.Const.Items.WeaponType.Spear) || weapon.isWeaponType(this.Const.Items.WeaponType.Sword)))
		{
			_properties.MeleeSkill += bonus;
		}
	}		
});