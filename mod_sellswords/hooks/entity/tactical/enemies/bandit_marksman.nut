::Mod_Sellswords.HooksMod.hook("scripts/entity/tactical/enemies/bandit_marksman", function(q)
{
	q.onInit = @( __original ) function()
	{
		__original();		
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

		if (!::Is_PTR_Exist) return;

		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Skills.removeByID("perk.ptr_eyes_up");
			local dc = this.World.getTime().Days;			
			if (0.25 * dc > this.Math.rand(1, 100) && dc >= 100)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_eyes_up"));	
			}				
		}
	}		
});
