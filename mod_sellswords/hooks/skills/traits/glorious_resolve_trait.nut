::Mod_Sellswords.HooksMod.hook("scripts/skills/traits/glorious_resolve_trait", function ( q ) {

	q.create = @(__original) function()
	{
		__original();
		this.m.ID = "trait.glorious_resolve";
		this.m.Icon = "ui/traits/ssu_gladiator_3.png";
		this.m.Description = ::Mod_Sellswords.Strings.glorious_resolve_trait.Description;
	}

	q.getTooltip = @(__original) function()
	{
		local ret = __original();
		ret.push({
			id = 12,
			type = "text",
			icon = "ui/icons/asset_daily_money.png",
			text = ::Mod_Sellswords.Strings.glorious_resolve_trait.Wage
		});
		return ret;
	}

	q.onUpdate = @(__original) function( _properties )
	{
		__original(_properties);
		_properties.IsGladiator = true;
		_properties.DailyWageMult *= 1.5;
	}

});
