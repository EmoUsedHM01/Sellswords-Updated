this.mod_insect_breath <- this.inherit("scripts/skills/skill", {
	m = {
		IsSpent = false
	},
	function create()
	{
		this.m.ID = "actives.insect_breath";
		this.m.Name = "Insects Breath";
		this.m.Description = "Exhale a swarm of malevolent insects, enveloping your foes in a torrential cloud of biting and stinging creatures.";
		this.m.Icon = "skills/active_69.png";
		this.m.IconDisabled = "skills/active_69_sw.png";
		this.m.Overlay = "active_69";
		this.m.SoundOnUse = [
			"sounds/status/insect_swarm_effect_01.wav",
			"sounds/status/insect_swarm_effect_02.wav",
			"sounds/status/insect_swarm_effect_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.UtilityTargeted;
		this.m.Delay = 0;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsRanged = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsShowingProjectile = false;
		this.m.IsUsingHitchance = false;
		this.m.IsDoingForwardMove = false;
		this.m.ActionPointCost = 3;
		this.m.FatigueCost = 15;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.MaxLevelDifference = 4;
	}

	function getTooltip()
	{
		local ret = this.getDefaultUtilityTooltip();

		if (this.m.IsSpent)
		{
			ret.push({
				id = 9,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=%negative%]Can only be used once per battle[/color]"
			});
		}

		return ret;
	}

	function isUsable()
	{
		return this.skill.isUsable() && !this.m.IsSpent;
	}

	function onUse( _user, _targetTile )
	{
		this.m.IsSpent = true;
		local target = _targetTile.getEntity();
		local effect = target.getSkills().getSkillByID("effects.insect_swarm");

		if (effect != null)
			effect.m.TurnsLeft = this.Math.max(1, 7 + target.getCurrentProperties().NegativeStatusEffectDuration);
		else
		{
			local insect = this.new("scripts/skills/effects/insect_swarm_effect");
			target.getSkills().add(insect);
			insect.m.TurnsLeft = this.Math.max(1, 7 + target.getCurrentProperties().NegativeStatusEffectDuration);
		}

		return true;
	}

	function onCombatStarted()
	{
		this.m.IsSpent = false;
	}

	function onCombatFinished()
	{
		this.m.IsSpent = false;
	}

});