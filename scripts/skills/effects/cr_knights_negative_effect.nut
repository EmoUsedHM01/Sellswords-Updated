this.cr_knights_negative_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.cr_knights_negative";
		this.m.Name = "Band of Brothers";
		this.m.Description = "Trust is in short supply, and trusting those around you allows you to fight and focus better on the battlefield";
		this.m.Icon = "ui/traits/trait_icon_58.png";
		this.m.IconMini = "status_effect_78_mini";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = false;	
	}

	function getTooltip()
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
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + 1 * this.m.Level + "[/color] Melee Skill"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + 1 * this.m.Level + "[/color] Ranged Skill"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + 1 * this.m.Level + "[/color] Melee Defense"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + 1 * this.m.Level + "[/color] Ranged Defense"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + 1 * this.m.Level + "[/color] Initiative"
			}
		];
	}

	function onUpdate( _properties )
	{
		local actor = this.getContainer().getActor();

		if (!actor.isPlacedOnMap() || actor.getFaction() != this.Const.Faction.Player)
		{
			this.m.IsHidden = true;
			return;
		}

		local myTile = actor.getTile();
		local allies = this.Tactical.Entities.getInstancesOfFaction(this.Const.Faction.Player);
		local numSlaves = 0;

		foreach( ally in allies )
		{
			if (ally.getID() == actor.getID() || !ally.isPlacedOnMap())
			{
				continue;
			}

			if (ally.getBackground() != null && ally.getBackground().getID() == "background.slave")
			{
				numSlaves = numSlaves + 1;
			}
		}

		this.m.IsHidden = false;
		_properties.MeleeSkill += 1 * this.m.Level;
		_properties.RangedSkill += 1 * this.m.Level;
		_properties.MeleeDefense += 1 * this.m.Level;
		_properties.RangedDefense += 1 * this.m.Level;
		_properties.Initiative += 1 * this.m.Level;
	}

	function onCombatFinished()
	{
		this.removeSelf();
	}

});

