this.perk_ssu_honorheritage <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.ssu_honorheritage";
		this.m.Name = this.Const.Strings.PerkName.SsuHonorheritage;
		this.m.Description = ::Mod_Sellswords.Strings.perk_ssu_honorheritage.Description;
		this.m.Icon = "ui/perks/ssu_honorheritage.png";
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
			this.Tactical.EventLog.log(::Mod_Sellswords.text(::Mod_Sellswords.Strings.perk_ssu_honorheritage.Log, this.Const.UI.getColorizedEntityName(getContainer().getActor())));

		this.getContainer().getActor().setMoraleState(this.Math.min(4, this.getContainer().getActor().getMoraleState() + 1));		
	}

	function onUpdate( _properties )
	{
		this.getContainer().getActor().getAIAgent().getProperties().BehaviorMult[this.Const.AI.Behavior.ID.Retreat] = 0.0;	
		this.getContainer().getActor().getAIAgent().getProperties().BehaviorMult[this.Const.AI.Behavior.ID.EngageMelee] *= 5.0;			
	}	

});