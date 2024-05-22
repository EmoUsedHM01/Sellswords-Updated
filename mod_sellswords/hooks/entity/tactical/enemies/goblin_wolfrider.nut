::Mod_Sellswords.HooksMod.hook("entity/tactical/enemies/goblin_wolfrider", function(q)
{
	q.onInit = @( __original ) function()
	{
		__original();
		this.m.Skills.add(this.new("scripts/skills/traits/brave_trait"));			
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_onslaught"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_assured_conquest"));

		if (::Is_PTR_Exist)
		{
			this.m.Skills.add(this.new("scripts/skills/effects/ptr_fresh_and_furious_effect"));	
		}

		local dc = this.World.getTime().Days;	
		local mn = this.World.Statistics.getFlags().getAsInt("ArenaRegularFightsWon");
		dc = this.Math.max(dc, 3 * mn);			
		if (0.3 * dc > this.Math.rand(1, 100) && dc >= 120)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_crTrumpcard"));
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

	q.makeMiniboss <- function()
	{
		if (!this.actor.makeMiniboss())
		{
			return false;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss");
		
		local weapons = [
			"weapons/named/named_goblin_falchion",
			"weapons/named/named_goblin_spear"				
		];

		this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));	
		this.m.Skills.add(this.new("scripts/skills/perks/perk_nimble"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_dodge"));			
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
		//this.m.Skills.addTreeOfEquippedWeapon();
		::Mod_Sellswords.HookHelper.addTreeOfEquippedWeapon(this);
		return true;
	}
});
