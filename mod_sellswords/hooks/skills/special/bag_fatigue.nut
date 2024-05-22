::mods_hookExactClass("skills/special/bag_fatigue", function ( o )
{
	local onUpdate = o.onUpdate;
	o.onUpdate = function ( _properties )
	{
		onUpdate(_properties);
		local dc = this.Math.floor(this.World.getTime().Days / 10);
		local lv = this.getContainer().getActor().getLevel();
		lv = this.Math.min(dc, lv);
		_properties.Hitpoints += lv;
	};
});