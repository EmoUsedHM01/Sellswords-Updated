::Mod_Sellswords.HooksMod.hook("scripts/items/tools/daze_bomb_item", function ( q ) {

	q.create = @(__original) function()
	{
		__original();
		this.m.Description = "A throwable pot filled with mysterious powders that react violently on impact to create a bright flash and loud bang. Will daze anyone close by. Is refilled after each battle, consuming 30 ammunition per use.";
		this.m.Value = 1000;
		this.m.ItemType = this.Const.Items.ItemType.Ammo | this.Const.Items.ItemType.Tool;
		this.m.Ammo = 1;
		this.m.AmmoMax = 1;
		this.m.AmmoCost = 30;
		this.m.RangeMax = 3;
		this.m.StaminaModifier = 0;
		this.m.IsDroppedAsLoot = true;
	}

	q.isAmountShown <- function ()
	{
		return true;
	}

	q.getAmountString <- function ()
	{
		return this.m.Ammo + "/" + this.m.AmmoMax;
	}

	q.setAmmo <- function ( _a )
	{
		this.weapon.setAmmo( _a );

		if (this.m.Ammo > 0)
		{
			this.m.Name = "Flash Pot";
			this.m.IconLarge = "tools/daze_bomb_01.png";
			this.m.Icon = "tools/daze_bomb_01_70x70.png";
			this.m.ShowArmamentIcon = true;
		}
		else
		{
			this.m.Name = "Flash Pot (Used)";
			this.m.IconLarge = "tools/daze_bomb_01.png";
			this.m.Icon = "tools/daze_bomb_01_70x70.png";
			this.m.ShowArmamentIcon = false;
		}

		this.updateAppearance();
	}

});