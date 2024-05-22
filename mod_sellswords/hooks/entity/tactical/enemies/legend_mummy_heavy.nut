::mods_hookExactClass("entity/tactical/enemies/legend_mummy_heavy", function(o) {
	local onInit = o.onInit;
	o.onInit = function()
	{
		onInit();
		this.m.BaseProperties.IsAffectedByInjuries = true;				
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_full_force"));	
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crRavager"));	
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
	o.makeMiniboss = function ()
	{
		if (!this.actor.makeMiniboss())
		{
			return false;
		}

		local weapons = [
			[
				1,
				"named_billhook"
			],
			[
				1,
				"named_crypt_cleaver"
			],
			[
				1,
				"named_khopesh"
			],
			[
				1,
				"named_legend_great_khopesh"
			],
			[
				1,
				"named_fan_axe"
			]				
		];
		local weaponAdd = this.Const.World.Common.pickItem(weapons, "scripts/items/weapons/named/");
		this.m.Items.equip(weaponAdd);
	}		
}); 