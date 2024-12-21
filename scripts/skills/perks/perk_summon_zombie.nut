this.perk_summon_zombie <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.summon_zombie";
		this.m.Name = this.Const.Strings.PerkName.SummonZombie;
		this.m.Description = this.Const.Strings.PerkDescription.SummonZombie;
		this.m.Icon = "ui/perks/perk_summon_zombie.png";
		this.m.IconDisabled = "ui/perks/perk_summon_zombie_sw.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUnlocked()
	{
		local stash = this.World.Assets.getStash();
		stash.add(this.new("scripts/items/spawns/legend_zombie_item"));
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.summon_zombie_skill"))
			this.m.Container.add(this.new("scripts/skills/actives/mod_summon_zombie"));
	}

	function onRemoved()
	{
		this.m.Container.removeByID("actives.summon_zombie_skill");
	}

});

