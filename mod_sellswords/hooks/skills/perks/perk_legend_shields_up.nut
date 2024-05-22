::mods_hookExactClass("skills/perks/perk_legend_shields_up", function ( o )
{
	o.onCombatStarted = function ()
	{
		this.skill.onCombatStarted();
		local allies = this.Tactical.Entities.getInstancesOfFaction(this.getContainer().getActor().getFaction());

		foreach( ally in allies )
		{
			local offhand_ally = ally.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);

			if (offhand_ally != null && offhand_ally.isItemType(this.Const.Items.ItemType.Shield))
			{
				if (!ally.getSkills().hasSkill("effects.shieldwall") && ally.getSkills().hasSkill("actives.shieldwall"))
				{
					ally.getSkills().add(this.new("scripts/skills/effects/shieldwall_effect"));
					this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(ally) + " uses Shieldwall due to the Shields Up perk");
				}
				else if (!ally.getSkills().hasSkill("effects.legend_fortify") && ally.getSkills().hasSkill("actives.legend_fortify_skill"))
				{
					ally.getSkills().add(this.new("scripts/skills/effects/legend_fortify_effect"));
					this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(ally) + " uses Shieldwall due to the Shields Up perk");
				}
			}
		}
	};
});