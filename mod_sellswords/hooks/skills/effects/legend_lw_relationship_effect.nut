::mods_hookExactClass("skills/effects/legend_lw_relationship_effect", function(o) {
	o.m.Level <- 0;

	o.setLevel <- function( _lv )
	{
		this.m.Level = _lv;
	}

	local ws_create = o.create;
	o.create = function()
	{
		ws_create();
		this.m.Icon = "ui/traits/trait_icon_58.png";
		this.m.IconMini = "status_effect_78_mini";
	}

	o.getTooltip = function()
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
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.Level + "[/color] Initiative"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.Math.floor(0.34 * this.m.Level) + "[/color] Fatigue Recovery"
			}			
		];
	}

	o.onUpdate = function( _properties )
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
			_properties.Initiative += this.m.Level;
			_properties.Initiative += this.m.Level;
			_properties.FatigueRecoveryRate += this.Math.floor(0.34 * this.m.Level);			
		}
		else
		{
			this.m.IsHidden = true;
		}
	}

	o.onCombatFinished = function()
	{
		this.m.IsHidden = true;
		local actor = this.getContainer().getActor();	
		actor.getSkills().removeByID("trait.legend_lw_relationship");		
		actor.getSkills().add(this.new("scripts/skills/traits/legend_lw_relationship_trait"));
	}
})