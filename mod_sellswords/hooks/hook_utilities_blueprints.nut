foreach (script in [
	"legend_heartwood_sap_flask_blueprint",
	"legend_hexen_ichor_potion_blueprint",
	"legend_skin_ghoul_blood_flask_blueprint",
	"legend_stollwurm_blood_flask_blueprint"
])
{
	::mods_hookExactClass("crafting/blueprints/mod_legend/utilities/" + script, function(o) {
		local ws_create = o.create;
		o.create = function()
		{
			ws_create();
			this.m.Cost = 300;
		}
	})
}
