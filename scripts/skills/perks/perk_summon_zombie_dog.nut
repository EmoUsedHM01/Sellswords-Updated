this.perk_summon_zombie_dog <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.summon_zombie_dog";
		this.m.Name = this.Const.Strings.PerkName.SummonZombieDog;
		this.m.Description = this.Const.Strings.PerkDescription.SummonZombieDog;
		this.m.Icon = "ui/perks/perk_summon_zombie_dog.png";
		this.m.IconDisabled = "ui/perks/perk_summon_zombie_dog_sw.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUnlocked()
	{
		local stash = this.World.Assets.getStash();
		stash.add(this.new("scripts/items/spawns/zombie_dog"));
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.summon_zombie_dog_skill"))
			this.m.Container.add(this.new("scripts/skills/actives/mod_summon_zombie_dog"));
	}

	function onRemoved()
	{
		this.m.Container.removeByID("actives.summon_zombie_dog_skill");
	}

});

