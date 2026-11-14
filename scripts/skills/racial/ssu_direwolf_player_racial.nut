this.ssu_direwolf_player_racial <- this.inherit("scripts/skills/skill", {
	m = {
	},
	function create()
	{
		this.m.ID = "racial.ssu_direwolf_player";
		this.m.Name = ::Mod_Sellswords.Strings.ssu_direwolf_player_racial.Name;
		this.m.Description = ::Mod_Sellswords.Strings.ssu_direwolf_player_racial.Description;
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
				text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.ssu_direwolf_player_racial.Tooltip1, additionalDamage)
			}
			
		];

		if (this.getContainer().getActor().getFlags().has("werewolf_w"))
		{
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/health.png",
				text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.ssu_direwolf_player_racial.Tooltip2, 10)
			});
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.ssu_direwolf_player_racial.Tooltip3, 10)
			});
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.ssu_direwolf_player_racial.Tooltip4, 10)
			});
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.ssu_direwolf_player_racial.Tooltip5, 5)
			});
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.ssu_direwolf_player_racial.Tooltip6, 5)
			});
		}
		
		ret.push({
			id = 12,
			type = "hint",
			icon = "ui/tooltips/warning.png",
			text = ::Mod_Sellswords.Strings.ssu_direwolf_player_racial.Tooltip7
		});


		return ret;
	}

});