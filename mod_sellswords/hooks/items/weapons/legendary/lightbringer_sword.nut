::mods_hookExactClass("items/weapons/legendary/lightbringer_sword", function ( o )
{
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()

		this.m.RegularDamage = 60;
		this.m.RegularDamageMax = 65;
		this.m.ArmorDamageMult = 0.8;
	}
	
	o.getTooltip = function ()
	{
		local result = this.weapon.getTooltip();
		result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Inflicts an additional [color=" + this.Const.UI.Color.DamageValue + "]15%[/color] damage that ignores armor to up to three targets"
		});
		return result;
	}		
});