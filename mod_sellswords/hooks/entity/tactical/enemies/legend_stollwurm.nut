::mods_hookExactClass("entity/tactical/enemies/legend_stollwurm", function(o) {
	local onInit = o.onInit;
	o.onInit = function()
	{
		onInit();
		this.m.BaseProperties.IsImmuneToKnockBackAndGrab = true;
		this.m.BaseProperties.IsImmuneToStun = true;
		this.m.BaseProperties.IsMovable = false;
		this.m.BaseProperties.IsImmuneToRoot = true;
		this.m.BaseProperties.IsImmuneToDisarm = true;			
		this.m.BaseProperties.MeleeSkill += 5;			
		this.m.Skills.removeByID("perk.perk.hold_out");	
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crresilient"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));				
		this.m.Skills.add(this.new("scripts/skills/effects/cr_clarity_effect_permanent"));

		if (::Is_PTR_Exist)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_bully"));
			this.m.Skills.addPerkTree(this.Const.Perks.AxeTree);
			this.m.Skills.getSkillByID("perk.ptr_cull").m.IsForceEnabled = true;

			local softMetalPerk = this.new("scripts/skills/perks/perk_ptr_soft_metal");
			softMetalPerk.m.IsForceEnabled = true;
			this.m.Skills.add(softMetalPerk);

			local dentArmorPerk = this.new("scripts/skills/perks/perk_ptr_dent_armor");
			dentArmorPerk.m.IsForceEnabled = true;
			dentArmorPerk.m.IsForceTwoHanded = true;
			this.m.Skills.add(dentArmorPerk);
		}
		
		if (::Is_PTR_Exist && ("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{	
			local maulerPerk = this.new("scripts/skills/perks/perk_ptr_mauler");
			maulerPerk.m.IsForceEnabled = true;
			this.m.Skills.add(maulerPerk);
		}
		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getEconomicDifficulty() == this.Const.Difficulty.Legendary)
		{
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
});