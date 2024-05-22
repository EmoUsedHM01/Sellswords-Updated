this.crrapidmarch_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 1,
		StartingTile = null
	},
	function create()
	{
		this.m.ID = "effects.crrapidmarch";
		this.m.Name = this.Const.Strings.PerkName.crRapidmarch;
		this.m.Icon = "ui/perks/crrapidmarch.png";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = false;		
		this.m.IsHidden = false;
	}	

	function onAfterUpdate( _properties )
	{
		if (!this.getContainer().getActor().isPlacedOnMap())
		{
			return;
		}	
		
		local actor = this.getContainer().getActor();
		//added by bigmap
		if (actor == null || this.m.StartingTile == null)
		{
			return;		
		}		
		//this.logInfo("tile: " + this.m.StartingTile);		
		local distanceMoved = this.m.StartingTile.getDistanceTo(actor.getTile());	
		if (distanceMoved >= 4)
		{
			return;		
		}
		
		_properties.MovementAPCostAdditional -= 1;
		//_properties.MovementAPCostMult = 1.0;
		//_properties.MovementFatigueCostAdditional = 0;
		_properties.MovementFatigueCostMult += 1;
	}
	
	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();
		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Action Point cost for movement is reduced by [color=" + this.Const.UI.Color.PositiveValue + "]1[/color] for each tile, but the Fatigue cost is doubled."
		});		
		return tooltip;
	}
	
	function onAdded()
	{
		this.m.StartingTile = this.getContainer().getActor().getTile();		
	}	
	
	function onTurnEnd()
	{
		this.m.StartingTile = null;	
		if (--this.m.TurnsLeft <= 0)
		{
			this.removeSelf();
		}
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.StartingTile = null;
	}	
});

