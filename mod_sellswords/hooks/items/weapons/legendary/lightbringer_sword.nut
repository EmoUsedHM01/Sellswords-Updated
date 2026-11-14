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
			text = ::Mod_Sellswords.Strings.lightbringer_sword.Tooltip
		});
		return result;
	}		
});
