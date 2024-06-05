this.perk_crBackswing <- this.inherit("scripts/skills/skill", {
	m = {
		IsSpent = false,
		IsInforce = false
	},
	function create()
	{
		this.m.ID = "perk.crBackswing";
		this.m.Name = this.Const.Strings.PerkName.crBackswing;
		this.m.Description = this.Const.Strings.PerkDescription.crBackswing;
		this.m.Icon = "ui/perks/crBackswing.png";
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}
	
	function onTargetMissed( _skill, _targetEntity )
	{
		if (_skill.m.ActionPointCost >= 2 && !this.m.IsSpent)
		{
			local actor = this.getContainer().getActor();
			actor.setActionPoints(this.Math.min(actor.getActionPointsMax(), actor.getActionPoints() + 3));
			actor.setDirty(true);
			local tile = actor.getTile();
			this.m.IsInforce = true;			
			this.m.IsSpent = true;			
		}
	}
	
	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (!this.m.IsInforce)
		{
			return;
		}
		
		if (_skill.isAttack())
		{
			_properties.DamageTotalMult *= 0.85;
			_properties.MeleeSkill *= 0.85;
			_properties.RangedSkill *= 0.85;	
			this.m.IsInforce = false;
		}
	}	

	function onTurnStart()
	{
		this.m.IsSpent = false;
	}	

});
