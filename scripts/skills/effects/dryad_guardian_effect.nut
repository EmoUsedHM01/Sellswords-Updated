this.dryad_guardian_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effect.dryad_guardian";
		this.m.Name = " ";
		this.m.Description = " ";
		this.m.Icon = "";
		this.m.Type = this.Const.SkillType.Special | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.VeryLast;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = true;
	}

	function onUpdate( _properties )
	{
		if (("State" in this.Tactical) && this.Tactical.State != null)
		{
		}
		else
		{
			return;
		}

		local actor = this.getContainer().getActor();
		local percHP = actor.getHitpointsPct();

		if (!actor.getSkills().hasSkill("effects.legend_second_wind"))
		{
			if (percHP < 0.5)
			{
				actor.setFatigue(actor.getFatigue() - 0.5 * actor.getFatigue());
				actor.getSkills().add(this.new("scripts/skills/effects/legend_second_wind_effect"));
				actor.getSkills().add(this.new("scripts/skills/effects/recovery_potion_effect"));
				actor.getSkills().add(this.new("scripts/skills/effects/adrenaline_effect"));

				local effectsToRemove = [
				"effects.stunned",
				"effects.dazed",
				"effects.legend_dazed",
				"effects.staggered",
				"effects.legend_baffled",
				"effects.charmed",
				"effects.sleeping"
				];

				foreach(effect in effectsToRemove)
					if (this.m.Container.hasSkill(effect))
						this.m.Container.removeByID(effect);

				this.Sound.play("sounds/combat/rage_02.wav", this.Const.Sound.Volume.RacialEffect * 2.0, actor.getPos());
				_properties.ActionPoints += 3;
				_properties.DamageTotalMult *= 2;

				local actor = this.getContainer().getActor().get();
				local sprite = actor.addSprite("sprite");
				sprite.setBrush("bust_dryad_guardian_effect");
				sprite.Visible = true;
				actor.setDirty(true);
			}
		}
	}

});