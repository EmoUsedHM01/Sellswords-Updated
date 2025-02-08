this.perk_crDiscipline <- this.inherit("scripts/skills/skill", {
	m = {
		HitStacks = 0,
	},
	function create()
	{
		this.m.ID = "perk.crDiscipline";
		this.m.Name = this.Const.Strings.PerkName.crDiscipline;
		this.m.Description = this.Const.Strings.PerkDescription.crDiscipline;
		this.m.Icon = "ui/perks/crDiscipline.png";
		this.m.IconMini = "crDiscipline_mini";
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function isHidden()
	{
		return this.m.HitStacks	== 0;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();
		tooltip.extend(
			[
				{
					id = 10,
					type = "text",
					icon = "ui/icons/melee_defense.png",
					text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + 10 + "[/color] Melee Defense"
				},
				{
					id = 10,
					type = "text",
					icon = "ui/icons/ranged_defense.png",
					text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + 5 + "[/color] Ranged Defense"
				}
			]
		);

		return tooltip;
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		if (_skill == null || !_skill.isAttack() || _attacker == null || _attacker.getID() == this.getContainer().getActor().getID())
		{
			return;
		}
		if (this.m.HitStacks == 0)
		{
			this.m.HitStacks = 1;
		}	
	}

	function onMissed( _attacker, _skill )
	{
		if (_skill == null || !_skill.isAttack() || _attacker == null || _attacker.getID() == this.getContainer().getActor().getID())
		{
			return;
		}
		this.m.HitStacks = 0;
	}

	function onUpdate( _properties )
	{
		if (this.m.HitStacks == 1)
		{
			_properties.MeleeDefense += 10;
			_properties.RangedDefense += 5;
		}	
	}

	function onTurnStart()
	{
		this.m.HitStacks = 0;
	}

	function onCombatFinished()
	{
		this.m.HitStacks = 0;
	}
});
