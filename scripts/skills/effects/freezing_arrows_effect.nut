this.freezing_arrows_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.freezing_arrows";
		this.m.Name = " ";
		this.m.Description = " ";
		this.m.Icon = "";
		this.m.Type = this.Const.SkillType.Special | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.VeryLast;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = true;
	}
	
	function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		ret.extend([
			{
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Inflicts chill on targets for up to 2 turns, reducing their action points by 3 and initiative by 30."
			}
		]);
		return ret;
	}
	
	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		local actor = this.getContainer().getActor();
		if (::Mod_Sellswords.doArrowChecks( _skill, _targetEntity, actor))
			return;

		if (_targetEntity.getType() == this.Const.EntityType.TricksterGod)
			return;

		if (!_targetEntity.isHiddenToPlayer())
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_targetEntity) + " is chilled");

		local chilled = _targetEntity.getSkills().getSkillByID("effects.chilled");

		if (chilled == null)
			_targetEntity.getSkills().add(this.new("scripts/skills/effects/chilled_effect"));
		else
			chilled.resetTime();
	}

});