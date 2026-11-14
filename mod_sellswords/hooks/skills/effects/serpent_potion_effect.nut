//"Venom Glands"
//"This character has developed venom glands that allow them to produce poison strong enough to kill any man. Sadly they do not have the fangs of a snake or spider to deliver this venom and have to resort using piercing or cutting weapons to apply it.";
::Mod_Sellswords.HooksMod.hook("scripts/skills/effects/serpent_potion_effect", function ( q ) {

	q.create = @(__original) function()
	{
		__original();
		this.m.Name = ::Mod_Sellswords.Strings.serpent_potion_effect.Name;
	}

	q.getDescription = @(__original) function()
	{
		return ::Mod_Sellswords.Strings.serpent_potion_effect.Text;
	}

	q.getTooltip = @(__original) function()
	{
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
			}
		];

		if (this.getContainer().getActor().getFlags().has("spider_r"))
		{
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Mod_Sellswords.Strings.serpent_potion_effect.Tooltip1
			});
		}
		else
		{
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Mod_Sellswords.Strings.serpent_potion_effect.Tooltip2
			});
		}
		
		ret.push({
			id = 12,
			type = "hint",
			icon = "ui/tooltips/warning.png",
			text = ::Mod_Sellswords.Strings.serpent_potion_effect.Tooltip3
		});

		return ret;
	}

	
	q.onUpdate = @(__original) function(_properties)
	{
		if (this.getContainer().getActor().getFlags().has("spider_r"))
		{
			_properties.Initiative += 30;
			_properties.MeleeSkill += 15;
		}
		else
		{
			_properties.Initiative += 15;
			_properties.MeleeSkill += 5;
		}
	}

	q.onTargetHit <- function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{

		if (!_targetEntity.isAlive() || _targetEntity.isDying() || _targetEntity == null)
			return;

		if (_targetEntity.getCurrentProperties().IsImmuneToPoison || _damageInflictedHitpoints < this.Const.Combat.PoisonEffectMinDamage || _targetEntity.getHitpoints() <= 0)
			return;

		if (_targetEntity.getFlags().has("undead"))
			return;

		if (!_skill.isAttack() || !(_skill.getDamageType().contains(this.Const.Damage.DamageType.Piercing) || _skill.getDamageType().contains(this.Const.Damage.DamageType.Cutting)))
			return;

		if (!_targetEntity.isHiddenToPlayer())
		{
			if (this.m.SoundOnUse.len() != 0)
				this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.RacialEffect * 1.5, _targetEntity.getPos());
			
			this.Tactical.EventLog.log(::Mod_Sellswords.text(::Mod_Sellswords.Strings.serpent_potion_effect.Log, this.Const.UI.getColorizedEntityName(_targetEntity)));
		}

		this.spawnIcon("status_effect_54", _targetEntity.getTile());

		if (this.getContainer().getActor().getFlags().has("spider_r"))
		{
			local poison = _targetEntity.getSkills().getSkillByID("effects.legend_redback_spider_poison");
			if (poison == null) 
				_targetEntity.getSkills().add(this.new("scripts/skills/effects/legend_redback_spider_poison_effect"));
			else 
				poison.resetTime();
		}
		else
		{
			local poison = _targetEntity.getSkills().getSkillByID("effects.spider_poison");
			if (poison == null) 
				_targetEntity.getSkills().add(this.new("scripts/skills/effects/spider_poison_effect"));
			else 
				poison.resetTime();
		}
	}

});