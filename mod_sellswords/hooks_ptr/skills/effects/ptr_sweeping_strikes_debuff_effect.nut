::mods_hookExactClass("skills/effects/ptr_sweeping_strikes_debuff_effect", function ( o )
{
	o.setMalus = function ()
	{
		local actor = this.getContainer().getActor();
		local weapon = actor.getMainhandItem();
		this.m.Malus = 15;

		if (weapon != null && weapon.isItemType(this.Const.Items.ItemType.TwoHanded))
		{
			this.m.Malus -= 5;
		}

		if (actor.isTurnDone() || actor.isTurnStarted())
		{
			this.m.Malus = this.m.Malus / 2;
		}
	};
	o.getTooltip = function ()
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
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-" + this.m.Malus + "%[/color] Melee Skill"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-" + this.m.Malus + "%[/color] Resolve"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/damage.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-" + this.m.Malus + "%[/color] Damage"
			}
		];
	};
	o.onUpdate = function ( _properties )
	{
		_properties.MeleeSkillMult *= 1.0 - this.m.Malus * 0.01;
		_properties.BraveryMult *= 1.0 - this.m.Malus * 0.01;
		_properties.DamageTotalMult *= 1.0 - this.m.Malus * 0.01;
	};
});