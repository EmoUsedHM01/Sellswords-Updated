this.chop_ranged <- this.inherit("scripts/skills/actives/chop", {
	m = {},
	function create()
	{
		this.m.Name = "Throwing Axe Chop";
		this.m.ID = "actives.chop_ranged";
		this.m.Description = "A improvised chopping attack with an axe meant for throwing.";
	}

	function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		ret.extend([
			{
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Inflicts additional [color=" + this.Const.UI.Color.PositiveValue + "]50%[/color] damage on a hit to the head"
			}
		]);
		return ret;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.DamageAgainstMult[this.Const.BodyPart.Head] += 0.5;
			_properties.DamageTotalMult *= 0.6;
		}
	}

	function isUsable()
	{
		return this.skill.isUsable() && this.getAmmo() > 0;
	}

	function getAmmo()
	{
		local item = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);

		if (item == null)
		{
			return 0;
		}

		return item.getAmmo();
	}

	function isHidden()
	{
		local actor = this.getContainer().getActor();
		if (actor == null)
		{
			return true;
		}

		if (!actor.getSkills().hasSkill("perk.close_combat_archer"))
		{
			return true;
		}

		return false;
	}
});
