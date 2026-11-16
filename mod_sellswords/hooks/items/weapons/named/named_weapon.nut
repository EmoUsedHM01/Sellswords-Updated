::Mod_Sellswords.HooksMod.hook("scripts/items/weapons/named/named_weapon", function ( q ) {
	q.m.IsAllowedRandomizeValues <- true;

	q.randomizeValues = @(__original) function()
	{
		if (!this.m.IsAllowedRandomizeValues) return;

		__original();

		// a weapon that ignores more than 90% armor gets nothing out of more direct damage, so it rolls again if it got that
		while (this.m.DirectDamageMult > 0.9 && this.m.DirectDamageAdd != this.m.BaseProperties.DirectDamageAdd)
		{
			foreach (key, value in this.m.BaseProperties)
			{
				this.m[key] = value;
			}

			this.m.Condition = this.m.ConditionMax;
			this.m.Ammo = this.m.AmmoMax;
			this.m.PossibleEffectIdx = -1;
			__original();
		}
	}
});
