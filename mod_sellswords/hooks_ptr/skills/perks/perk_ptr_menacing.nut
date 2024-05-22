::mods_hookExactClass("skills/perks/perk_ptr_menacing", function ( o )
{
	o.onUpdate = function ( _properties )
	{
		local dc = this.World.getTime().Days;
		dc = this.Math.floor(dc / 10);
		_properties.Threat += this.Math.min(15, 5 + dc);
	};
});	