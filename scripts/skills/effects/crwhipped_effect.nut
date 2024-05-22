this.crwhipped_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 3,
	},
	function create()
	{
		this.m.ID = "effects.crwhipped";
		this.m.Name = "Motivated!!!";
		this.m.Icon = "skills/status_effect_121.png";
		this.m.IconMini = "status_effect_121_mini";
		this.m.Overlay = "status_effect_121";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.VeryLast;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "This character just received a hurtful reminder of what they need to do for their masters. It will last for another " + this.m.TurnsLeft + " round(s).";
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
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+5[/color] Melee Skill"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+5[/color] Ranged Skill"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+15[/color] Resolve"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+15[/color] Initiative"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+5[/color] Melee Defense"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+5[/color] Ranged Defense"
			}
		];
	}

	function onAdded()
	{
		this.m.TurnsLeft = 3;
		local actor = this.getContainer().getActor();
		actor.getSprite("status_sweat").setBrush("bust_slave_whipped");
		actor.setDirty(true);
	}

	function onRefresh()
	{
		this.m.TurnsLeft = 3;
	}

	function onRemoved()
	{
		local actor = this.getContainer().getActor();
		actor.getSprite("status_sweat").resetBrush();
		actor.setDirty(true);
	}

	function onUpdate( _properties )
	{
		_properties.MeleeSkill += 5;
		_properties.RangedSkill += 5;
		_properties.MeleeDefense += 5;
		_properties.RangedDefense += 5;
		_properties.Bravery += 15;
		_properties.Initiative += 15;
		local actor = this.getContainer().getActor();
		actor.getSprite("status_sweat").setBrush("bust_slave_whipped");
		actor.setDirty(true);
	}

	function onRoundEnd()
	{
		if (--this.m.TurnsLeft <= 0)
		{
			this.removeSelf();
		}
	}

});

