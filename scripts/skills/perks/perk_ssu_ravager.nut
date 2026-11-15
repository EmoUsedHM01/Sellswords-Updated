this.perk_ssu_ravager <- this.inherit("scripts/skills/skill", {
	m = {
		chance = 0
	},
	function create()
	{
		this.m.ID = "perk.ssu_ravager";
		this.m.Name = this.Const.Strings.PerkName.SsuRavager;
		this.m.Description = this.Const.Strings.PerkDescription.SsuRavager;
		this.m.Icon = "ui/perks/perk_56.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null || _targetEntity.getMoraleState() == this.Const.MoraleState.Ignore || !_skill.isAttack())
		{
			return;
		}
		local actor = this.getContainer().getActor();
		local difference = actor.getMoraleState() - _targetEntity.getMoraleState();

		this.m.chance = this.Math.max(0, difference * 5);
		this.m.chance += this.Math.maxf(0, _targetEntity.getFatiguePct()-0.1) * 20;		

		_properties.MeleeSkill += this.m.chance;
		_properties.RangedSkill += 0.5 * this.m.chance;	
	}
	
});
