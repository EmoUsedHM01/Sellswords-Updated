::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/throw_spear_skill", function( q ) {
	q.calculateDamage = @(__original) function (_target)
	{
		local damage = __original(_target);

		if (_target.getCurrentProperties().IsSpecializedInShields && this.getContainer().getActor().getCurrentProperties().IsSpecializedInThrowing)
			damage *= 2.00;

		return this.Math.floor(damage);
	}
});
