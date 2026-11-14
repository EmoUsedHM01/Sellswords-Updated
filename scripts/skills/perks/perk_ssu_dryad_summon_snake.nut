this.perk_ssu_dryad_summon_snake <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.ssu_dryad_summon_snake";
		this.m.Name = this.Const.Strings.PerkName.SsuDryadSummonSnake;
		this.m.Description = this.Const.Strings.PerkDescription.SsuDryadSummonSnake;
		this.m.Icon = "ui/perks/ssu_dryad_summon_snake.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.ssu_dryad_summon_snake"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/ssu_dryad_summon_snake"));
		}
	}

	function onRemoved()
	{
		this.m.Container.removeByID("actives.ssu_dryad_summon_snake");
	}

});

