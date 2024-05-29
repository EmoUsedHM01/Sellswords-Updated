::Mod_Sellswords.HooksMod.hook("scripts/entity/tactical/enemies/legend_orc_behemoth", function( q ) {

	q.onInit = @( __original ) function()
	{
		__original();
		this.m.Skills.add(this.new("scripts/skills/perks/perk_adrenalin"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_full_force"));
		local dc = this.World.getTime().Days;
		local mn = this.World.Statistics.getFlags().getAsInt("ArenaRegularFightsWon");
		dc = this.Math.max(dc, 3 * mn);
		if (dc >= 80)
		{
			this.m.BaseProperties.Armor[this.Const.BodyPart.Head] += 10;
			this.m.BaseProperties.ArmorMax[this.Const.BodyPart.Head] += 10;
			this.m.BaseProperties.Armor[this.Const.BodyPart.Body] += 10;
			this.m.BaseProperties.ArmorMax[this.Const.BodyPart.Body] += 10;
			this.m.Skills.add(this.new("scripts/skills/perks/perk_crBruiser"));
			this.m.BaseProperties.MeleeSkill += 3;
			if (dc >= 120)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_crIronsideweak"));
				this.m.BaseProperties.MeleeSkill += 2;
				if (dc >= 160)
				{
					this.m.BaseProperties.Armor[this.Const.BodyPart.Head] += 20;
					this.m.BaseProperties.ArmorMax[this.Const.BodyPart.Head] += 20;
					this.m.BaseProperties.Armor[this.Const.BodyPart.Body] += 20;
					this.m.BaseProperties.ArmorMax[this.Const.BodyPart.Body] += 20;
					if (dc >= 200)
					{
						this.m.Skills.add(this.new("scripts/skills/perks/perk_colossus"));

						if (::Is_PTR_Exist)
							this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_wears_it_well"));

						if (dc >= 250)
						{
							this.m.BaseProperties.Armor[this.Const.BodyPart.Head] += 20;
							this.m.BaseProperties.ArmorMax[this.Const.BodyPart.Head] += 20;
							this.m.BaseProperties.Armor[this.Const.BodyPart.Body] += 20;
							this.m.BaseProperties.ArmorMax[this.Const.BodyPart.Body] += 20;
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

	q.assignRandomEquipment = @( __original ) function()
	{
		local r;
		r = this.Math.rand(1, 4);

		if (r == 1)
			this.m.Items.equip(this.new("scripts/items/weapons/greenskins/orc_axe_2h"));
		else if (r == 2)
			this.m.Items.equip(this.new("scripts/items/weapons/greenskins/legend_bough"));
		else if (r == 3)
			this.m.Items.equip(this.new("scripts/items/weapons/greenskins/orc_flail_2h"));
		else if (r == 4)
			this.m.Items.equip(this.new("scripts/items/weapons/greenskins/legend_skullbreaker"));

		::Mod_Sellswords.HookHelper.addTreeOfEquippedWeapon(this, 5);
		this.m.Skills.removeByID("perk.ptr_kata");
		local helmet;
		helmet = [
			[1, "greenskins/legend_orc_behemoth_helmet"]
		];
		if (this.World.getTime().Days >= 120)
		{
			helmet = [
					[3, "greenskins/legend_orc_behemoth_helmet"],
					[1, "greenskins/orcbehemoth_helmet_heavy"]
			];
		}
		if (this.World.getTime().Days >= 160)
		{
			helmet = [
					[1, "greenskins/legend_orc_behemoth_helmet"],
					[1, "greenskins/orcbehemoth_helmet_heavy"]
			];
		}			
		if (this.World.getTime().Days >= 200)
		{
			helmet = [
					[1, "greenskins/orcbehemoth_helmet_heavy"]
			];
		}
		this.m.Items.equip(this.Const.World.Common.pickHelmet(helmet));
		local armor;
		armor = [
			[
				1,
				"greenskins/legend_orc_behemoth_armor"
			]
		];
		this.m.Items.equip(this.Const.World.Common.pickArmor(armor));
	}

	q.makeMiniboss = @( __original ) function()
	{
		if (!this.actor.makeMiniboss())
		{
			return false;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss_greenskins");
		local weapons = [
			"weapons/named/named_orc_axe_2h",
			"weapons/named/named_orc_flail_2h",
			"weapons/named/cr_named_orc_hammer_2h",
			"weapons/named/cr_named_orc_mace_2h"
		];
		this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_true_believer"));
		//this.m.Skills.addTreeOfEquippedWeapon();
		::Mod_Sellswords.HookHelper.addTreeOfEquippedWeapon(this, 5);
		return true;
	}

});