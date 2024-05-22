::mods_hookExactClass("items/tools/acid_flask_item", function ( o )
{
	local ws_onEquip = o.onEquip;
	o.onEquip = function ()
	{
		ws_onEquip();

		local skill = ::new("scripts/skills/actives/throw_acid_flask_pro");
		skill.setItem(this);
		this.addSkill(skill);		
		skill = ::new("scripts/skills/actives/throw_acid_flask_focus");
		skill.setItem(this);
		this.addSkill(skill);	
	};
});