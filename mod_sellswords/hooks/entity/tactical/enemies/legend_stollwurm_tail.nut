::mods_hookExactClass("entity/tactical/enemies/legend_stollwurm_tail", function(o) {
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
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crresilient"));	//resilient	
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));	
		this.m.Skills.add(this.new("scripts/skills/effects/cr_clarity_effect_permanent"));

		if (::Is_PTR_Exist)
		{
			this.m.Skills.addPerkTree(this.Const.Perks.HammerTree, 4);
			local faPerk = this.new("scripts/skills/perks/perk_ptr_formidable_approach");
			faPerk.m.IsForceEnabled = true;
			this.m.Skills.add(faPerk);
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