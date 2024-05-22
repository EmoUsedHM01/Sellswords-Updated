::mods_hookExactClass("entity/tactical/enemies/orc_warlord", function(o) {
	local onInit = o.onInit;
	o.onInit = function()
	{
		onInit();			
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_full_force"));						
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crHonorheritage"));

		if (::Is_PTR_Exist)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_bulwark"));
		}

		this.m.BaseProperties.Initiative += 15;	
		local dc = this.World.getTime().Days;	
		local mn = this.World.Statistics.getFlags().getAsInt("ArenaRegularFightsWon");
		dc = this.Math.max(dc, 3 * mn);				
		if (dc >= 80)
		{
			this.m.BaseProperties.Armor[this.Const.BodyPart.Head] += 35;
			this.m.BaseProperties.ArmorMax[this.Const.BodyPart.Head] += 35;	
			this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));	
			if (dc >= 120)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));	
				this.m.Skills.add(this.new("scripts/skills/perks/perk_crIronsideweak"));					
				if (dc >= 160)
				{
					this.m.BaseProperties.Armor[this.Const.BodyPart.Head] += 20;
					this.m.BaseProperties.ArmorMax[this.Const.BodyPart.Head] += 20;	
					this.m.BaseProperties.Armor[this.Const.BodyPart.Body] += 20;
					this.m.BaseProperties.ArmorMax[this.Const.BodyPart.Body] += 20;	
																	
					this.m.Skills.add(this.new("scripts/skills/perks/perk_crRavager"));						
					this.m.Skills.add(this.new("scripts/skills/perks/perk_colossus"));

					if (::Is_PTR_Exist)
					{
						this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_man_of_steel"));
					}

					if (dc >= 200)
					{
						this.m.BaseProperties.Armor[this.Const.BodyPart.Head] += 30;
						this.m.BaseProperties.ArmorMax[this.Const.BodyPart.Head] += 30;	
						this.m.BaseProperties.Armor[this.Const.BodyPart.Body] += 30;
						this.m.BaseProperties.ArmorMax[this.Const.BodyPart.Body] += 30;							
						this.m.Skills.add(this.new("scripts/skills/perks/perk_last_stand"));													
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
	local assignRandomEquipment = o.assignRandomEquipment;
	o.assignRandomEquipment = function()
	{
		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand) == null)
		{
			local weapons = [
				"weapons/greenskins/orc_axe",
				"weapons/greenskins/orc_cleaver",
				"weapons/greenskins/orc_axe_2h",
				"weapons/greenskins/orc_axe_2h",					
				"weapons/greenskins/legend_limb_lopper",
				"weapons/greenskins/legend_man_mangler"						
			];
			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}
		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Body) == null)
		{
			local item = this.Const.World.Common.pickArmor([
				[
					1,
					"greenskins/orc_warlord_armor"
				]
			]);
			this.m.Items.equip(item);
		}
		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Head) == null)
		{
			local item = this.Const.World.Common.pickHelmet([
				[
					1,
					"greenskins/orc_warlord_helmet"
				]
			]);
			if (item != null)
			{
				this.m.Items.equip(item);
			}
		}

		//if (::Is_PTR_Exist)
		//{
		//	this.m.Skills.addTreeOfEquippedWeapon();
		//}
		::Mod_Sellswords.HookHelper.addTreeOfEquippedWeapon(this);
		this.m.Skills.removeByID("perk.ptr_kata");			
	}
	
	o.makeMiniboss = function ()
	{
		if (!this.actor.makeMiniboss())
		{
			return false;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss_greenskins");
		local weapons = [
			"weapons/named/named_orc_cleaver",			
			"weapons/named/named_orc_axe",
			"weapons/named/named_orc_axe_2h",
			"weapons/named/named_orc_axe_2h",					
			"weapons/named/cr_named_orc_cleaver_2h",
			"weapons/named/cr_named_orc_sword_2h",				
		];
		this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
		return true;
	}
});