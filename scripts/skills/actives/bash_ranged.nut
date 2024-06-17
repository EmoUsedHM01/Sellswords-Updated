this.bash_ranged <- this.inherit("scripts/skills/actives/bash", {
	m = {},
	function create()
	{
		this.m.Name = "Bola Bash";
		this.m.ID = "actives.bash_ranged";
		this.m.Description = "An awkward brute force attack with a weapon unsuited for this role.";
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.FatigueDealtPerHitMult += 2.0;
			_properties.DamageTotalMult *= 0.4;
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
