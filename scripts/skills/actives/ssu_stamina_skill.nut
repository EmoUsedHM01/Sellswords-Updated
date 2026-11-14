this.ssu_stamina_skill <- this.inherit("scripts/skills/skill", {
	m = {
		time = 1,
		usable = true
	},
	function create()
	{
		this.m.ID = "actives.ssu_stamina";
		this.m.Name = ::Mod_Sellswords.Strings.ssu_stamina_skill.Name;
		this.m.Description = ::Mod_Sellswords.Strings.ssu_stamina_skill.Description;
		this.m.Icon = "skills/dawn_cricle.png";
		this.m.IconDisabled = "skills/dawn_cricle_bw.png";
		this.m.Overlay = "perk_37_active";
		this.m.SoundOnUse = [];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.Any;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = false;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.ActionPointCost = 0;
		this.m.FatigueCost = 10;
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
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.ssu_stamina_skill.Tooltip1, this.m.time)
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Mod_Sellswords.Strings.ssu_stamina_skill.Tooltip2
			}			
			
		];
		return ret;
	}
	
	function isUsable()
	{
		if (this.m.usable)
		{
			return true;
		}

		return false;
	}	

	function onUse( _user, _targetTile )
	{
		local actor = this.getContainer().getActor();
		actor.setActionPoints(this.Math.min(actor.getActionPointsMax(), actor.getActionPoints() + this.m.time));
		if (this.m.time < 9)
		{
			this.m.time += 1;
		}
		else
		{
			this.m.time = 1;		
		}
		this.m.usable = false;			
	}
	
	function onAfterUpdate( _properties )
	{
		this.m.FatigueCost += 5 * (this.m.time - 1);
	}	
	
	function onTurnStart()
	{
		this.m.usable = true;		
	}

	function onCombatStarted()
	{
		this.m.time = 1;			
	}
	
	function onCombatFinished()
	{
		this.m.time = 1;
		this.m.usable = true;		
	}	

});

