::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/legend_double_swing_skill", function ( q ) {

	// the united Bloodfang Twinblades have their own Swing and no attack in the off hand for this one to use
	q.isHidden = @(__original) function()
	{
		if (__original() || this.getContainer() == null)
			return __original();

		return ::Mod_Sellswords.DualWield.hasUnitedTwinblades(this.getContainer().getActor());
	}

	q.isUsable = @(__original) function()
	{
		return __original() && !::Mod_Sellswords.DualWield.hasUnitedTwinblades(this.getContainer().getActor());
	}

});
