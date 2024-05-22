this.crstamina_skill <- this.inherit("scripts/skills/skill", {
	m = {
		time = 1,
		usable = true
	},
	function create()
	{
		this.m.ID = "actives.crstamina";
		this.m.Name = "Unceasing Mysteries";
		this.m.Description = "The Grail ripped the Thunderskin from flesh. The Heart is the Blood's Drum, and here is its secret doctrine...";
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
				text = "Gain [color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.time + "[/color] action point"
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Will gain [color=" + this.Const.UI.Color.PositiveValue + "]1[/color] more action point and cost [color=" + this.Const.UI.Color.NegativeValue + "]5[/color] more fatigue each time you use it."
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
		//this.logInfo("times: " + this.m.time);
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

