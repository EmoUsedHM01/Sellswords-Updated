this.perk_ssu_retrofithooks <- this.inherit("scripts/skills/skill", {
	m = {
		TilesUsed = []
	},
	function create()
	{
		this.m.ID = "perk.ssu_retrofithooks";
		this.m.Name = this.Const.Strings.PerkName.SsuRetrofithooks;
		this.m.Description = this.Const.Strings.PerkDescription.SsuRetrofithooks;
		this.m.Icon = "ui/perks/legend_smackdown.png";
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
		if (!this.m.Container.hasSkill("actives.ssu_hook_skill"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/ssu_hook_skill"));
		}
	}

	function onRemoved()
	{
		this.m.Container.removeByID("actives.ssu_hook_skill");
	}

});

