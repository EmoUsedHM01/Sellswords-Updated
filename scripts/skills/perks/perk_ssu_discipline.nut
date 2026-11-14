this.perk_ssu_discipline <- this.inherit("scripts/skills/skill", {
	m = {
		HitStacks = 0,
	},
	function create()
	{
		this.m.ID = "perk.ssu_discipline";
		this.m.Name = this.Const.Strings.PerkName.SsuDiscipline;
		this.m.Description = this.Const.Strings.PerkDescription.SsuDiscipline;
		this.m.Icon = "ui/perks/ssu_discipline.png";
		this.m.IconMini = "ssu_discipline_mini";
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
					text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.perk_ssu_discipline.Tooltip1, 10)
				},
				{
					id = 10,
					type = "text",
					icon = "ui/icons/ranged_defense.png",
					text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.perk_ssu_discipline.Tooltip2, 5)
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
