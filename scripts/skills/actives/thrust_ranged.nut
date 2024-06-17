this.thrust_ranged <- this.inherit("scripts/skills/actives/thrust", {
	m = {},
	function create()
	{
		this.m.Name = "Javelin Thrust";
		this.m.ID = "actives.thrust_ranged";
		this.m.Description = "A well placed thrust attack with a weapon meant for throwing.";
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.DamageTotalMult *= 0.6;

			if (_properties.IsSpecializedInSpearThrust)
			{
				_properties.DamageTotalMult *= 1.15;
			}

		}
	}

	function getTooltip()
	{
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
