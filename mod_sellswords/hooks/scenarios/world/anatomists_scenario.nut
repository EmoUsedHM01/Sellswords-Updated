::Mod_Sellswords.HooksMod.hook("scripts/scenarios/world/anatomists_scenario", function ( q ) {

	q.create = @(__original) function()
	{
		__original();
		this.m.Description = "[p=c][img]gfx/ui/events/event_181.png[/img][/p][p]Fueled by an unquenchable thirst for knowledge, the Anatomists have spent years dissecting the exotic and the alien. With social mores dogging their research, however, they\'ve decided to form a mercenary company to acquire new source of fresh specimens.\n\n[color=#bcad8c]Advanced Researchers:[/color] Start with three elite Anatomists and high funds. Doubles the Anatomist drop chance for potions.\n[color=#bcad8c]Fresh Specimens:[/color] Characters come with the \'Resilient\' perk, which allows you to withstand mutations from up to two sequences.[/p]";
	}

	q.onSpawnAssets = @(__original) function()
	{
		local roster = this.World.getPlayerRoster();
		local names = [];

		for( local i = 0; i < 3; i = i )
		{
			local bro;
			bro = roster.create("scripts/entity/tactical/player");
			bro.m.HireTime = this.Time.getVirtualTimeF();
			i = ++i;
		}

		local bros = roster.getAll();
		bros[0].setStartValuesEx([
			"anatomist_background"
		]);
		bros[0].getBackground().m.RawDescription = "{Captain? Is it alright if I call you captain? Ah, of course it is. What? No, we were not calling you by another name. Yers is a smooth costard, good sir, and we would not be of such derring-do to refer to you as a sellsword who is as ordinary as any of our coetaneous clodpolls, or state that we were in some sense importuning commerce by conducting business with a man of your particular skills. No sir, we would not. We are not children of perdition, sir.}";
		bros[0].setPlaceInFormation(3);
		bros[0].setVeteranPerks(2);
		bros[0].m.Talents = [];
		local talents = bros[0].getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.Bravery] = 1;
		talents[this.Const.Attributes.RangedSkill] = 2;
		talents[this.Const.Attributes.RangedDefense] = 2;
		bros[0].getBackground().addPerk(this.Const.Perks.PerkDefs.crresilient, 2, false);
		bros[0].getSkills().add(this.new("scripts/skills/perks/perk_crresilient"));
		local items = bros[0].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Body));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Head));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Offhand));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Ammo));
		local armor = this.new("scripts/items/legend_armor/cloth/legend_tunic");
		local plate = this.new("scripts/items/legend_armor/plate/undertakers_apron");
		armor.setUpgrade(plate);
		items.equip(armor);
		local hood = this.new("scripts/items/legend_helmets/hood/legend_helmet_cloth_scarf");
		local top = this.new("scripts/items/legend_helmets/top/legend_helmet_undertakers_scarf");
		local vanity = this.new("scripts/items/legend_helmets/vanity/legend_helmet_undertakers_hat");
		hood.setUpgrade(top);
		hood.setUpgrade(vanity);
		items.equip(hood);
		items.equip(this.new("scripts/items/weapons/crossbow"));
		items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));
		bros[1].setStartValuesEx([
			"anatomist_background"
		]);
		bros[1].getBackground().m.RawDescription = "{Despite others\' hesitancies, I\'ve no qualms calling you a javel, sir. You are, after all, a javel. A scapegrace. Some sellsword or another, yes? I think only a man who trucks cowardice would avoid calling you what you are. That someone disrespects your intelligence, thinking you yourself know not yourself. Even I see that in you accepting who you are, you are quite a good specimen. I mean, sellsword.}";
		bros[1].setPlaceInFormation(4);
		bros[1].setVeteranPerks(2);
		bros[1].m.Talents = [];
		talents = bros[1].getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.Hitpoints] = 2;
		talents[this.Const.Attributes.Initiative] = 3;
		talents[this.Const.Attributes.MeleeSkill] = 1;
		bros[1].getBackground().addPerk(this.Const.Perks.PerkDefs.crresilient, 2, false);
		bros[1].getSkills().add(this.new("scripts/skills/perks/perk_crresilient"));
		items = bros[1].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Body));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Head));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Offhand));
		local armor = this.new("scripts/items/legend_armor/cloth/wanderers_coat");
		local cloak = this.new("scripts/items/legend_armor/cloak/legend_religious_scarf");
		armor.setUpgrade(cloak);
		items.equip(armor);
		local hood = this.new("scripts/items/legend_helmets/hood/legend_helmet_beak_hood");
		local top = this.new("scripts/items/legend_helmets/top/legend_helmet_mask_beak");
		local vanity = this.new("scripts/items/legend_helmets/vanity/legend_helmet_physicians_hood");
		hood.setUpgrade(top);
		hood.setUpgrade(vanity);
		items.equip(hood);
		items.equip(this.new("scripts/items/weapons/dagger"));
		bros[2].setStartValuesEx([
			"anatomist_background"
		]);
		bros[2].getBackground().m.RawDescription = "{Though our quotidian dialogues are no doubt drollery, beneath the banausic surface I must admit I feel a touch of serotinous savagery lurking within you, coming to the fore as if my words be fire. Even our most desultory talks has me on edge, the way you stare at me with such hateful eyes. Well, know this, bounty hunter, I am no casuist, I speak in earnest. You are too fine a specimen-I mean captain to be lofting some sapskull\'s brickbats at. Understand?}";
		bros[2].setPlaceInFormation(5);
		bros[2].setVeteranPerks(2);
		bros[2].m.Talents = [];
		talents = bros[2].getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.Bravery] = 2;
		talents[this.Const.Attributes.MeleeDefense] = 3;
		talents[this.Const.Attributes.RangedDefense] = 3;
		bros[2].getBackground().addPerk(this.Const.Perks.PerkDefs.crresilient, 2, false);
		bros[2].getSkills().add(this.new("scripts/skills/perks/perk_crresilient"));
		items = bros[2].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Body));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Head));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Offhand));
		local armor = this.new("scripts/items/legend_armor/cloth/anatomist_robe");
		local cloak = this.new("scripts/items/legend_armor/cloak/anatomist_hood");
		armor.setUpgrade(cloak);
		items.equip(armor);
		local hood = this.new("scripts/items/legend_helmets/hood/legend_helmet_full_mask");
		local helm = this.new("scripts/items/legend_helmets/helm/legend_helmet_kettle_hat");
		hood.setUpgrade(helm);
		items.equip(hood);
		items.equip(this.new("scripts/items/weapons/militia_spear"));
		items.equip(this.new("scripts/items/shields/buckler_shield"));
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/smoked_ham_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/mead_item"));
		this.World.Assets.m.Money = this.World.Assets.m.Money + 700;
	}

	q.onActorKilled = @(__original) function( _actor, _killer, _combatID )
	{
	}

	q.onBattleWon = @(__original) function( _combatLoot )
	{
	}

	q.onCombatFinished = @(__original) function()
	{
		return true;
	}

	q.onGetBackgroundTooltip = @(__original) function( _background, _tooltip )
	{
	}

	q.onBuildPerkTree <- function(_background)
	{
		this.addScenarioPerk(_background, this.Const.Perks.PerkDefs.crresilient);
	}

});