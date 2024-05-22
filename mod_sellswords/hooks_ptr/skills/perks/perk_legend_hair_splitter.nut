::mods_hookExactClass("skills/perks/perk_legend_hair_splitter", function(o) {
	o.onUpdate = function( _properties )
	{
		_properties.HitChance[this.Const.BodyPart.Head] += 30;
	}
});
