foreach (background in [
	"legend_man_at_arms_background",
	"legend_shieldmaiden_background",
	"militia_background",
	"nomad_background",
	"paladin_background",
	"raider_background",
	"sellsword_background"
])
{
	::Mod_Sellswords.HooksMod.hook("scripts/skills/backgrounds/" + background, function ( q ) {

		q.create = @(__original) function()
		{
			__original();
			this.m.PerkTreeDynamic.Class <- [this.Const.Perks.VeteranClassTree]
		}
	});
}