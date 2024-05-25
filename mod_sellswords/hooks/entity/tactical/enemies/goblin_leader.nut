::Mod_Sellswords.HooksMod.hook("scripts/entity/tactical/enemies/goblin_leader", function(q)
{
	q.onInit = @( __original ) function()
	{
		__original();
		this.m.Skills.add(this.new("scripts/skills/traits/brave_trait"));			
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_onslaught"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_assured_conquest"));
		local dc = this.World.getTime().Days;	
		local mn = this.World.Statistics.getFlags().getAsInt("ArenaRegularFightsWon");
		dc = this.Math.max(dc, 3 * mn);			
		if (0.66 * dc > this.Math.rand(1, 100) && dc >= 80)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_crTrumpcard"));
		}

		if (::Is_PTR_Exist)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_eyes_up"));	
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
