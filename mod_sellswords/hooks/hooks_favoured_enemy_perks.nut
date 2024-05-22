foreach (favenemy in [
	"perk_legend_favoured_enemy_alps",
	"perk_legend_favoured_enemy_bandit",
	"perk_legend_favoured_enemy_barbarian",
	"perk_legend_favoured_enemy_caravan",	
	"perk_legend_favoured_enemy_direwolf",	
	"perk_legend_favoured_enemy_ghoul",	
	"perk_legend_favoured_enemy_goblin",	
	"perk_legend_favoured_enemy_hexen",	
	"perk_legend_favoured_enemy_hyena",	
	"perk_legend_favoured_enemy_ifrit",	
	"perk_legend_favoured_enemy_lindwurm",	
	"perk_legend_favoured_enemy_master_archer",	
	"perk_legend_favoured_enemy_mercenary",	
	"perk_legend_favoured_enemy_noble",	
	"perk_legend_favoured_enemy_nomad",	
	"perk_legend_favoured_enemy_ork",	
	"perk_legend_favoured_enemy_schrat",	
	"perk_legend_favoured_enemy_serpent",	
	"perk_legend_favoured_enemy_skeleton",		
	"perk_legend_favoured_enemy_southerner",	
	"perk_legend_favoured_enemy_spider",	
	"perk_legend_favoured_enemy_swordmaster",	
	"perk_legend_favoured_enemy_unhold",	
	"perk_legend_favoured_enemy_unhold",	
	"perk_legend_favoured_enemy_vampire",	
	"perk_legend_favoured_enemy_zombie"		
])
{
	::mods_hookExactClass("skills/perks/" + favenemy, function(o) {
		o.onUpdateLevel <- function ()
		{
			local actor = this.getContainer().getActor();
			if (actor.m.Level == 18)
			{
				actor.m.PerkPoints += 1;
			}
		}
	});	
}