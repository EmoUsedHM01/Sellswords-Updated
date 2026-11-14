this.perk_ssu_tic <- this.inherit("scripts/skills/skill", {
	m = {
		Effects = [
			"effects.debilitated",			
			"effects.bleeding",		
			"effects.staggered",
			"effects.goblin_poison",			
			"effects.legend_zombie_poison",
			"effects.spider_poison",			
			"effects.dazed"
		]	
	},
	function create()
	{
		this.m.ID = "perk.ssu_tic";
		this.m.Name = this.Const.Strings.PerkName.SsuTic;
		this.m.Description = this.Const.Strings.PerkDescription.SsuTic;
		this.m.Icon = "ui/perks/ssu_tic.png";
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function isHidden()
	{
		local actor = this.getContainer().getActor();	
		local InjuriesNum = actor.getSkills().query(this.Const.SkillType.TemporaryInjury).len() + actor.getSkills().query(this.Const.SkillType.PermanentInjury).len();
		local count = actor.getSkills().getSkillsByFunction((@(_skill) this.m.Effects.find(_skill.getID()) != null).bindenv(this)).len();		
		local currentHPPercent = this.Math.floor(3.334 * (1 - actor.getHitpointsPct()));	
		local currentFATPercent = this.Math.floor(3.334 * actor.getFatigue() / actor.getFatigueMax());	
		return InjuriesNum < 1 && count < 1 && currentHPPercent < 1 && currentFATPercent < 1;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();

		local actor = this.getContainer().getActor();	
		local InjuriesNum = actor.getSkills().query(this.Const.SkillType.TemporaryInjury).len() + actor.getSkills().query(this.Const.SkillType.PermanentInjury).len();
		local count = actor.getSkills().getSkillsByFunction((@(_skill) this.m.Effects.find(_skill.getID()) != null).bindenv(this)).len();
		local currentHPPercent = this.Math.floor(3.334 * (1 - actor.getHitpointsPct()));	
		local currentFATPercent = this.Math.floor(3.334 * actor.getFatigue() / actor.getFatigueMax());

		if (count > 0)
		{
			tooltip.push({
				id = 10,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.perk_ssu_tic.Tooltip1, 5 * count)
			});
		}
		if (InjuriesNum > 0)
		{
			tooltip.push({
				id = 10,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.perk_ssu_tic.Tooltip2, 5 * InjuriesNum)
			});
			tooltip.push({
				id = 10,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.perk_ssu_tic.Tooltip3, 5 * InjuriesNum)
			});			
		}		
		if (currentHPPercent > 0)
		{
			tooltip.push({
				id = 10,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.perk_ssu_tic.Tooltip4, 5 * currentHPPercent)
			});
		}
		if (currentFATPercent > 0)
		{
			tooltip.push({
				id = 10,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.perk_ssu_tic.Tooltip5, 5 * currentFATPercent)
			});
		}
		if (InjuriesNum >= 1 && count >= 1 && currentHPPercent >= 1 && currentFATPercent >= 1)
		{
			tooltip.push({
				id = 10,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.perk_ssu_tic.Tooltip6, 15)
			});
			tooltip.push({
				id = 10,
				type = "text",
				icon = "ui/icons/sturdiness.png",
				text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.perk_ssu_tic.Tooltip7, 15)
			});			
		}		
		
		return tooltip;
	}
	
	function onUpdate( _properties )
	{
		local actor = this.getContainer().getActor();	
		local InjuriesNum = actor.getSkills().query(this.Const.SkillType.TemporaryInjury).len() + actor.getSkills().query(this.Const.SkillType.PermanentInjury).len();
		local count = actor.getSkills().getSkillsByFunction((@(_skill) this.m.Effects.find(_skill.getID()) != null).bindenv(this)).len();
		local currentHPPercent = this.Math.floor(3.334 * (1 - this.getContainer().getActor().getHitpointsPct()));	
		local currentFATPercent = this.Math.floor(3.334 * actor.getFatigue() / actor.getFatigueMax());		
		_properties.MeleeDefense += 5 * InjuriesNum;		
		_properties.MeleeSkill += 5 * count;
		_properties.Bravery += 5 * currentHPPercent;
		_properties.Initiative += 5 * currentFATPercent;
		if (InjuriesNum >= 1 && count >= 1 && currentHPPercent >= 1 && currentFATPercent >= 1)
		{
			_properties.DamageReceivedTotalMult *= 0.85;
			_properties.DamageTotalMult *= 1.15;			
		}
	}

	function onTurnStart()
	{
		this.getContainer().getActor().setMoraleState(this.Const.MoraleState.Wavering);
	}	
	
});

