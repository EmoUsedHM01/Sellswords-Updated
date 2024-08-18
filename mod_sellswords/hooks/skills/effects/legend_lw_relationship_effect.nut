::Mod_Sellswords.HooksMod.hook("scripts/skills/effects/legend_lw_relationship_effect", function( q ) {

	q.m.Level <- 0;

	q.setLevel <- function( _l )
	{
		this.m.Level = _l;
	}

	q.getTooltip = @() function()
	{
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
				id = 10,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.Level + "[/color] Melee Skill"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.Level + "[/color] Ranged Skill"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.Level + "[/color] Melee Defense"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.Level + "[/color] Ranged Defense"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + (this.m.Level * 2) + "[/color] Initiative"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.Math.floor(0.34 * this.m.Level) + "[/color] Fatigue Recovery"
			}
		];
	}

	q.onUpdate = @() function( _properties )
	{
		if (!this.getContainer().getActor().isPlacedOnMap())
		{
			this.m.IsHidden = true;
			return;
		}

		local actor = this.getContainer().getActor();
		local myTile = actor.getTile();
		local allies = this.Tactical.Entities.getInstancesOfFaction(actor.getFaction());
		local isSupported = false;

		foreach( ally in allies )
		{
			if (ally.getID() == actor.getID() || !ally.isPlacedOnMap())
			{
				continue;
			}

			if (ally.getTile().getDistanceTo(myTile) <= 1)
			{
				isSupported = true;
				break;
			}
		}

		if (isSupported)
		{
			this.m.IsHidden = false;
			_properties.MeleeSkill += this.m.Level;
			_properties.RangedSkill += this.m.Level;
			_properties.MeleeDefense += this.m.Level;
			_properties.RangedDefense += this.m.Level;
			_properties.Initiative += (this.m.Level * 2);
			_properties.FatigueRecoveryRate += this.Math.floor(0.34 * this.m.Level);
		}
		else
		{
			this.m.IsHidden = true;
		}
	}

	q.onTurnStart <- function()
	{
		local actor = this.getContainer().getActor();
		this.setLevel(this.Math.min(15, actor.getLevel()));
	}

});