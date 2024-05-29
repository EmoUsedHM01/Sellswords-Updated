this.perk_crHonorheritage <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.crHonorheritage";
		this.m.Name = this.Const.Strings.PerkName.crHonorheritage;
		this.m.Description = "This character has not moved yet and can take %their% time to get a better aim for ranged attacks.";
		this.m.Icon = "ui/perks/crHonorheritage.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onTurnEnd()
	{
		if (this.Math.rand(1, 100) < 65)
			return;

		if (this.getContainer().getActor().getMoraleState() == 4)
			return;

		if (!this.getContainer().getActor().isHiddenToPlayer() && this.getContainer().getActor().getTile().IsVisibleForPlayer)
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(getContainer().getActor()) + "\'s increases morale due to Honor Heritage");

		if (::Is_PTR_Exist) 
			this.spawnIcon("perk_ptr_exude_confidence", this.getContainer().getActor().getTile());

		this.getContainer().getActor().setMoraleState(this.Math.min(4, this.getContainer().getActor().getMoraleState() + 1));		
	}

	function onUpdate( _properties )
	{
		this.getContainer().getActor().getAIAgent().getProperties().BehaviorMult[this.Const.AI.Behavior.ID.Retreat] = 0.0;	
		this.getContainer().getActor().getAIAgent().getProperties().BehaviorMult[this.Const.AI.Behavior.ID.EngageMelee] *= 5.0;			
	}	

});