::Mod_Sellswords.HooksMod.hook("scripts/skills/perks/perk_legend_shields_up", function ( q ) {

	q.onCombatStarted = @( __original ) function ()
	{
		this.skill.onCombatStarted();
		local allies = this.Tactical.Entities.getInstancesOfFaction(this.getContainer().getActor().getFaction());

		foreach( ally in allies )
		{
			local offhand_ally = ally.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);

			if (offhand_ally != null && offhand_ally.isItemType(this.Const.Items.ItemType.Shield))
			{
				if (!ally.getSkills().hasEffect(::Legends.Effect.Shieldwall) && ally.getSkills().hasSkill(::Legends.Active.Shieldwall))
				{
					::Legends.Effects.grant(ally, ::Legends.Effect.Shieldwall);
					this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(ally) + " uses Shieldwall due to the Shields Up perk");
				}
				else if (!ally.getSkills().hasEffect(::Legends.Effect.LegendFortify) && ally.getSkills().hasSkill(::Legends.Active.LegendFortify))
				{
					::Legends.Effects.grant(ally, ::Legends.Effect.LegendFortify);
					this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(ally) + " uses Fortify due to the Shields Up perk");
				}
			}
		}
	}

});