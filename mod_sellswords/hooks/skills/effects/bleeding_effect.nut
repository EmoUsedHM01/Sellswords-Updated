::Mod_Sellswords.HooksMod.hook("scripts/skills/effects/bleeding_effect", function ( q ) {

	q.m.bleed_type <- 2;

	q.onAdded = @(__original) function ()
	{
		local actor = this.getContainer().getActor();
		local crrd = this.getContainer().hasSkill("perk.ssu_rangeddefense") ? this.Math.rand(1, 100) <= actor.getBaseProperties().RangedDefense : false;

		if (actor.getCurrentProperties().IsImmuneToBleeding)
	  		this.removeSelf();

		if (this.getContainer().getActor().getCurrentProperties().IsResistantToAnyStatuses && this.Math.rand(1, 100) <= 50 || crrd)
		{
			if (!this.getContainer().getActor().isHiddenToPlayer())
				this.Tactical.EventLog.log(::Mod_Sellswords.text(::Mod_Sellswords.Strings.bleeding_effect.Log, this.Const.UI.getColorizedEntityName(this.getContainer().getActor())));

			this.removeSelf();
		}
		else
		{
			this.m.TurnsLeft = this.Math.max(1, this.m.bleed_type + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);

			if (this.getContainer().hasSkill("trait.bleeder"))
				++this.m.TurnsLeft;
		}
	}

	q.onUpdate = @(__original) function ( _properties )
	{
		if (this.m.bleed_type == 5)
		{
			this.m.Name = ::Mod_Sellswords.Strings.bleeding_effect.Name;
			this.m.Icon = "ui/perks/graze_circle.png";
			this.m.IconMini = "legend_grazed_effect_mini";
			this.m.Overlay = "legend_grazed_effect";
		}
	}

	q.getDamage = @(__original) function ()
	{
		return __original() * (this.getContainer().getActor().getSkills().hasSkill("perk.ssu_resilient") ? 0.75 : 1.0);
	}

	q.getDescription = @(__original) function ()
	{
		if (this.m.bleed_type == 1)
			return ::Mod_Sellswords.text(::Mod_Sellswords.Strings.bleeding_effect.Text1, this.m.Damage, this.m.TurnsLeft);
		else if (this.m.bleed_type == 5)
			return ::Mod_Sellswords.text(::Mod_Sellswords.Strings.bleeding_effect.Text2, this.m.Damage, this.m.TurnsLeft);
		else
			return ::Mod_Sellswords.text(::Mod_Sellswords.Strings.bleeding_effect.Text1, this.m.Damage, this.m.TurnsLeft);
	}

});