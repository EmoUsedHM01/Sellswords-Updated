this.perk_ssu_necro_summon_zombie <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.ssu_necro_summon_zombie";
		this.m.Name = this.Const.Strings.PerkName.SsuNecroSummonZombie;
		this.m.Description = this.Const.Strings.PerkDescription.SsuNecroSummonZombie;
		this.m.Icon = "ui/perks/ssu_necro_summon_zombie.png";
		this.m.IconDisabled = "ui/perks/ssu_necro_summon_zombie_bw.png";
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
		if (!this.m.Container.hasSkill("actives.ssu_necro_summon_zombie_skill"))
			this.m.Container.add(this.new("scripts/skills/actives/ssu_necro_summon_zombie"));
	}

	function onRemoved()
	{
		this.m.Container.removeByID("actives.ssu_necro_summon_zombie_skill");
	}

});

