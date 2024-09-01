::Mod_Sellswords.HooksMod.hook("scripts/items/tools/acid_flask_item", function ( q ) {

	q.create = @(__original) function()
	{
		__original();
		this.m.Description = "A flask filled with the concentrate of a Lindwurm\'s acidic blood. It is highly corrosive to many materials and burns through armor quickly. Can be thrown at short ranges. Is refilled after each battle, consuming 30 ammunition per use.";
		this.m.Value = 2500;
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
			this.m.Name = "Acid Flask";
			this.m.IconLarge = "tools/acid_flask_01.png";
			this.m.Icon = "tools/acid_flask_01_70x70.png";
			this.m.ShowArmamentIcon = true;
		}
		else
		{
			this.m.Name = "Acid Flask (Used)";
			this.m.IconLarge = "tools/acid_flask_01.png";
			this.m.Icon = "tools/acid_flask_01_70x70.png";
			this.m.ShowArmamentIcon = false;
		}

		this.updateAppearance();
	}

});