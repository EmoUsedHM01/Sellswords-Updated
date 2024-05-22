this.cr_clarity_skill <- this.inherit("scripts/skills/skill", {
	m = {
		usable = true
	},
	function create()
	{
		this.m.ID = "actives.cr_clarity";
		this.m.Name = "Clarify";
		this.m.Description = "A well honed mind can perceive more in each instant, making time appear slower in key instants of need.";
		this.m.Icon = "skills/crClarity_skill.png";
		this.m.IconDisabled = "skills/crClarity_skill_bw.png";
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
		return this.skill.isUsable() && !this.getContainer().hasSkill("effects.cr_clarity");
	}

	function onUse( _user, _targetTile )
	{
		if (!this.getContainer().hasSkill("effects.cr_clarity"))
		{
			this.m.Container.add(this.new("scripts/skills/effects/cr_clarity_effect"));
			return true;
		}

		return false;
	}	

});

