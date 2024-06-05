foreach (script in [
	"legend_heartwood_sap_flask_blueprint",
	"legend_hexen_ichor_potion_blueprint",
	"legend_skin_ghoul_blood_flask_blueprint",
	"legend_stollwurm_blood_flask_blueprint"
])
{
	::Mod_Sellswords.HooksMod.hook("scripts/crafting/blueprints/mod_legend/utilities/" + script, function ( q ) {
	
		q.create = @(__original) function()
		{
			__original();
			this.m.Cost = 300;
		}
	});
}
