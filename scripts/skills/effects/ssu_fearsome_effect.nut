this.ssu_fearsome_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.ssu_fearsome";
		this.m.Name = ::Mod_Sellswords.Strings.ssu_fearsome_effect.Name;
		this.m.Description = ::Mod_Sellswords.Strings.ssu_fearsome_effect.Description;
		this.m.Icon = "ui/perks/perk_27.png";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip()
	{
		return [
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
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Mod_Sellswords.Strings.ssu_fearsome_effect.Tooltip
			}
		];
	}

	function onTargetMissed( _skill, _targetEntity )
	{
		if (_targetEntity == null)
			return;

		if (!_targetEntity.isAttackable())
			return;
			
		this.removeSelf();
	}

});

