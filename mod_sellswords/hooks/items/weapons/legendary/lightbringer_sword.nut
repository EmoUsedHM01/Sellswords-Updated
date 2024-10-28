::Mod_Sellswords.HooksMod.hook("scripts/items/weapons/legendary/lightbringer_sword", function ( q ) {
	
	q.create = @(__original) function()
	{
		__original();

		this.m.RegularDamage = 60;
		this.m.RegularDamageMax = 65;
		this.m.ArmorDamageMult = 0.8;
	}
	
	q.getTooltip = @(__original) function()
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
