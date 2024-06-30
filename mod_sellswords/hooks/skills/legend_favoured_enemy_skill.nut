foreach (fav_enemy in [
	"alps",
	"bandit",
	"barbarian",
	"caravan",
	"direwolf",
	"ghoul",
	"goblin",
	"hexen",
	"hyena",
	"ifrit",
	"lindwurm",
	"master_archer",
	"mercenary",
	"noble",
	"nomad",
	"ork",
	"schrat",
	"serpent",
	"skeleton",
	"southerner",
	"spider",
	"swordmaster",
	"unhold",
	"vampire",
	"zombie"
])
{
	::Mod_Sellswords.HooksMod.hook("scripts/skills/perks/perk_legend_favoured_enemy_" + fav_enemy, function ( q ) {
		q.onUpdate <- function( _properties )
		{
			local actor = this.getContainer().getActor().get();
			if (!actor.getFlags().has(this.m.ID))
			{
				local stats = this.Const.LegendMod.GetFavoriteEnemyStats(actor, this.m.ID);
				if (stats.Strength >= 10)
				{
					actor.getFlags().add(this.m.ID);
					actor.m.PerkPoints += 1;
				}
			}
		};

		q.getTooltip <- function()
		{
			local ret = this.skill.getTooltip();
			if (this.getContainer().getActor().getFlags().has(this.m.ID))
			{
				// Perk Point has been refunded
				ret.push({
					id = 15,
					type = "hint",
					icon = "ui/icons/unlocked_small.png",
					text = "The perk point spent on this perk has been refunded."
				});
			}
			
			return ret;
		}
	});
}
