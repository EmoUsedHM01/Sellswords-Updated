this.ssu_desperado_high <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.SsuDesperadoHigh;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.SsuDesperadoHigh.XP;
		this.m.Name = this.generateName();
		this.m.IsGeneratingKillName = false;		
		this.human.create();
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.Military;
		this.m.HairColors = this.Const.HairColors.Old;
		this.m.Beards = this.Const.Beards.Tidy;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/military_melee_agent");
		this.m.AIAgent.setActor(this);
	}
	
	function generateName()
	{
		return this.Const.Strings.crDesperadoNames[this.Math.rand(0, this.Const.Strings.crDesperadoNames.len() - 1)] + " " + this.Const.Strings.crDesperadoTitles[this.Math.rand(0, this.Const.Strings.crDesperadoTitles.len() - 1)];
	}	

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.SsuDesperadoHigh);
		b.IsSpecializedInSwords = true;
		b.IsSpecializedInAxes = true;
		b.IsSpecializedInMaces = true;
		b.IsSpecializedInFlails = true;
		b.IsSpecializedInHammers = true;
		b.IsSpecializedInSpears = true;
		b.IsSpecializedInCleavers = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_military");

		if (this.Math.rand(1, 100) <= 33)
		{
			local r = this.Math.rand(1, 4);

			if (r == 1)
			{
				local sprite = this.getSprite("permanent_injury_4");
				sprite.setBrush("permanent_injury_04");
				sprite.Visible = true;
			}
			else if (r == 2)
			{
				local sprite = this.getSprite("permanent_injury_2");
				sprite.setBrush("permanent_injury_02");
				sprite.Visible = true;
			}
			else if (r == 3)
			{
				local sprite = this.getSprite("permanent_injury_1");
				sprite.setBrush("permanent_injury_01");
				sprite.Visible = true;
			}
			else if (r == 4)
			{
				local sprite = this.getSprite("permanent_injury_scarred");
				sprite.setBrush("permanent_injury_scarred");
				sprite.Visible = true;
			}
		}
						
		this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));					
		this.m.Skills.add(this.new("scripts/skills/perks/perk_hold_out"));	
		this.m.Skills.add(this.new("scripts/skills/perks/perk_reach_advantage"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fearsome"));		
		this.m.Skills.add(this.new("scripts/skills/perks/perk_lone_wolf"));	
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_smackdown"));	
		this.m.Skills.add(this.new("scripts/skills/perks/perk_steel_brow"));

		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{				
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));			
			this.m.Skills.add(this.new("scripts/skills/traits/iron_jaw_trait"));	
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ssu_ironsideweak"));			
			this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ssu_bruiser"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ssu_ravager"));
		}
		
		local dc = this.World.getTime().Days;
		local mn = this.World.Statistics.getFlags().getAsInt("ArenaRegularFightsWon");	
		dc = this.Math.max(dc, mn * 3);	
		
		if (dc >= 25)
		{
			b.MeleeSkill += 5;
			b.Bravery += 10;
			this.m.Skills.add(this.new("scripts/skills/perks/perk_anticipation"));			
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_battleheart"));

			if (dc >= 50)
			{
				
				this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_true_believer"));				
				b.MeleeDefense += 5;
				b.DamageTotalMult += 0.1;			

				if (dc >= 80)
				{
					b.DamageTotalMult += 0.05;					
					this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_muscularity"));				
					this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_second_wind"));			
					this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_assured_conquest"));
					this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_perfect_fit"));						
					b.MeleeSkill += 5;			
					b.MeleeDefense += 5;			
					b.Bravery += 10;
					if (dc >= 150)
					{
						b.DamageTotalMult += 0.05;					
						b.MeleeSkill += 2;	
						b.Initiative += 2;
						
						this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_last_stand"));						
						if (dc >= 200)
						{
							b.DamageTotalMult += 0.05;						
							b.MeleeDefense += 2;	
							b.Initiative += 3;
							b.Bravery += 5;							
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

		if (::Mod_Sellswords.EnableHostileSequences)
		{
			local roll = this.Math.rand(1.0, 100.0);
			if (roll <= 15.0)
				::Mod_Sellswords.add_direwolf(this.actor, true);
		}
	}

	function onDeath(_killer, _skill, _tile, _fatalityType)
	{
		if (::Mod_Sellswords.EnableHostileSequences)
			::Mod_Sellswords.doHostileSequencePotionDrop(_killer, _skill, _tile, _fatalityType, this.actor);
		this.human.onDeath(_killer, _skill, _tile, _fatalityType);
	}

	function assignRandomEquipment()
	{
		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Mainhand))
		{
			local weapons = [
				"weapons/named/legend_named_infantry_axe",
				"weapons/named/named_two_handed_flail",
				"weapons/named/legend_named_military_goedendag",
				"weapons/named/ssu_named_goedendag",				
				"weapons/named/named_two_handed_mace",
				"weapons/named/named_two_handed_hammer"				
			];
			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));

			this.m.Skills.add(this.new("scripts/skills/perks/perk_colossus"));					
			this.m.Skills.add(this.new("scripts/skills/perks/perk_berserk"));			
		}
		
		local armor = ::Legends.Items.pickArmor([
				[1, "ssu_knight_armor"],
				[1, "ssu_hedgeknight_armor"]				
		]);	
		
		armor.setUpgrade(this.new("scripts/items/legend_armor/armor_upgrades/legend_additional_padding_upgrade"));
		
		this.m.Items.equip(armor);		

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head))
		{
			this.m.Items.equip(::Legends.Items.pickHelmet([
				[
					2,
					"ssu_knight_helmet"
				],
				[
					3,
					"ssu_hedgeknight_helmet"
				]				
			]));
		}
	}

});

