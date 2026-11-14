::Mod_Sellswords.HooksMod.hook("scripts/scenarios/world/trader_scenario", function ( q ) {

	q.create = @(__original) function()
	{
		__original();
		this.m.Description = ::Mod_Sellswords.Strings.trader_scenario.Description;
		this.m.Difficulty = 2;
	}

	q.onSpawnAssets = @(__original) function()
	{
		local roster = this.World.getPlayerRoster();
		local names = [];

		for( local i = 0; i < 2; ++i )
		{
			local bro;
			bro = roster.create("scripts/entity/tactical/player");
			bro.m.HireTime = this.Time.getVirtualTimeF();
			bro.worsenMood(0.5, "Encountered another caravan slaughtered by greenskins");

			while (names.find(bro.getNameOnly()) != null)
			{
				bro.setName(this.Const.Strings.CharacterNames[this.Math.rand(0, this.Const.Strings.CharacterNames.len() - 1)]);
			}

			names.push(bro.getNameOnly());
		}

		local bros = roster.getAll();
		bros[0].setStartValuesEx([
			"legend_peddler_commander_background"
		]);
		bros[0].setPlaceInFormation(4);

		bros[0].setVeteranPerks(2);
		bros[0].getSkills().add(this.new("scripts/skills/traits/player_character_trait"));	
		bros[0].getFlags().set("IsPlayerCharacter", true);
		bros[0].getSprite("socket").setBrush("bust_base_caravan");
		bros[0].getSprite("miniboss").setBrush("bust_miniboss_trader");
		this.addScenarioPerk(bros[0].getBackground(), this.Const.Perks.PerkDefs.LegendPeaceful);
		bros[0].m.PerkPointsSpent += 1;

		bros[1].setStartValuesEx([
			"caravan_hand_background"
		]);
		bros[1].setPlaceInFormation(5);
		bros[1].getBackground().m.RawDescription = ::Mod_Sellswords.Strings.trader_scenario.RawDescription;
		bros[1].m.Talents = [];
		local talents = bros[1].getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.MeleeSkill] = 2;
		talents[this.Const.Attributes.MeleeDefense] = 2;
		talents[this.Const.Attributes.Hitpoints] = 2;
		local items = bros[1].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		items.equip(this.new("scripts/items/weapons/scimitar"));
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/bread_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/mead_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/wine_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/trade/amber_shards_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/trade/cloth_rolls_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/trade/dies_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/trade/furs_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/trade/salt_item"));
		this.World.Assets.m.Money = this.World.Assets.m.Money * 2;
	}

	q.onInit = @(__original) function()
	{
		__original();
		this.World.Assets.m.BusinessReputationRate = 0.5;
		this.World.Assets.m.BuyPriceMult = 0.9;
		this.World.Assets.m.SellPriceMult = 1.1;
		this.World.Flags.set("IsLegendsTrader", true);
	}
});
