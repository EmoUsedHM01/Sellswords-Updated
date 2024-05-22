foreach(script in [
	"alp",
	"alp_shadow",
	"bandit_raider_wolf",
	"direwolf",
	"hexe",
	"hyena",
	"legend_banshee",
	"legend_demon_alp",
	"legend_greenwood_schrat",
	"legend_greenwood_schrat_small",
	"legend_hexe_leader",
	"legend_skin_ghoul",
	"legend_skin_ghoul_high",
	"legend_skin_ghoul_med",
	"legend_redback_spider",
	"necromancer",
	"schrat",
	"schrat_small",
	"serpent",
	"spider",
	"unhold",
	"unhold_bog",
	"unhold_frost",
])
{
	::mods_hookExactClass("entity/tactical/enemies/" + script, function(o) {
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
	"legend_mummy_light",
	"legend_mummy_medium",
	"legend_mummy_priest",
	"skeleton_light",
	"skeleton_medium",
	"skeleton_medium_polearm",
	"skeleton_priest",
	"zombie",
	"zombie_player",
	"zombie_treasure_hunter",
	"zombie_yeoman",
])
{
	::mods_hookExactClass("entity/tactical/enemies/" + script, function(o) {
		local onInit = o.onInit;
		o.onInit = function()
		{
			onInit();
			this.m.BaseProperties.IsAffectedByInjuries = true;	
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
	"direwolf_high",
	"hyena_high",
])
{
	::mods_hookExactClass("entity/tactical/enemies/" + script, function(o) {
		local onInit = o.onInit;
		o.onInit = function()
		{
			onInit();			
			this.m.Skills.add(this.new("scripts/skills/perks/perk_crBattlerhaposdy"));		
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
	"legend_rock_unhold",
	"lindwurm",
	"lindwurm_tail",
])
{
	::mods_hookExactClass("entity/tactical/enemies/" + script, function(o) {
		local onInit = o.onInit;
		o.onInit = function()
		{
			onInit();
			this.m.Skills.removeByID("perk.perk.hold_out");	
			this.m.Skills.add(this.new("scripts/skills/perks/perk_crresilient"));				
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
	"legend_skeleton_gladiator",
	"legend_white_direwolf",
])
{
	::mods_hookExactClass("entity/tactical/enemies/" + script, function(o) {
		local onInit = o.onInit;
		o.onInit = function()
		{
			onInit();
			this.m.Skills.add(this.new("scripts/skills/perks/perk_crTrumpcard"));
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
	"unhold_armored",
	"unhold_frost_armored",
])
{
	::mods_hookExactClass("entity/tactical/enemies/" + script, function(o) {
		o.onTurnStart = function()
		{
			this.actor.onTurnStart();

			if (this.Time.getRound() >= 5 && !this.m.HasTurned && !this.m.HasBeenWhipped && !this.Tactical.State.isAutoRetreat())
			{
				this.m.Skills.getSkillByID("racial.unhold").spawnIcon("status_effect_107", this.getTile());

				if (this.Math.rand(1, 100) <= 50)
				{
					this.playSound(this.Const.Sound.ActorEvent.Other1, 0.75, this.Math.rand(90, 100) * 0.01);
				}

				if (this.Math.rand(1, 100) <= 33)
				{
					this.updateAchievement("FriendOrFoe", 1, 1);
					this.m.HasTurned = true;
					this.setFaction(this.Tactical.State.isScenarioMode() ? this.Const.Faction.Beasts : this.World.FactionManager.getFactionOfType(this.Const.FactionType.Beasts).getID());
					this.getSprite("socket").setBrush("bust_base_beasts");
				}
			}

			this.m.HasBeenWhipped = false;
		}
	}); 
}

