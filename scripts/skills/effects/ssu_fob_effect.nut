this.ssu_fob_effect <- this.inherit("scripts/skills/skill", {
	m = {
		Damage = 5,
		Count = 1
	},
	function create()
	{
		this.m.ID = "effects.ssu_fob";
		this.m.Name = ::Mod_Sellswords.Strings.ssu_fob_effect.Name;
		this.m.Icon = "skills/status_effect_01.png";
		this.m.IconMini = "status_effect_01_mini";
		this.m.Overlay = "status_effect_01";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDamage()
	{
		return this.m.Damage;
	}

	function getName()
	{
		if (this.m.Count <= 1)
			return this.m.Name;
		else
			return this.m.Name + " (x" + this.m.Count + ")";
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
				text = ::Mod_Sellswords.Strings.ssu_fob_effect.Tooltip1
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.ssu_fob_effect.Tooltip2, this.m.Count * 7)
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.ssu_fob_effect.Tooltip3, this.m.Count * 7)
			}
		];
	}

	function onRefresh()
	{
		local actor = this.getContainer().getActor();
		local crrd = this.getContainer().hasSkill("perk.ssu_rangeddefense") ? this.Math.rand(1, 100) <= actor.getBaseProperties().RangedDefense : false;

		if ((this.getContainer().getActor().getCurrentProperties().IsResistantToAnyStatuses && this.Math.rand(1, 100) <= 50) || crrd)
		{
			if (!this.getContainer().getActor().isHiddenToPlayer())
				this.Tactical.EventLog.log(::Mod_Sellswords.text(::Mod_Sellswords.Strings.ssu_fob_effect.Log, this.Const.UI.getColorizedEntityName(this.getContainer().getActor())));

			return;
		}

		this.m.Count = this.Math.min(5, this.m.Count + 1);
		this.spawnIcon("status_effect_01", this.getContainer().getActor().getTile());
	}

	function onUpdate( _properties )
	{
		_properties.ThresholdToReceiveInjuryMult *= this.Math.maxf(0.05, 1 - 0.07 * this.m.Count);
		_properties.BraveryMult *= this.Math.maxf(0.05, 1 - 0.07 * this.m.Count);
	}

});