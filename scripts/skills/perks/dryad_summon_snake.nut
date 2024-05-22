this.dryad_summon_snake <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.dryad_summon_snake";
		this.m.Name = this.Const.Strings.PerkName.DryadSummonSnake;
		this.m.Description = this.Const.Strings.PerkDescription.DryadSummonSnake;
		this.m.Icon = "ui/perks/perk_dryad_summon_snake.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.summon_dryad_snake"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/summon_dryad_snake"));
		}
	}

	function onRemoved()
	{
		this.m.Container.removeByID("actives.summon_dryad_snake");
	}

});

