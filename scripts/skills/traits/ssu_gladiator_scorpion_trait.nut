this.ssu_gladiator_scorpion_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.ssu_gladiator_scorpion";
		this.m.Name = ::Mod_Sellswords.Strings.ssu_gladiator_scorpion_trait.Name;
		this.m.Icon = "ui/traits/ssu_gladiator_6.png";
		this.m.Description = ::Mod_Sellswords.Strings.ssu_gladiator_scorpion_trait.Description;
		this.m.Order = this.Const.SkillOrder.Trait - 1;
	}

	function getTooltip()
	{
		return [
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
				icon = "ui/icons/special.png",
				text = ::Mod_Sellswords.Strings.ssu_gladiator_scorpion_trait.Tooltip1
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Mod_Sellswords.Strings.ssu_gladiator_scorpion_trait.Tooltip2
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/asset_daily_money.png",
				text = ::Mod_Sellswords.Strings.ssu_gladiator_scorpion_trait.Wage
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.IsGladiator = true;
		_properties.DailyWageMult *= 1.5;
		_properties.IsImmuneToPoison = true;
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (!_skill.isAttack() || !_targetEntity.isAlive() || _targetEntity.isDying() || _targetEntity.getCurrentProperties().IsImmuneToPoison)
			return;

		if (!_targetEntity.isHiddenToPlayer())
		{
			this.Sound.play("sounds/combat/poison_applied_0" + this.Math.rand(1, 2) + ".wav", this.Const.Sound.Volume.Actor, _targetEntity.getPos());
			this.Tactical.EventLog.log(::Mod_Sellswords.text(::Mod_Sellswords.Strings.ssu_gladiator_scorpion_trait.Log, this.Const.UI.getColorizedEntityName(_targetEntity)));
		}

		local poisons = [
			::Legends.Effect.GoblinPoison,
			::Legends.Effect.SpiderPoison,
			::Legends.Effect.LegendRedbackSpiderPoison,
			::Legends.Effect.LegendZombiePoison,
			::Legends.Effect.LegendBasiliskPoison
		];
		local missing = poisons.filter(@(_, _poison) !_targetEntity.getSkills().hasEffect(_poison));

		if (missing.len() == 0)
		{
			::Legends.Effects.get(_targetEntity, poisons[this.Math.rand(0, poisons.len() - 1)]).resetTime();
			return;
		}

		// the poisons that deal damage credit their kills to the gladiator
		local actor = this.getContainer().getActor();
		::Legends.Effects.grant(_targetEntity, missing[this.Math.rand(0, missing.len() - 1)], function( _effect ) {
			if ("setActor" in _effect)
				_effect.setActor(actor);
		});
	}

});
