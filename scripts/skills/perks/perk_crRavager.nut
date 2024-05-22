this.perk_crRavager <- this.inherit("scripts/skills/skill", {
	m = {
		chance = 0
	},
	function create()
	{
		this.m.ID = "perk.crRavager";
		this.m.Name = this.Const.Strings.PerkName.crRavager;
		this.m.Description = this.Const.Strings.PerkDescription.crRavager;
		this.m.Icon = "ui/perks/crRavager.png";
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
	
	function onGetHitFactors( _skill, _targetTile, _tooltip )
	{
		local targetEntity = _targetTile.getEntity();
		if (targetEntity != null && _skill.isAttack() && this.m.chance > 0)
		{
			_tooltip.push({
				icon = "ui/tooltips/positive.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.chance + "%[/color]" + this.getName()
			});
		}
	}	
});
