this.ssu_rapidmarch_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 1,
		StartingTile = null
	},
	function create()
	{
		this.m.ID = "effects.ssu_rapidmarch";
		this.m.Name = this.Const.Strings.PerkName.SsuRapidmarch;
		this.m.Icon = "ui/perks/ssu_rapidmarch.png";
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
		local distanceMoved = this.m.StartingTile.getDistanceTo(actor.getTile());	
		if (distanceMoved >= 4)
		{
			return;		
		}
		
		_properties.MovementAPCostAdditional -= 1;
		_properties.MovementFatigueCostMult += 1;
	}
	
	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();
		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Mod_Sellswords.Strings.ssu_rapidmarch_effect.Tooltip
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

