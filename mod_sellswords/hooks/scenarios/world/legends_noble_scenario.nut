::mods_hookExactClass("scenarios/world/legends_noble_scenario", function ( o )
{
	o.onSpawnAssets = function()
	{
		local roster = this.World.getPlayerRoster();

		for( local i = 0; i < 6; ++i )
		{
			local bro = roster.create("scripts/entity/tactical/player");

			if (i != 0)
			{
				bro.fillTalentValues(3);
			}
		}

		local bros = roster.getAll();
		bros[0].setStartValuesEx([
			"legend_noble_commander_background"
		], false);
		bros[0].getSkills().add(this.new("scripts/skills/traits/player_character_trait"));
		bros[0].getFlags().set("IsPlayerCharacter", true);
		bros[0].setPlaceInFormation(13);
		bros[0].setVeteranPerks(2);
		bros[0].m.Talents = [];		
		local talents = bros[0].getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.MeleeSkill] = 2;
		talents[this.Const.Attributes.MeleeDefense] = 1;
		talents[this.Const.Attributes.Fatigue] = 1;	
		talents[this.Const.Attributes.Bravery] = 2;				
		this.addScenarioPerk(bros[0].getBackground(), this.Const.Perks.PerkDefs.Rotation);
		this.addScenarioPerk(bros[0].getBackground(), this.Const.Perks.PerkDefs.RallyTheTroops);
		bros[0].getSkills().add(this.new("scripts/skills/traits/drunkard_trait"));
		bros[0].getSkills().add(this.new("scripts/skills/traits/legend_noble_killer_trait"));
		bros[0].getSkills().add(this.new("scripts/skills/effects_world/drunk_effect"));
		bros[1].setStartValuesEx([
			"legend_noble_shield"
		], false);
		local items = bros[1].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Offhand));
		local r = this.Math.rand(1, 2);
		local shield;

		if (r == 1)
		{
			shield = this.new("scripts/items/shields/faction_kite_shield");
		}
		else if (r == 2)
		{
			shield = this.new("scripts/items/shields/faction_heater_shield");
		}

		items.equip(shield);
		bros[1].getBackground().m.RawDescription = "Though a lowly foot soldier %name% has one of the most upbeat outlooks on life you\'ve ever encountered. Unfortunately that extends to an over evaluation of self worth, expecting more pay than most.";
		bros[1].getBackground().buildDescription(true);
		bros[1].m.Talents = [];
		local talents = bros[1].getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.MeleeSkill] = 2;
		talents[this.Const.Attributes.Hitpoints] = 1;
		talents[this.Const.Attributes.Fatigue] = 2;		
		bros[1].getSkills().add(this.new("scripts/skills/traits/optimist_trait"));
		bros[1].getSkills().add(this.new("scripts/skills/traits/determined_trait"));
		bros[1].getSkills().add(this.new("scripts/skills/traits/greedy_trait"));
		this.addScenarioPerk(bros[1].getBackground(), this.Const.Perks.PerkDefs.Rotation);
		bros[1].setPlaceInFormation(3);
		//bros[1].setVeteranPerks(2);
		bros[2].setStartValuesEx([
			"legend_noble_2h"
		], false);
		bros[2].getBackground().m.RawDescription = "%name% is a hulking figure, both upward and outward. Not much of a talker, but a big eater.";
		bros[2].getBackground().buildDescription(true);
		bros[2].m.Talents = [];
		local talents = bros[2].getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.MeleeSkill] = 2;
		talents[this.Const.Attributes.MeleeDefense] = 1;
		talents[this.Const.Attributes.Hitpoints] = 2;		
		bros[2].getSkills().removeByID("trait.tiny");
		bros[2].getSkills().add(this.new("scripts/skills/traits/huge_trait"));
		bros[2].getSkills().add(this.new("scripts/skills/traits/fat_trait"));
		bros[2].getSkills().add(this.new("scripts/skills/traits/gluttonous_trait"));
		this.addScenarioPerk(bros[2].getBackground(), this.Const.Perks.PerkDefs.Rotation);
		bros[2].setPlaceInFormation(4);
		//bros[2].setVeteranPerks(2);
		bros[3].setStartValuesEx([
			"legend_noble_shield"
		], false);
		local items = bros[3].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Offhand));
		r = this.Math.rand(1, 2);
		local shield;

		if (r == 1)
		{
			shield = this.new("scripts/items/shields/faction_kite_shield");
		}
		else if (r == 2)
		{
			shield = this.new("scripts/items/shields/faction_heater_shield");
		}

		items.equip(shield);
		bros[3].getBackground().m.RawDescription = "%name%\'s parents both served your family, it runs in the blood. While %name% is dependable in a fight and would never dream of leaving you, it also reduces their %name%\'s ambition and drive";
		bros[3].getBackground().buildDescription(true);
		bros[3].m.Talents = [];
		local talents = bros[3].getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.Fatigue] = 2;
		talents[this.Const.Attributes.MeleeDefense] = 2;
		talents[this.Const.Attributes.Hitpoints] = 1;		
		bros[3].getSkills().add(this.new("scripts/skills/traits/pragmatic_trait"));
		bros[3].getSkills().add(this.new("scripts/skills/traits/loyal_trait"));
		bros[3].getSkills().add(this.new("scripts/skills/traits/slack_trait"));
		this.addScenarioPerk(bros[3].getBackground(), this.Const.Perks.PerkDefs.Rotation);
		bros[3].setPlaceInFormation(5);
		//bros[3].setVeteranPerks(2);
		bros[4].setStartValuesEx([
			"servant_background"
		], false);
		bros[4].getBackground().m.RawDescription = "%name% has been a servant in your family for 5 generations now, it is unclear how anyone has survived this long, but there are no indications of the old coot giving up any time soon.";
		bros[4].getBackground().buildDescription(true);
		bros[4].m.Talents = [];
		local talents = bros[4].getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.Fatigue] = 2;
		talents[this.Const.Attributes.MeleeDefense] = 1;
		talents[this.Const.Attributes.Bravery] = 1;			
		bros[4].getSkills().add(this.new("scripts/skills/traits/old_trait"));
		bros[4].getSkills().add(this.new("scripts/skills/traits/loyal_trait"));
		bros[4].getSkills().add(this.new("scripts/skills/traits/lucky_trait"));
		bros[4].getSkills().add(this.new("scripts/skills/traits/survivor_trait"));
		this.addScenarioPerk(bros[4].getBackground(), this.Const.Perks.PerkDefs.Rotation);
		bros[4].setPlaceInFormation(12);
		//bros[4].setVeteranPerks(2);
		local items = bros[4].getItems();
		items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"linen_tunic"
			]
		]));
		items.equip(this.Const.World.Common.pickHelmet([
			[
				1,
				"feathered_hat"
			]
		]));
		items.equip(this.new("scripts/items/supplies/legend_pudding_item"));
		items.addToBag(this.new("scripts/items/supplies/wine_item"));
		bros[5].setStartValuesEx([
			"legend_noble_ranged"
		], false);
		bros[5].getBackground().m.RawDescription = "%name% has won the house archery contest several years running, but never shuts up about it. The constant stream of narration makes the great aim easy to dodge.";
		bros[5].getBackground().buildDescription(true);
		bros[5].m.Talents = [];
		local talents = bros[5].getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.Fatigue] = 2;
		talents[this.Const.Attributes.RangedSkill] = 2;
		talents[this.Const.Attributes.Initiative] = 1;			
		bros[5].getSkills().add(this.new("scripts/skills/traits/sureshot_trait"));
		bros[5].getSkills().add(this.new("scripts/skills/traits/teamplayer_trait"));
		bros[5].getSkills().add(this.new("scripts/skills/traits/predictable_trait"));
		this.addScenarioPerk(bros[5].getBackground(), this.Const.Perks.PerkDefs.Rotation);

		if (bros[5].getBaseProperties().RangedSkill <= 60)
		{
			bros[5].getBaseProperties().RangedSkill += 5;
		}

		bros[5].setPlaceInFormation(14);
		//bros[5].setVeteranPerks(2);
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/cured_rations_item"));
		this.World.Assets.addBusinessReputation(this.m.StartingBusinessReputation);
		this.World.Assets.m.Money = this.World.Assets.m.Money * 3;
	}

});	