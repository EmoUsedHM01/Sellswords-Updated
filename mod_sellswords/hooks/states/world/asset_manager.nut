::Mod_Sellswords.HooksMod.hook("scripts/states/world/asset_manager", function ( q ) {

	q.refillAmmo = @(__original) function()
	{
		if (this.m.Ammo == 0)
		{
			return;
		}

		local roster = this.World.getPlayerRoster().getAll();

		foreach( bro in roster )
		{
			local items = bro.getItems().getAllItems();

			foreach( item in items )
			{
				if (item.isItemType(this.Const.Items.ItemType.Ammo) && item.getAmmo() < item.getAmmoMax())
				{	
					switch (true)
					{
						case item.getID() == "weapon.acid_flask":
						case item.getID() == "weapon.acid_flask_02":
						case item.getID() == "weapon.daze_bomb":
						case item.getID() == "weapon.fire_bomb":
						case item.getID() == "weapon.holy_water":
						case item.getID() == "weapon.smoke_bomb":
							if (!this.World.Retinue.hasFollower("follower.alchemist"))
								continue;
					}
					local a = this.Math.min(this.m.Ammo, this.Math.ceil(item.getAmmoMax() - item.getAmmo()) * item.getAmmoCost());

					if (this.m.Ammo >= a)
					{
						item.setAmmo(item.getAmmo() + this.Math.ceil(a / item.getAmmoCost()));
						this.m.Ammo -= a;
					}
				}

				if (this.m.Ammo == 0)
				{
					break;
				}
			}
		}

		if (this.World.State.getCurrentTown() != null)
		{
			this.World.State.getTownScreen().updateAssets();
		}
	}
});
