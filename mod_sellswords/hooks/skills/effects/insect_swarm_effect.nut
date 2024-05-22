::mods_hookExactClass("skills/effects/insect_swarm_effect", function ( o )
{
	o.onAdded = function ()
	{
		local actor = this.getContainer().getActor();
		local crrd = this.getContainer().hasSkill("perk.crrangeddefense") ? this.Math.rand(1, 100) <= actor.getBaseProperties().RangedDefense : false;

		if (this.getContainer().getActor().getCurrentProperties().IsResistantToAnyStatuses && this.Math.rand(1, 100) <= 50 || crrd)
		{
			if (!this.getContainer().getActor().isHiddenToPlayer())
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(this.getContainer().getActor()) + " repels insects with his unnatural physiology");
			}

			this.removeSelf();
		}
		else
		{
			this.m.TurnsLeft = this.Math.max(1, 3 + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);
			this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.Skill, this.getContainer().getActor().getPos());
			local actor = this.getContainer().getActor();
			this.addSprite(1, "bust_flies_01");
			this.addSprite(2, "bust_flies_02");
			this.addSprite(3, "bust_flies_03");
			this.addSprite(4, "bust_flies_04");
			this.addSprite(5, "bust_flies_05");
			this.addSprite(6, "bust_flies_06");
			this.addSprite(7, "bust_flies_07");
			this.addSprite(8, "bust_flies_08");
			this.addSprite(9, "bust_flies_09", true);
			this.addSprite(10, "bust_flies_10", true);
			this.addSprite(11, "bust_flies_04", true);
			this.addSprite(12, "bust_flies_05", true);
			this.addSprite(13, "bust_flies_06", true);
			this.addSprite(14, "bust_flies_08");
			this.addSprite(15, "bust_flies_05");
			actor.setSpriteOffset("insects_14", this.createVec(-20, 0));
			actor.setSpriteOffset("insects_15", this.createVec(10, 0));
		}
	};
	o.onUpdate = function ( _properties )
	{
		if (this.getContainer().hasSkill("perk.crresilient"))
		{
			_properties.MeleeSkillMult *= 0.63;
			_properties.RangedSkillMult *= 0.63;
			_properties.MeleeDefenseMult *= 0.63;
			_properties.RangedDefenseMult *= 0.63;
			_properties.InitiativeMult *= 0.63;
		}
		else
		{
			_properties.MeleeSkillMult *= 0.5;
			_properties.RangedSkillMult *= 0.5;
			_properties.MeleeDefenseMult *= 0.5;
			_properties.RangedDefenseMult *= 0.5;
			_properties.InitiativeMult *= 0.5;
		}		
	}		
});