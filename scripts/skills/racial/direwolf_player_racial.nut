this.direwolf_player_racial <- this.inherit("scripts/skills/skill", {
	m = {
	},
	function create()
	{
		this.m.ID = "racial.direwolf_player";
		this.m.Name = "Direwolf";
		this.m.Description = "This character counts as a Direwolf in skill checks, and gains the Direwolf racial trait which is increasing damage in proportion to missing health.";
		this.m.Icon = "ui/perks/favoured_direwolf_01.png";
		this.m.IconMini = "";
		this.m.Overlay = "status_effect_0";
		this.m.IsRemovedAfterBattle = false;
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		if (this.getContainer().getActor().getFlags().has("werewolf_w"))
		{
			_properties.Hitpoints += 10;
			_properties.Stamina += 10;
			_properties.Initiative += 10;
			_properties.MeleeSkill += 5;
			_properties.MeleeDefense += 5;
			
		}
		
		local healthMissing = _properties.Hitpoints - this.getContainer().getActor().getHitpoints();
		local additionalDamage = this.Math.floor(healthMissing * 0.25);

		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			additionalDamage = this.Math.floor(healthMissing * 0.5);
		}

		if (additionalDamage > 0)
		{
			_properties.DamageRegularMin += additionalDamage;
			_properties.DamageRegularMax += additionalDamage;
		}
	}

	function getTooltip()
	{
		local healthMissing = this.getContainer().getActor().getHitpointsMax() - this.getContainer().getActor().getHitpoints();
		local additionalDamage = this.Math.floor(healthMissing * 0.25);

		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			additionalDamage = this.Math.floor(healthMissing * 0.5);
		}

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
				icon = "ui/icons/special.png",
				text = "Attacks do [color=%negative%]" + additionalDamage + "[/color] more damage"
			}
			
		];

		if (this.getContainer().getActor().getFlags().has("werewolf_w"))
		{
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/health.png",
				text = "+[color=%positive%]" + 10 + "[/color] Hitpoints"
			});
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "+[color=%positive%]" + 10 + "[/color] Fatigue"
			});
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "+[color=%positive%]" + 10 + "[/color] Initiative"
			});
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "+[color=%positive%]" + 5 + "[/color] Melee Skill"
			});
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "+[color=%positive%]" + 5 + "[/color] Melee Defense"
			});
		}
		
		ret.push({
			id = 12,
			type = "hint",
			icon = "ui/tooltips/warning.png",
			text = "Further mutations may cause this character\'s genes to spiral out of control, crippling them"
		});


		return ret;
	}

});