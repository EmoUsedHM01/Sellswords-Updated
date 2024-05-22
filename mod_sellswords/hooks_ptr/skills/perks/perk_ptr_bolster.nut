::mods_hookExactClass("skills/perks/perk_ptr_bolster", function ( o )
{
	o.isInEffect = function()
	{
		return true;
	}

	o.onTurnEnd = function()
	{
	}
});	