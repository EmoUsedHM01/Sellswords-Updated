this.ssu_assistance_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.ssu_assistance";
		this.m.Name = ::Mod_Sellswords.Strings.ssu_assistance_skill.Name;
		this.m.Description = ::Mod_Sellswords.Strings.ssu_assistance_skill.Description;
		this.m.Icon = "skills/ssu_active_assistance.png";
		this.m.IconDisabled = "skills/ssu_active_assistance_sw.png";
		this.m.SoundOnUse = [
			"sounds/combat/inspire_01.wav",
			"sounds/combat/inspire_02.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.Any;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = false;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 30;
		this.m.MinRange = 0;
		this.m.MaxRange = 0;
	}

	function getTooltip()
	{
		local ret = this.getDefaultUtilityTooltip();
		local effect = this.new("scripts/skills/effects/ssu_assistance_effect");
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Mod_Sellswords.Strings.ssu_assistance_skill.Tooltip1
		});
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/damage_dealt.png",
			text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.ssu_assistance_skill.Tooltip2, effect.m.DamageMalus)
		});

		if (!this.hasTwoHandedMeleeWeapon())
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = ::Mod_Sellswords.Strings.ssu_assistance_skill.WarningWeapon
			});
		}

		if (this.getContainer().getActor().isEngagedInMelee())
		{
			ret.push({
				id = 9,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = ::Mod_Sellswords.Strings.ssu_assistance_skill.WarningEngaged
			});
		}

		return ret;
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();

		if (actor.isPlayerControlled())
		{
			return;
		}

		local agent = actor.getAIAgent();

		if (agent != null && agent.findBehavior(this.Const.AI.Behavior.ID.SsuAssistance) == null)
		{
			agent.addBehavior(this.new("scripts/ai/tactical/behaviors/ssu_ai_assistance"));
			agent.finalizeBehaviors();
		}
	}

	function hasTwoHandedMeleeWeapon()
	{
		local weapon = this.getContainer().getActor().getMainhandItem();
		return weapon != null && weapon.isItemType(this.Const.Items.ItemType.TwoHanded) && weapon.isItemType(this.Const.Items.ItemType.MeleeWeapon);
	}

	function isUsable()
	{
		if (!this.hasTwoHandedMeleeWeapon() || this.getContainer().getActor().isEngagedInMelee())
		{
			return false;
		}

		return this.skill.isUsable() && !this.getContainer().hasSkill("effects.ssu_assistance");
	}

	function isHidden()
	{
		return !this.hasTwoHandedMeleeWeapon();
	}

	function onUse( _user, _targetTile )
	{
		this.m.Container.add(this.new("scripts/skills/effects/ssu_assistance_effect"));
		return true;
	}

});
