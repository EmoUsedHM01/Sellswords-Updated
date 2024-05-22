::mods_hookExactClass("entity/tactical/enemies/orc_berserker", function(o) {
	local create = o.create;
	o.create = function()
	{	
		create();
		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{	
			local dc = this.World.getTime().Days;
			dc = this.Math.max(0, dc - 100);
			local dca = this.Math.floor(dc/50) + this.Math.floor(dc/100) + this.Math.floor(dc/150) + this.Math.floor(dc/200);
			local crr = this.Math.rand(1, 10);
			if (dc >= 50)
			{
				dca += 2;
			}				
			if (crr <= dca + 1)
			{
				this.m.AIAgent = this.new("scripts/ai/tactical/agents/orc_young_agent");				
			}				
			else if (crr <= 10)
			{
				this.m.AIAgent = this.new("scripts/ai/tactical/agents/orc_berserker_agent");			
			}			
		}				
		this.m.AIAgent.setActor(this);
	}		
	
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
		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 80)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));	
			if (this.World.getTime().Days >= 120)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_crRavager"));					
			}
		}			
		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{	
			local dc = this.World.getTime().Days;
			local dca = this.Math.floor(dc/50) + this.Math.floor(dc/100) + this.Math.floor(dc/150) + this.Math.floor(dc/200);
			if (dc >= 50)
			{
				dca += 2;
			}
			local crr = this.Math.rand(1, 10);
			if (crr <= dca)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_nimble"));
				this.m.Skills.removeByID("perk.colossus");					
				if (dc <= 150)
				{
					this.m.BaseProperties.Hitpoints -= 40;
					if (dc <= 100)
					{
						this.m.BaseProperties.Hitpoints -= 40;					
					}						
				}
			}				
			else if (crr <= dca + 2)
			{
				this.m.BaseProperties.Hitpoints += 50;				
			}
			dca = this.Math.min(dca, 5);	
			this.m.BaseProperties.MeleeSkill += 2 * dca;				
			this.m.BaseProperties.Bravery += 2 * dca;				
		}		
	}
	local assignRandomEquipment = o.assignRandomEquipment;
	o.assignRandomEquipment = function()
	{
		assignRandomEquipment();
		local weapon = this.getMainhandItem();
		if (weapon != null && weapon.isWeaponType(this.Const.Items.WeaponType.Sword))
		{
			this.m.Skills.removeByID("perk.ptr_kata");
			this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));		
		}
	}

	o.makeMiniboss <- function()
	{
		if (!this.actor.makeMiniboss())
		{
			return false;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss");
		
		local weapons = [
			"weapons/named/named_orc_cleaver",
			"weapons/named/named_orc_axe",
			"weapons/named/named_orc_axe_2h",
			"weapons/named/named_orc_flail_2h",			
			"weapons/named/cr_named_orc_cleaver_2h",
			"weapons/named/cr_named_orc_sword_2h",
			"weapons/named/cr_named_orc_axe_infantry"
		];

		this.m.Skills.add(this.new("scripts/skills/perks/perk_nimble"));
		this.m.Skills.removeByID("perk.colossus");				
		this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));	
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_assured_conquest"));	
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
		this.m.Skills.add(this.new("scripts/skills/effects/berserker_mushrooms_effect"));			
		return true;
	}	
});	