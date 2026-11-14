::Mod_Sellswords.HooksMod.hook("scripts/entity/tactical/enemies/zombie_boss", function ( q ) {

	q.onInit = @(__original) function()
	{
		__original();
		this.m.BaseProperties.IsAffectedByInjuries = true;
		this.m.Skills.removeByID("perk.hold_out");	
		this.m.Skills.add(this.new("scripts/skills/perks/perk_ssu_resilient"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));

		this.m.Skills.add(this.new("scripts/skills/effects/ssu_clarity_effect_permanent"));
		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_fearsome"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_overwhelm"));

			local dc = this.World.getTime().Days;
			local dca = this.Math.floor(dc/50) + this.Math.floor(dc/100) + this.Math.floor(dc/150) + this.Math.floor(dc/200);
			dca = this.Math.min(dca, 8 + this.Math.floor(dc/100));
			this.m.BaseProperties.MeleeSkill += dca;
			this.m.BaseProperties.MeleeDefense += 0.5 * dca;
			this.m.BaseProperties.RangedSkill += dca;
			this.m.BaseProperties.RangedDefense += 0.5 * dca;
			this.m.BaseProperties.Bravery += dca;
			this.m.BaseProperties.Hitpoints += 2 * dca;
		}
	}

	q.assignRandomEquipment = @(__original) function()
	{
		this.m.Items.equip(this.new("scripts/items/weapons/special/ssu_legendary_sword"));
	}

});