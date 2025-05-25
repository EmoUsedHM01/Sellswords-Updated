::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/throw_spear_skill", function( q ) {
	q.calculateDamage = @(__original) function (_target)
	{
		local damage = __original(_target);

		if (targetEntity.getCurrentProperties().IsSpecializedInShields && this.getContainer().getItem().getCurrentProperties().IsSpecializedInThrowing)
			damage *= 2.00;

		return this.Math.floor(damage);
	}
});
