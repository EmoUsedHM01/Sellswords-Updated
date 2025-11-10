//"Parasitic Blood";
//"This character\'s body has the incredible ability to incorporate different blood types - or indeed, blood from entirely different creatures - into itself. This grants them remarkable healing via absorption of blood through skin pores (or more dramatically by drinking it directly).";
::Mod_Sellswords.HooksMod.hook("scripts/skills/effects/necrosavant_potion_effect", function ( q ) {

	q.getTooltip = @(__original) function()
	{
		local ret = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			}
		];

		if (this.getContainer().getActor().getFlags().has("vampire_l"))
		{
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/health.png",
				text = "Heal [color=%positive%]25%[/color] of hitpoint damage inflicted on adjacent enemies that have blood" + "\n[color=%positive%]+30[/color] Hitpoints." + "\n[color=%positive%]+10[/color] Melee Skill."
			});
		}
		else
		{
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/health.png",
				text = "Heal [color=%positive%]15%[/color] of hitpoint damage inflicted on adjacent enemies that have blood" + "\n[color=%positive%]+10[/color] Hitpoints." + "\n[color=%positive%]+5[/color] Melee Skill."
			});
		}
		
		ret.push({
			id = 12,
			type = "hint",
			icon = "ui/tooltips/warning.png",
			text = "Further mutations may cause this character\'s genes to spiral out of control, crippling them"
		});
		return ret;
	}

	q.onUpdate <- function(_properties)
	{
		if (this.getContainer().getActor().getFlags().has("vampire_l"))
		{
			_properties.MeleeSkill += 15;
			_properties.Hitpoints += 30;
		}
		else
		{
			_properties.MeleeSkill += 5;
			_properties.Hitpoints += 10;
		}
		
	}

	q.lifesteal = @(__original) function( _damageInflictedHitpoints )
	{
		local actor = this.m.Container.getActor();
		this.spawnIcon("status_effect_09", actor.getTile());
		local hasMastery = this.getContainer().getActor().getFlags().has("vampire_l");
		local lifesteal_percent = hasMastery ? 0.25 : 0.15;

		local hitpointsHealed = this.Math.round(_damageInflictedHitpoints * lifesteal_percent);

		if (!actor.isHiddenToPlayer())
		{
			if (this.m.SoundOnUse.len() != 0)
			{
				this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.RacialEffect, actor.getPos());
			}

			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(actor) + " heals for " + this.Math.min(actor.getHitpointsMax() - actor.getHitpoints(), hitpointsHealed) + " points");
		}

		actor.setHitpoints(this.Math.min(actor.getHitpointsMax(), actor.getHitpoints() + hitpointsHealed));
		actor.onUpdateInjuryLayer();
	}

});