::Mod_Sellswords.HooksMod.hook("scripts/items/legend_helmets/named/legend_named_lindwurm_helmet", function ( q ) {

	q.m.Potential = {
		Condition = { min = 168, max = 189 },
		StaminaModifier = { min = 9, max = 7 },
		Vision = { min = 2, max = 1 }
	};
});
