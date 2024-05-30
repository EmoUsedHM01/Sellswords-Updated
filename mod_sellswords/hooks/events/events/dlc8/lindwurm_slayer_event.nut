::mods_hookExactClass("events/events/dlc8/lindwurm_slayer_event", function ( q ) {

	q.create = @(__original) function()
	{
		__original();

		foreach (screen in this.m.Screens)
		{
			switch(screen.ID)
			{
			case "A":
				screen.start = function( _event )
				{
					local item;
					local roster = this.World.getTemporaryRoster();
					_event.m.Dude = roster.create("scripts/entity/tactical/player");
					_event.m.Dude.setStartValuesEx([
						"lindwurm_slayer_background"
					]);
					_event.m.Dude.getBackground().m.RawDescription = "{%name% is a supposedly famous monster hunter with a particular talent for slaying lindwurms. He says he is the son of Dirk the Dragonslayer, the monster hunter who ostensibly slew the last living dragon.}";
					_event.m.Dude.getBackground().buildDescription(true);

					if (_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) != null)
					{
						_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).removeSelf();
					}

					if (_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand) != null)
					{
						_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand).removeSelf();
					}

					if (_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Head) != null)
					{
						_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Head).removeSelf();
					}

					if (_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Body) != null)
					{
						_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Body).removeSelf();
					}

					_event.m.Dude.getItems().equip(this.new("scripts/items/weapons/fighting_spear"));
					_event.m.Dude.getItems().equip(this.new("scripts/items/shields/special/craftable_lindwurm_shield"));
					item = this.Const.World.Common.pickHelmet([
						[
							1,
							"crlindwurm_slayer_helmet"
						]
					]);
					_event.m.Dude.getItems().equip(item);
					item = this.Const.World.Common.pickArmor([
						[
							1,
							"crlindwurm_slayer_armor"
						]
					]);
					_event.m.Dude.getItems().equip(item);
					this.Characters.push(_event.m.Dude.getImagePath());
				}
				break;

			case "B":
				screen.start = function( _event )
				{
					local item;
					local roster = this.World.getTemporaryRoster();
					_event.m.Dude = roster.create("scripts/entity/tactical/player");
					_event.m.Dude.setStartValuesEx([
						"lindwurm_slayer_background"
					]);
					_event.m.Dude.getBackground().m.RawDescription = "{%name% is a supposedly famous monster hunter with a particular talent for slaying lindwurms. He says he is the son of Dirk the Dragonslayer, the monster hunter who ostensibly slew the last living dragon.}";
					_event.m.Dude.getBackground().buildDescription(true);

					if (_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) != null)
					{
						_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).removeSelf();
					}

					if (_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand) != null)
					{
						_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand).removeSelf();
					}

					if (_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Head) != null)
					{
						_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Head).removeSelf();
					}

					if (_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Body) != null)
					{
						_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Body).removeSelf();
					}

					_event.m.Dude.getItems().equip(this.new("scripts/items/weapons/fighting_spear"));
					_event.m.Dude.getItems().equip(this.new("scripts/items/shields/special/craftable_lindwurm_shield"));
					item = this.Const.World.Common.pickHelmet([
						[
							1,
							"crlindwurm_slayer_helmet"
						]
					]);
					_event.m.Dude.getItems().equip(item);
					item = this.Const.World.Common.pickArmor([
						[
							1,
							"crlindwurm_slayer_armor"
						]
					]);
					_event.m.Dude.getItems().equip(item);
					this.Characters.push(_event.m.Dude.getImagePath());
				}
				break;
			}
		}
	}

});