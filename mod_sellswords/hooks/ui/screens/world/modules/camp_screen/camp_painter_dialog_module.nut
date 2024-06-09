::Mod_Sellswords.HooksMod.hook("scripts/ui/screens/world/modules/camp_screen/camp_painter_dialog_module", function ( q ) {

	q.queryRosterInformation = @( __original ) function ()
	{
		local brothers = this.World.getPlayerRoster().getAll();
		local roster = [];
		foreach( b in brothers )
		{
			local background = b.getBackground();
			local bodyarmorbase = b.getItems().getItemAtSlot(this.Const.ItemSlot.Body);
			local bodyarmor;
			local bodyarmorfinal = {};
			if (bodyarmorbase != null)
			{
				bodyarmor = {
					Cloth = bodyarmorbase,
					Chain = bodyarmorbase.getUpgrade(this.Const.Items.ArmorUpgrades.Chain),
					Plate = bodyarmorbase.getUpgrade(this.Const.Items.ArmorUpgrades.Plate),
					Tabard = bodyarmorbase.getUpgrade(this.Const.Items.ArmorUpgrades.Tabbard),
					Cloak = bodyarmorbase.getUpgrade(this.Const.Items.ArmorUpgrades.Cloak)
				};
				foreach( key, value in bodyarmor )
				{
					if (value != null)
					{
						bodyarmorfinal[key] <- {
							Link = this.IO.scriptFilenameByHash(value.ClassNameHash),
							ID = value.m.ID,
							Value = 5,
							Variant = value.m.Variants.find(value.m.Variant) != null ? value.m.Variants.find(value.m.Variant) + 1 : 1,
							Variants = this.Math.max(value.m.Variants.len(), 1),
							Icon = value.m.Icon,
							IconLarge = value == bodyarmorbase ? value.m.IconLarge : value.m.OverlayIconLarge
						};
					}
					else
					{
						bodyarmorfinal[key] <- null;
					}
				}
			}
			local helmetbase = b.getItems().getItemAtSlot(this.Const.ItemSlot.Head);
			if (helmetbase != null && helmetbase.getID() == "armor.head.fangshire")
			{
				helmetbase = null;
			}
			local helmet;
			local helmetfinal = {};
			if (helmetbase != null)
			{
				helmet = {
					Hood = helmetbase,
					Helm = helmetbase.getUpgrade(this.Const.Items.HelmetUpgrades.Helm),
					Top = helmetbase.getUpgrade(this.Const.Items.HelmetUpgrades.Top),
					Vanity = helmetbase.getUpgrade(this.Const.Items.HelmetUpgrades.Vanity),
					ExtraVanity = helmetbase.getUpgrade(this.Const.Items.HelmetUpgrades.ExtraVanity)
				};
				foreach( key, value in helmet )
				{
					if (value != null)
					{
						helmetfinal[key] <- {
							Link = this.IO.scriptFilenameByHash(value.ClassNameHash),
							ID = value.m.ID,
							Value = 5,
							Variant = value.m.Variants.find(value.m.Variant) != null ? value.m.Variants.find(value.m.Variant) + 1 : 1,
							Variants = this.Math.max(value.m.Variants.len(), 1),
							Icon = value.m.Icon,
							IconLarge = value.m.IconLarge
						};
					}
					else
					{
						helmetfinal[key] <- null;
					}
				}
			}
			local shield = {};
			if (b.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand) != null)
			{
				local shielditem = b.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);
				shield.Shield <- {
					Link = this.IO.scriptFilenameByHash(shielditem.ClassNameHash),
					ID = shielditem.m.ID,
					Value = 5,
					Variant = shielditem.m.Variants.find(shielditem.m.Variant) != null ? shielditem.m.Variants.find(shielditem.m.Variant) + 1 : 1,
					Variants = this.Math.max(shielditem.m.Variants.len(), 1),
					Icon = shielditem.m.IconLarge,
					IconLarge = shielditem.m.IconLarge
				};
				if (shielditem.m.ID == "shield.faction_kite_shield" || shielditem.m.ID == "shield.faction_heater_shield")
				{
					shield.Shield.Variants = 20;
					shield.Shield.Variant = shielditem.m.Faction * 2 - (2 - shielditem.m.Variant);
				}
			}
			else
			{
				shield.Shield <- null;
			}
			local e = {
				ID = b.getID(),
				Name = b.getName(),
				ImagePath = b.getImagePath(),
				ImageOffsetX = b.getImageOffsetX(),
				ImageOffsetY = b.getImageOffsetY(),
				BackgroundImagePath = background.getIconColored(),
				BackgroundText = background.getDescription(),
				BodyArmor = bodyarmorfinal,
				Helmet = helmetfinal,
				Shield = shield
			};
			roster.push(e);
		}
		return {
			Title = "Painting Tent",
			SubTitle = "Customize the appearance of your armor",
			Roster = roster,
			Assets = this.m.Parent.queryAssetsInformation()
		};
	}
});
