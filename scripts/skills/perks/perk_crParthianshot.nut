this.perk_crParthianshot <- this.inherit("scripts/skills/skill", {
	m = {
		HasMoved = false,		
	},
	function create()
	{
		this.m.ID = "perk.crParthianshot";
		this.m.Name = this.Const.Strings.PerkName.crParthianshot;
		this.m.Description = this.Const.Strings.PerkDescription.crParthianshot;
		this.m.Icon = "ui/perks/partian_shot_perk.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate ( _properties )
	{
		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon == null || !weapon.isWeaponType(this.Const.Items.WeaponType.Bow))
		{
			return;
		}
				
		local actor = this.getContainer().getActor();
		local ap = actor.getActionPoints();		

		_properties.DamageDirectMult *= 1.0 + 0.02 * ap;
		_properties.DamageAgainstMult[this.Const.BodyPart.Body] *= 1.0 + 0.02 * ap;			
		_properties.DamageAgainstMult[this.Const.BodyPart.Head] *= 1.0 + 0.02 * ap;
				
		if (this.m.HasMoved == false && this.getContainer().getActor().m.IsMoving)
		{
			this.m.HasMoved = true;
			local myTile = actor.getTile();			
			actor.setActionPoints(this.Math.min(actor.getActionPointsMax(), actor.getActionPoints() + this.Math.max(0, actor.getActionPointCosts()[myTile.Type] * _properties.MovementAPCostMult)));
			actor.setFatigue(this.Math.max(0, actor.getFatigue() - this.Math.max(0, actor.getFatigueCosts()[myTile.Type] * _properties.MovementFatigueCostMult)));			
		}		
	
	}
		
	function onTurnStart()
	{
		this.m.HasMoved = false;		
	}
	
	function onAdded()
	{
		if (("State" in this.Tactical) && this.Tactical.State != null)
		{
			this.m.HasMoved = false;
		}
	}

	function onCombatStarted()
	{
		this.m.HasMoved = false;		
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.HasMoved = false;	
	}	
});
