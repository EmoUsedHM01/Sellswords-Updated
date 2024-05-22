::mods_hookExactClass("skills/racial/ptr_orc_racial", function ( o )
{
	o.onAdded = function ()
	{
		this.getContainer().add(this.new("scripts/skills/traits/iron_jaw_trait"));
		local pss = this.new("scripts/skills/perks/perk_ptr_savage_strength");
		pss.m.isrealorc = true;
		this.getContainer().add(pss);
	};
});