::Mod_Sellswords.HooksMod.hook("scripts/items/tools/holy_water_item", function ( q ) {

	q.create = @(__original) function()
	{
		__original();
		this.m.Description = "A flask filled with water blessed by a man of the gods. Can be thrown at short ranges. Is refilled after each battle, consuming 30 ammunition per use.";
		this.m.Value = 1300;
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
			this.m.Name = "Holy Water";
			this.m.IconLarge = "tools/holy_water_01.png";
			this.m.Icon = "tools/holy_water_01_70x70.png";
			this.m.ShowArmamentIcon = true;
		}
		else
		{
			this.m.Name = "Holy Water (Used)";
			this.m.IconLarge = "tools/holy_water_01.png";
			this.m.Icon = "tools/holy_water_01_70x70.png";
			this.m.ShowArmamentIcon = false;
		}

		this.updateAppearance();
	}

});