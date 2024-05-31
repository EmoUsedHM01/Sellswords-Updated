::Mod_Sellswords.HooksMod.hook("scripts/items/tools/acid_flask_item", function ( q ) {
	
	q.onEquip = @(__original) function()
	{
		__original();

		local skill = ::new("scripts/skills/actives/throw_acid_flask_pro");
		skill.setItem(this);
		this.addSkill(skill);		
		skill = ::new("scripts/skills/actives/throw_acid_flask_focus");
		skill.setItem(this);
		this.addSkill(skill);	
	};
});
