this.perk_crretrofithooks <- this.inherit("scripts/skills/skill", {
	m = {
		TilesUsed = []
	},
	function create()
	{
		this.m.ID = "perk.crretrofithooks";
		this.m.Name = this.Const.Strings.PerkName.crretrofithooks;
		this.m.Description = this.Const.Strings.PerkDescription.crretrofithooks;
		this.m.Icon = "ui/perks/smackdown_circle.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
		this.m.SoundOnUse = [
			"sounds/combat/hook_01.wav",
			"sounds/combat/hook_02.wav",
			"sounds/combat/hook_03.wav"
		];
		this.m.SoundOnHitHitpoints = [
			"sounds/combat/hook_hit_01.wav",
			"sounds/combat/hook_hit_02.wav",
			"sounds/combat/hook_hit_03.wav"
		];
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.cr_hook_skill"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/cr_hook_skill"));
		}
	}

	function onRemoved()
	{
		this.m.Container.removeByID("actives.cr_hook_skill");
	}

});

