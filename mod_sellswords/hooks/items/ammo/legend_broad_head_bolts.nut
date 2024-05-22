::mods_hookExactClass("items/ammo/legend_broad_head_bolts", function ( o )
{
	local ws_create = o.create;
	o.create = function()
	{
		ws_create();

		this.m.Description = "A quiver of bolts with broad tips, designed for tearing through flesh, but is easily stopped by armour.\nIs automatically refilled after each battle if you have enough ammunition.\nGrants [color=" + ::Const.UI.Color.PositiveValue + "]+30%[/color] Damage to Hitpoints but [color=" + ::Const.UI.Color.NegativeValue + "]-10%[/color] Armour Piercing and Armour Damage";
	}

	o.onUpdateProperties = function( _properties )
	{
		this.ammo.onUpdateProperties(_properties);
		local actor = this.getContainer().getActor();
		local item = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);

		if (item == null || !item.isWeaponType(this.Const.Items.WeaponType.Crossbow))
		{
			return;
		}
		
		_properties.DamageDirectMult *= 0.9;
		_properties.DamageArmorMult *= 0.9;
		_properties.RangedDamageMult *= 1.3;
	}

});