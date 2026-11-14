::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/legend_piercing_bolt_skill", function ( q ) {

	q.onItemSet = @(__original) function()
	{
		this.m.MaxRange = this.m.Item.getRangeMax();
	}

	q.create = @(__original) function()
	{
		__original();

		this.m.Name = ::Mod_Sellswords.Strings.legend_piercing_bolt_skill.Name;
		this.m.Description = ::Mod_Sellswords.Strings.legend_piercing_bolt_skill.Description;
		this.m.KilledString = "Shot";
		this.m.Icon = "skills/active_17.png";
		this.m.IconDisabled = "skills/active_17_sw.png";
		this.m.Overlay = "active_17";
	}

	q.isHidden = @(__original) function()
	{
		return !this.getContainer().getActor().isArmedWithRangedWeapon() || !this.getContainer().hasSkill("perk.legend_piercing_shot");
	}

	// comment this out and think about it later
	// 	// Standard piercing bolt behavior

	// 	// Check for forward tile and piercing logic

	// 	// Apply damage to the forward tile entity

	// 	// Phantom bolt behavior

	q.onAfterUpdate = @(__original) function( _properties )
	{
		__original(_properties);

		this.m.DirectDamageMult = _properties.IsSpecializedInCrossbows ? 0.6 : 0.4;
		this.m.AdditionalAccuracy = this.m.Item.getAdditionalAccuracy();
	}

});