::Mod_Sellswords.HooksMod.hook("scripts/skills/traits/old_trait", function ( q ) {
	
	q.getTooltip = @(__original) function()
	{
		local ret = __original();

		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/regular_damage.png",
			text = "[color=" + this.Const.UI.Color.NegativeValue + "]-15%[/color] Melee Damage"
		})

		return ret;
	}

	q.onUpdate = @(__original) function( _properties )
	{
		__original(_properties);

		_properties.MeleeDamageMult *= 0.85;	
	}
});
