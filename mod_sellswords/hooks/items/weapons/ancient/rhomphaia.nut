::Mod_Sellswords.HooksMod.hook("scripts/items/weapons/ancient/rhomphaia", function ( q ) {
	
	q.create = @(__original) function()
	{
		__original();
		this.m.DirectDamageAdd = 0.1;
	}

	q.onEquip = @(__original) function()
	{
		__original();

		::Mod_Sellswords.HookHelper.hookSpecificItemSkill.call(this, "actives.slash", function(_skill) {
			_skill.m.FatigueCost = 10;
		});
	}
});
