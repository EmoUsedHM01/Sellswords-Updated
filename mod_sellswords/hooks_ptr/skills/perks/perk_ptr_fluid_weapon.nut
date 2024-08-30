::mods_hookExactClass("skills/perks/perk_ptr_fluid_weapon", function ( o )
{
	o.m.FatigueToInitiative <- 0.25;

	local ws_create = o.create;
	o.create = function()
	{
		ws_create();
		this.m.IconMini = "ptr_fluid_weapon_mini";
	}

	// local ws_getTooltip = o.getTooltip;
	// o.getTooltip = function()
	// {
	// 	local ret = ws_getTooltip();

	// 	ret.push({
	// 		id = 10,
	// 		type = "text",
	// 		icon = "ui/icons/fatigue.png",
	// 		text = "Penalty to Initiative from Fatigue build-up is decreased by [color=" + this.Const.UI.Color.PositiveValue + "]-" + this.getInitiativeBonus() + "%[/color] "
	// 	});

	// 	return ret;
	// }

	// local ws_onUpdate = o.onUpdate;
	// o.onUpdate = function ( _properties )
	// {
	// 	ws_onUpdate( _properties );
	// 	local weapon = this.getContainer().getActor().getMainhandItem();
	// 	if (weapon != null)	
	// 	{
	// 		local maxdamage = weapon.m.RegularDamageMax;
	// 		local bonus = this.Math.floor(this.m.FatigueToInitiative * maxdamage);
	// 		_properties.FatigueToInitiativeRate *= bonus;
	// 	}
	// }
});