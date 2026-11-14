::Mod_Sellswords.HooksMod.hook("scripts/events/events/dlc8/oathbreaker_event", function ( q ) {

	q.create = @(__original) function()
	{
		__original();

		foreach (screen in this.m.Screens)
		{
			switch(screen.ID)
			{
			case "BuyArmor":
				screen.start = function( _event )
				{
					local item;
					local stash = this.World.Assets.getStash();
					local weapons = [
						"weapons/arming_sword",
						"weapons/military_pick",
						"weapons/hand_axe",
						"weapons/pike",
						"weapons/warbrand"
					];
					item = this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]);
					item.setCondition(item.getConditionMax() / 3 - 1);
					stash.add(item);
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.oathbreaker_event.Tooltip1, this.Const.Strings.getArticle(item.getName()), item.getName())
					});
					item = this.Const.World.Common.pickArmor([
						[
							1,
							"ssu_adorned_heavy_mail_hauberk_armor"
						]
					]);				
					item.setArmor(item.getArmorMax() / 3 - 1);
					stash.add(item);
					this.List.push({
						id = 10,
						icon = "ui/items/armor/icon_body_armor_109.png",
						text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.oathbreaker_event.Tooltip1, this.Const.Strings.getArticle(item.getName()), item.getName())
					});
					item = this.Const.World.Common.pickHelmet([
						[
							1,
							"ssu_adorned_full_helm_helmet"
						]
					]);					
					item.setArmor(item.getArmorMax() / 3 - 1);
					stash.add(item);
					this.List.push({
						id = 10,
						icon = "ui/items/helmets/inventory_helmet_239.png",
						text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.oathbreaker_event.Tooltip1, this.Const.Strings.getArticle(item.getName()), item.getName())
					});
					this.World.Assets.addMoney(-9000);
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_money.png",
						text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.oathbreaker_event.Tooltip2, this.Const.UI.Color.NegativeEventValue)
					});
				}
				break;

			case "Oathtaker":
				screen.start = function( _event )
				{
					local roster = this.World.getTemporaryRoster();
					_event.m.Dude = roster.create("scripts/entity/tactical/player");
					_event.m.Dude.setStartValuesEx([
						"paladin_background"
					]);
					_event.m.Dude.setTitle(::Mod_Sellswords.Strings.oathbreaker_event.Title);
					_event.m.Dude.getBackground().m.RawDescription = ::Mod_Sellswords.Strings.oathbreaker_event.RawDescription;
					_event.m.Dude.getBackground().buildDescription(true);
					_event.m.Dude.m.PerkPoints = 0;
					_event.m.Dude.m.LevelUps = 0;
					_event.m.Dude.m.Level = 1;
					_event.m.Dude.m.XP = this.Const.LevelXP[_event.m.Dude.m.Level - 1];
					local trait = this.new("scripts/skills/traits/drunkard_trait");
					_event.m.Dude.getSkills().add(trait);
					local dudeItems = _event.m.Dude.getItems();

					if (dudeItems.getItemAtSlot(this.Const.ItemSlot.Mainhand) != null)
					{
						dudeItems.getItemAtSlot(this.Const.ItemSlot.Mainhand).removeSelf();
					}

					if (dudeItems.getItemAtSlot(this.Const.ItemSlot.Offhand) != null)
					{
						dudeItems.getItemAtSlot(this.Const.ItemSlot.Offhand).removeSelf();
					}

					if (dudeItems.getItemAtSlot(this.Const.ItemSlot.Head) != null)
					{
						dudeItems.getItemAtSlot(this.Const.ItemSlot.Head).removeSelf();
					}

					if (dudeItems.getItemAtSlot(this.Const.ItemSlot.Body) != null)
					{
						dudeItems.getItemAtSlot(this.Const.ItemSlot.Body).removeSelf();
					}

					local weapons = [
						"weapons/arming_sword",
						"weapons/military_pick",
						"weapons/hand_axe",
						"weapons/pike",
						"weapons/warbrand"
					];
					local item = this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]);
					item.setCondition(item.getConditionMax() / 3 - 1);
					dudeItems.equip(item);
					item = this.Const.World.Common.pickArmor([
						[
							1,
							"ssu_adorned_heavy_mail_hauberk_armor"
						]
					]);				
					item.setArmor(item.getArmorMax() / 3 - 1);
					dudeItems.equip(item);
					item = this.Const.World.Common.pickHelmet([
						[
							1,
							"ssu_adorned_full_helm_helmet"
						]
					]);	
					item.setArmor(item.getArmorMax() / 3 - 1);
					dudeItems.equip(item);
					this.Characters.push(_event.m.Dude.getImagePath());
				}
				break;
			}
		}
	}
});
