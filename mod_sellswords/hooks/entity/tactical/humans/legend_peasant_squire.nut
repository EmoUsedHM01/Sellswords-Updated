::mods_hookExactClass("entity/tactical/humans/legend_peasant_squire", function(o) {
	local onInit = o.onInit;
	o.onInit = function()
	{
		onInit();				
		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 40)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_muscularity"));

			if (this.World.getTime().Days >= 70)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_nimble"));	
				this.m.BaseProperties.Hitpoints -= 10;						

				if (this.World.getTime().Days >= 100)
				{
					this.m.BaseProperties.Hitpoints += 10;					
					this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_freedom_of_movement"));										
					if (this.World.getTime().Days >= 130)
					{
						this.m.Skills.add(this.new("scripts/skills/perks/perk_vengeance"));					
						this.m.BaseProperties.MeleeSkill += 2;	
						this.m.BaseProperties.Initiative += 2;						
						if (this.World.getTime().Days >= 160)
						{
							this.m.BaseProperties.MeleeDefense += 2;	
							this.m.BaseProperties.Bravery += 5;							
						}						
					}		
				}
			}
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