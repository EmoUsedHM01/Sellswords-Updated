::Mod_Sellswords.HooksMod.hook("scripts/skills/effects/legend_skin_ghoul_blood_effect", function( q ) {

	q.m.SoundsA <- [
		"sounds/combat/cleave_hit_hitpoints_01.wav",
		"sounds/combat/cleave_hit_hitpoints_02.wav",
		"sounds/combat/cleave_hit_hitpoints_03.wav"
	];

	q.create = @(__original) function()
	{
		__original();

		this.m.TurnsLeft = 3;
		this.m.Icon = "skills/status_effect_79.png";
		this.m.Overlay = "status_effect_79";
	}

	q.getTooltip = @(__original) function()
	{
		local actor = this.getContainer().getActor();
		local healthMissing = actor.getHitpointsMax() - actor.getHitpoints();
		local healthAdded = this.Math.min(0.75 * healthMissing, 75);
		local ret = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/days_wounded.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+ " + healthAdded + "[/color] this turn"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/days_wounded.png",
				text = "cure all fresh injuries"
			}
		];
		return ret;
	}

	q.onTurnEnd = @(__original) function()
	{
	}

	q.onTurnStart = @(__original) function()
	{
		if (--this.m.TurnsLeft <= 0)
			this.removeSelf();

		local actor = this.getContainer().getActor();
		local healthMax = actor.getHitpointsMax();
		local bleed = this.new("scripts/skills/effects/bleeding_effect");
		bleed.setDamage(healthMax * 0.1);
		bleed.m.bleed_type = 1;		
		actor.getSkills().add(bleed);
		this.Sound.play(this.m.SoundsA[this.Math.rand(0, this.m.SoundsA.len() - 1)], this.Const.Sound.Volume.Skill, actor.getPos());
	}

	q.onAdded = @(__original) function()
	{
		local actor = this.getContainer().getActor();
		local skills = actor.getSkills().getAllSkillsOfType(this.Const.SkillType.TemporaryInjury);

		foreach( s in skills )
			s.removeSelf();

		local healthMissing = actor.getHitpointsMax() - actor.getHitpoints();
		local healthAdded = this.Math.min(0.75 * healthMissing, 75);

		if (healthAdded <= 0)
			return;

		actor.setHitpoints(actor.getHitpoints() + healthAdded);
		actor.setDirty(true);

		if (!actor.isHiddenToPlayer())
		{
			this.spawnIcon("status_effect_79", actor.getTile());

			if (this.m.SoundOnUse.len() != 0)
				this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.RacialEffect * 1.25, actor.getPos());

			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(actor) + " heals for " + healthAdded + " points");
		}
	}

});