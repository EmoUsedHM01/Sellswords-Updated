this.ssu_clarity_skill <- this.inherit("scripts/skills/skill", {
	m = {
		usable = true
	},
	function create()
	{
		this.m.ID = "actives.ssu_clarity";
		this.m.Name = ::Mod_Sellswords.Strings.ssu_clarity_skill.Name;
		this.m.Description = ::Mod_Sellswords.Strings.ssu_clarity_skill.Description;
		this.m.Icon = "skills/ssu_clarity_skill.png";
		this.m.IconDisabled = "skills/ssu_clarity_skill_bw.png";
		this.m.SoundOnUse = [];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.Any;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = false;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.ActionPointCost = 0;
		this.m.FatigueCost = 5;
		this.m.MinRange = 0;
		this.m.MaxRange = 0;
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
			},
			{
				id = 3,
				type = "text",
				text = this.getCostString()
			},			
		];
		return ret;
	}
	
	function isUsable()
	{
		return this.skill.isUsable() && !this.getContainer().hasSkill("effects.ssu_clarity");
	}

	function onUse( _user, _targetTile )
	{
		if (!this.getContainer().hasSkill("effects.ssu_clarity"))
		{
			this.m.Container.add(this.new("scripts/skills/effects/ssu_clarity_effect"));
			return true;
		}

		return false;
	}	

});

