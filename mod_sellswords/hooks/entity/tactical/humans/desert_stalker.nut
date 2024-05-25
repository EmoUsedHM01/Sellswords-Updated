::Mod_Sellswords.HooksMod.hook("scripts/entity/tactical/humans/desert_stalker", function(q)
{
	q.onInit = @( __original ) function()
	{
		__original();	
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));			
		//this.m.Skills.add(this.new("scripts/skills/perks/perk_head_hunter"));
		if (::Is_PTR_Exist)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_eyes_up"));
		}

		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 80 && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_perfect_fit"));		
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
