::Mod_Sellswords.HooksMod.hook("scripts/entity/tactical/humans/free_company_slayer", function(q)
{
	q.onInit = @( __original ) function()
	{
		__original();
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_back_to_basics"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_sundering_strikes"));	

		if (::Is_PTR_Exist)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_strength_in_numbers"));	
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_pattern_recognition"));
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
	q.assignRandomEquipment = @( __original ) function()
	{
		__original();

		//if (::Is_PTR_Exist)
		//{
		//	this.m.Skills.addTreeOfEquippedWeapon(5);
		//}

		::Mod_Sellswords.HookHelper.addTreeOfEquippedWeapon(this, 5);
	}		
});
