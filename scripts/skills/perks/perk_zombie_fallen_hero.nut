this.perk_zombie_fallen_hero <- this.inherit("scripts/skills/skill", {
	m = {
		IsRightActor = false
	},
	function create()
	{
		this.m.ID = "perk.zombie_fallen_hero";
		this.m.Name = this.Const.Strings.PerkName.ZombieFallenHero;
		this.m.Description = this.Const.Strings.PerkDescription.ZombieFallenHero;
		this.m.Icon = "ui/perks/perk_zombie_fallen_hero.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor().get();

		if (this.isKindOf(actor, "undead_player"))
		{
			this.m.IsRightActor = true;
			actor.m.IsResurrectingOnFatality = true;
		}

		if (!this.m.Container.hasSkill("racial.fallen_hero"))
			this.m.Container.add(this.new("scripts/skills/racial/fallen_hero_racial"));
	}

	function onRemoved()
	{
		if (this.m.IsRightActor)
			this.getContainer().getActor().m.IsResurrectingOnFatality = false;

		this.m.Container.removeByID("racial.fallen_hero");
	}

});