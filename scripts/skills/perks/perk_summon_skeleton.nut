this.perk_summon_skeleton <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.summon_skeleton";
		this.m.Name = this.Const.Strings.PerkName.SummonSkeleton;
		this.m.Description = this.Const.Strings.PerkDescription.SummonSkeleton;
		this.m.Icon = "ui/perks/perk_summon_skeleton.png";
		this.m.IconDisabled = "ui/perks/perk_summon_skeleton_sw.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUnlocked()
	{
		local stash = this.World.Assets.getStash();
		stash.add(this.new("scripts/items/spawns/skeleton_item"));
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.summon_skeleton_skill"))
			this.m.Container.add(this.new("scripts/skills/actives/mod_summon_skeleton"));
	}

	function onRemoved()
	{
		this.m.Container.removeByID("actives.summon_skeleton_skill");
	}

});

