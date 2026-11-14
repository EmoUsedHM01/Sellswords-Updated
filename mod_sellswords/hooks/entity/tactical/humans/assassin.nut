::Mod_Sellswords.HooksMod.hook("scripts/entity/tactical/humans/assassin", function( q ) {
	
	q.onInit = @( __original ) function()
	{
		__original();
		this.m.Skills.add(this.new("scripts/skills/perks/perk_ssu_trumpcard"));
		local dc = this.World.getTime().Days;
		local mn = this.World.Statistics.getFlags().getAsInt("ArenaRegularFightsWon");
		dc = this.Math.max(dc, 3 * mn);	
		if (dc >= 120)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ssu_battlerhaposdy"));
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

	q.makeMiniboss = @( __original ) function()
	{
		if (!this.actor.makeMiniboss())
			return false;

		this.getSprite("miniboss").setBrush("bust_miniboss");
		
		local weapons = [
			"weapons/named/named_shamshir",
			"weapons/named/named_shamshir",			
			"weapons/named/named_qatal_dagger",
			"weapons/named/named_qatal_dagger",			
			"weapons/named/ssu_named_katar"
		];

		this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));					
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_battleheart"));
		this.m.Skills.removeByID("perk.underdog");

		return true;
	}

});