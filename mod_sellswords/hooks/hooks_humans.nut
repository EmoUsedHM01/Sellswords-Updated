foreach(script in [
	"barbarian_beastmaster",
	"barbarian_drummer",
	"barbarian_marauder",
	"barbarian_thrall",
	"bounty_hunter",
	"caravan_guard",
	"caravan_hand",
	"cultist",
	"engineer",
	"mercenary",
	"militia",
	"militia_captain",
	"militia_ranged",
	"nomad_archer",
	"nomad_slinger",
	"vizier",
	"wildman",
])
{
	::mods_hookExactClass("entity/tactical/humans/" + script, function(o) {
		local onInit = o.onInit;
		o.onInit = function()
		{
			onInit();
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
}

foreach(script in [
	"conscript",
	"conscript_polearm",
])
{
	::mods_hookExactClass("entity/tactical/humans/" + script, function(o) {
		local onInit = o.onInit;
		o.onInit = function()
		{
			onInit();				
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
		local assignRandomEquipment = o.assignRandomEquipment;
		o.assignRandomEquipment = function()
		{
			assignRandomEquipment();
			if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
			{
				if (::Is_PTR_Exist)
				{
					this.m.Skills.removeByID("perk.ptr_fresh_and_furious");	
					this.m.Skills.add(this.new("scripts/skills/effects/ptr_fresh_and_furious_effect"));	
				}
				
				if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 100)
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_crAnchor"));				
				}
			}
		}		
	});	
}

