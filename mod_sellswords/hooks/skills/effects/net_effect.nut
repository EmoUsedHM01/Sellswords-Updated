::mods_hookExactClass("skills/effects/net_effect", function(o) {
	o.m.debuff <- 45;
	o.m.DropNet <- false;
	o.m.IsReinforced <- false;

	o.getdebuff <- function()
	{
		return this.m.debuff;
	}

	o.setdebuff <- function( _d )
	{
		this.m.debuff = _d;
	}

	o.getTooltip = function()
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
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Unable to move[/color]"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-" + debuff + "%[/color] Melee Defense"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-" + debuff + "%[/color] Ranged Defense"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-" + debuff + "%[/color] Initiative"
			}
		];
	}

	o.onUpdate = function( _properties )
	{
		_properties.IsRooted = true;
		_properties.MeleeDefenseMult *= 1 - 0.01 * this.getdebuff();
		_properties.RangedDefenseMult *= 1 - 0.01 * this.getdebuff();
		_properties.InitiativeMult *= 1 - 0.01 * this.getdebuff();
	}
	
	o.onDeath <- function( _fatalityType )
	{
		if (this.m.DropNet)
		{
			local net;
			if (this.m.IsReinforced)
			{
				net = this.new("scripts/items/tools/reinforced_throwing_net");
			}
			else
			{
				net = this.new("scripts/items/tools/throwing_net");	
			}
			net.drop(this.getContainer().getActor().getTile());
		}
	}

})