// Shared by the effects of all Sequences
// Sequences have one effect, which grows once the stronger Strain is taken
this.ssu_sequence_effect <- this.inherit("scripts/skills/skill", {
	m = {
		Sequence = "",
		StrongIcon = ""
	},
	function create()
	{
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = false;
		this.m.IsStacking = false;
	}

	// ::Mod_Sellswords.Sequences
	function setSequence( _sequence )
	{
		this.m.Sequence = _sequence;
		this.m.ID = "effects.ssu_" + _sequence + "_sequence";
		this.m.Name = this.getStrings().Name;
		this.m.Description = this.getStrings().Description;
	}

	function getStrings()
	{
		return ::Mod_Sellswords.Strings["ssu_" + this.m.Sequence + "_sequence_effect"];
	}

	function isStrong()
	{
		local flag = ::Mod_Sellswords.Sequences[this.m.Sequence].StrongFlag;
		return flag != null && this.getContainer().getActor().getFlags().has(flag);
	}

	function getIconColored()
	{
		if (this.m.StrongIcon != "" && this.m.Container != null && !this.m.Container.isNull() && this.isStrong())
			return this.m.StrongIcon;

		return this.m.Icon;
	}

	function getIcon()
	{
		return this.getIconColored();
	}

	function onStrainAdded()
	{
	}

	function getTooltip()
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

		foreach (text in this.getStrings().Weak)
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = text
			});
		}

		if (this.isStrong())
		{
			foreach (text in this.getStrings().Strong)
			{
				ret.push({
					id = 11,
					type = "text",
					icon = "ui/icons/special.png",
					text = text
				});
			}
		}

		ret.push({
			id = 12,
			type = "hint",
			icon = "ui/tooltips/warning.png",
			text = ::Mod_Sellswords.Strings.ssu_sequence_effect.Warning
		});
		return ret;
	}

	function keepSkill( _id, _script )
	{
		if (!this.getContainer().hasSkill(_id))
			this.getContainer().add(this.new(_script));
	}

	function isPoisoned()
	{
		local skills = this.getContainer();
		return skills.hasEffect(::Legends.Effect.SpiderPoison) || skills.hasEffect(::Legends.Effect.LegendRedbackSpiderPoison) || skills.hasEffect(::Legends.Effect.LegendRswPoisonPoison);
	}

	// Venom Glands of the Snake and Spider Sequences
	function applyVenom( _skill, _targetEntity, _damageInflictedHitpoints, _id, _script )
	{
		if (_targetEntity == null || !_targetEntity.isAlive() || _targetEntity.isDying())
			return;

		if (!_skill.isAttack() || !(_skill.getDamageType().contains(this.Const.Damage.DamageType.Piercing) || _skill.getDamageType().contains(this.Const.Damage.DamageType.Cutting)))
			return;

		if (_targetEntity.getCurrentProperties().IsImmuneToPoison || _targetEntity.getFlags().has("undead") || _damageInflictedHitpoints < this.Const.Combat.PoisonEffectMinDamage)
			return;

		local poison = _targetEntity.getSkills().getSkillByID(_id);

		if (poison == null)
			_targetEntity.getSkills().add(this.new(_script));
		else
			poison.resetTime();

		this.spawnIcon("status_effect_54", _targetEntity.getTile());

		if (!_targetEntity.isHiddenToPlayer())
			this.Tactical.EventLog.log(::Mod_Sellswords.text(::Mod_Sellswords.Strings.ssu_sequence_effect.LogPoisoned, this.Const.UI.getColorizedEntityName(_targetEntity)));
	}

	// Hyperactive Cell Growth of the Ghoul and Unhold Sequences
	function regenerate( _hitpoints )
	{
		local actor = this.getContainer().getActor();
		local healed = this.Math.min(actor.getHitpointsMax() - actor.getHitpoints(), _hitpoints);

		if (healed <= 0)
			return;

		actor.setHitpoints(actor.getHitpoints() + healed);
		actor.setDirty(true);

		if (!actor.isHiddenToPlayer())
		{
			this.spawnIcon("status_effect_79", actor.getTile());
			this.Sound.play("sounds/enemies/unhold_regenerate_01.wav", this.Const.Sound.Volume.RacialEffect * 1.25, actor.getPos());
			this.Tactical.EventLog.log(::Mod_Sellswords.text(::Mod_Sellswords.Strings.ssu_sequence_effect.LogHealed, this.Const.UI.getColorizedEntityName(actor), healed));
		}
	}

	function healFully()
	{
		local actor = this.getContainer().getActor();

		if (actor != null && !actor.isNull() && actor.isAlive())
		{
			actor.setHitpoints(actor.getHitpointsMax());
			actor.setDirty(true);
		}
	}

});
