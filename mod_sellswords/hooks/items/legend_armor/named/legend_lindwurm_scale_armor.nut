::Mod_Sellswords.HooksMod.hook("scripts/items/legend_armor/named/legend_lindwurm_scale_armor", function ( q ) {

	q.m.Potential = {
		Condition = { min = 143, max = 162 },
		StaminaModifier = { min = 11, max = 8 }
	};
});
