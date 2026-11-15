::Mod_Sellswords.HooksMod.hook("scripts/entity/tactical/humans/desert_devil", function( q ) {

	q.onInit = @( __original ) function()
	{
		__original();
		this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));

		local dc = this.World.getTime().Days;			
		local blk = this.Math.rand(1, 100);

		if (dc > 180 && blk >= 80)
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ssu_blockmaster"));
		else if(dc > 140 && blk >= 60)
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ssu_blockskilled"));
		else if(dc > 100 && blk >= 40)
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ssu_blocknormal"));

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

		if (::Mod_Sellswords.EnableHostileSequences)
		{
			local roll = this.Math.rand(1.0, 100.0);
			if (roll <= 30.0)
				::Mod_Sellswords.add_serpent(this.actor, true);
		}	
	}

	q.onDeath = @(__original) function(_killer, _skill, _tile, _fatalityType)
	{
		__original(_killer, _skill, _tile, _fatalityType);
		if (::Mod_Sellswords.EnableHostileSequences)
			::Mod_Sellswords.doHostileSequencePotionDrop(_killer, _skill, _tile, _fatalityType, this.actor);
	}

	q.assignRandomEquipment = @( __original ) function()
	{
		__original();
		
		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Mainhand))
		{
			local weapons = [
				"weapons/shamshir"					
			];

			if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Offhand))
			{
				weapons.extend([
					"weapons/ssu_swordlance",
					"weapons/ssu_swordlance"						
				]);
			}

			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}

		this.m.Items.equip(::Legends.Items.pickArmor([
			[
				1,
				"oriental/assassin_robe"
			],
			[
				1,
				"blade_dancer_armor_00"
			]
		]));

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head))
		{
			local helm = ::Legends.Items.pickHelmet([
				[
					1,
					"oriental/blade_dancer_head_wrap"
				],
				[
					1,
					"blade_dancer_helmet_00"
				]
			]);
			this.m.Items.equip(helm);
		}
	}

	q.makeMiniboss = @( __original ) function()
	{
		if (!this.actor.makeMiniboss())
			return false;

		local ret = __original();
		if (ret)
		{
			if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
			{
				this.m.Skills.removeByID("perk.underdog");					
				this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_battleheart"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_assured_conquest"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_perfect_fit"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_second_wind"));
			}
		}

		return ret;
	}

});