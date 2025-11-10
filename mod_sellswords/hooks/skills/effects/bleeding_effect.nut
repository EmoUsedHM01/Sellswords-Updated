::Mod_Sellswords.HooksMod.hook("scripts/skills/effects/bleeding_effect", function ( q ) {

	q.m.bleed_type <- 2;
	q.m.ptr_hemo <- false;

	q.onAdded = @(__original) function ()
	{
		local actor = this.getContainer().getActor();
		local crrd = this.getContainer().hasSkill("perk.crrangeddefense") ? this.Math.rand(1, 100) <= actor.getBaseProperties().RangedDefense : false;

		if (actor.getCurrentProperties().IsImmuneToBleeding)
	  		this.removeSelf();

		if (this.getContainer().getActor().getCurrentProperties().IsResistantToAnyStatuses && this.Math.rand(1, 100) <= 50 || crrd)
		{
			if (!this.getContainer().getActor().isHiddenToPlayer())
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(this.getContainer().getActor()) + " had his bleeding wound quickly close thanks to his unnatural physiology");

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
			this.m.Name = "Bleeding from grazes";
			this.m.Icon = "skills/graze_circle.png";
			this.m.IconMini = "mini_graze_circle";
			this.m.Overlay = "graze";
		}
	}

	q.getDamage = @(__original) function ()
	{
		return __original() * (this.getContainer().getActor().getSkills().hasSkill("perk.crresilient") ? 0.75 : 1.0);
	}

	q.getDescription = @(__original) function ()
	{
		if (this.m.bleed_type == 1 && this.m.ptr_hemo)
			return "This character is suffering from profuse internal bleeding from a recently received hit and will lose [color=%negative%]" + this.m.Damage + "[/color] hitpoints each turn for [color=%negative%]" + this.m.TurnsLeft + "[/color] more turn(s).";
		else if (this.m.bleed_type == 1)
			return "This character is bleeding profusely from a recently received wound and will lose [color=%negative%]" + this.m.Damage + "[/color] hitpoints each turn for [color=%negative%]" + this.m.TurnsLeft + "[/color] more turn(s).";
		else if (this.m.bleed_type == 5)
			return "This character is bleeding slowly from multiple recent deep grazes [color=%negative%]" + this.m.Damage + "[/color] hitpoints each turn for [color=%negative%]" + this.m.TurnsLeft + "[/color] more turn(s).";
		else
			return "This character is bleeding profusely from a recently received wound and will lose [color=%negative%]" + this.m.Damage + "[/color] hitpoints each turn for [color=%negative%]" + this.m.TurnsLeft + "[/color] more turn(s).";
	}

});