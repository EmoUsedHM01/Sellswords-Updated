::mods_hookExactClass("items/legend_armor/cloth/legend_gambeson_wolf", function ( o )
{
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()

		this.m.Value = 700;
		this.m.Condition = 80;
		this.m.ConditionMax = 80;
		this.m.StaminaModifier = -9;
	}
});	