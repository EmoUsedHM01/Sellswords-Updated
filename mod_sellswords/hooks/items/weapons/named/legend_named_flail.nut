::Mod_Sellswords.HooksMod.hook("scripts/items/weapons/named/legend_named_flail", function ( q ) {

	::Mod_Sellswords.HookHelper.hookNamedItemToChangeStats(q, function() {
		local baseWeapon = ::new("scripts/items/weapons/crranged_flail");
		this.m.Condition = baseWeapon.m.Condition;
		this.m.ConditionMax = baseWeapon.m.ConditionMax;
		this.m.RegularDamage = baseWeapon.m.RegularDamage;
		this.m.RegularDamageMax = baseWeapon.m.RegularDamageMax;
		this.m.ArmorDamageMult = baseWeapon.m.ArmorDamageMult;
		this.m.ChanceToHitHead = baseWeapon.m.ChanceToHitHead;
		this.m.DirectDamageMult = baseWeapon.m.DirectDamageMult;
		this.m.DirectDamageAdd = baseWeapon.m.DirectDamageAdd;
		this.m.StaminaModifier = baseWeapon.m.StaminaModifier;
		this.m.ShieldDamage = baseWeapon.m.ShieldDamage;
		this.m.AdditionalAccuracy = baseWeapon.m.AdditionalAccuracy;
		this.m.FatigueOnSkillUse = baseWeapon.m.FatigueOnSkillUse;
		this.m.Value = 3800;
	});
});
