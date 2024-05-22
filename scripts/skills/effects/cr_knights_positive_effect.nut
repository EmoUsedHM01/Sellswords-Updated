this.legend_lw_relationship_effect <- this.inherit("scripts/skills/skill", {
	m = {
		Level = 0
	},
	function create()
	{
		this.m.ID = "effects.legend_lw_relationship";
		this.m.Name = "Band of Brothers";
		this.m.Description = "Trust is in short supply, and trusting those around you allows you to fight and focus better on the battlefield";
		this.m.Icon = "ui/traits/trait_icon_58.png";
		this.m.IconMini = "status_effect_78_mini";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.VeryLast;
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

	function setLevel( _l )
	{
		this.m.Level = _l;
	}

	function onUpdate( _properties )
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
			_properties.MeleeSkill += 1 * this.m.Level;
			_properties.RangedSkill += 1 * this.m.Level;
			_properties.MeleeDefense += 1 * this.m.Level;
			_properties.RangedDefense += 1 * this.m.Level;
			_properties.Initiative += 1 * this.m.Level;
		}
		else
		{
			this.m.IsHidden = true;
		}
	}

	function onCombatFinished()
	{
		this.m.IsHidden = true;
		local actor = this.getContainer().getActor();	
		actor.getSkills().removeByID("trait.legend_lw_relationship");		
		actor.getSkills().add(this.new("scripts/skills/traits/legend_lw_relationship_trait"));
	}

});

