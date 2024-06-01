::Mod_Sellswords.HooksMod.hook("scripts/skills/special/bag_fatigue", function ( q ) {

	q.onUpdate = @(__original) function ( _properties )
	{
		__original(_properties);
		local dc = this.Math.floor(this.World.getTime().Days / 10);
		local lv = this.getContainer().getActor().getLevel();
		lv = this.Math.min(dc, lv);
		_properties.Hitpoints += lv;
	};
});
