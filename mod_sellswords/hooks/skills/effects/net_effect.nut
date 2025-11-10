::Mod_Sellswords.HooksMod.hook("scripts/skills/effects/net_effect", function ( q ) {

	q.m.debuff <- 45;
	q.m.DropNet <- false;

	q.getdebuff <- function()
	{
		return this.m.debuff;
	}

	q.setdebuff <- function( _d )
	{
		this.m.debuff = _d;
	}

	q.getTooltip = @(__original) function()
	{
		local debuff = this.getdebuff();
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 9,
				type = "text",
				icon = "ui/icons/action_points.png",
				text = "[color=%negative%]Unable to move[/color]"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=%negative%]-" + debuff + "%[/color] Melee Defense"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=%negative%]-" + debuff + "%[/color] Ranged Defense"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=%negative%]-" + debuff + "%[/color] Initiative"
			}
		];
	}

	q.onUpdate = @(__original) function( _properties )
	{
		_properties.IsRooted = true;
		_properties.MeleeDefenseMult *= 1 - 0.01 * this.getdebuff();
		_properties.RangedDefenseMult *= 1 - 0.01 * this.getdebuff();
		_properties.InitiativeMult *= 1 - 0.01 * this.getdebuff();
	}

});