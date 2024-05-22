this.forest_blessing_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 2
	},
	function create()
	{
		this.m.ID = "effects.forest_blessing_effect";
		this.m.Name = "Blessed";
		this.m.Icon = "ui/perks/perk_druid_heal.png";
		this.m.IconMini = "dryad_buff_mini";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "You have been blessed with power for [color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.TurnsLeft + "[/color] more turn(s).";
	}

	function onUpdate( _properties )
	{
		if (this.m.TurnsLeft != 0)
		{
			_properties.DamageTotalMult *= 1.25;
			_properties.MeleeSkill += 15;
			_properties.MeleeDefense += 15;
			_properties.RangedSkill += 15;
			_properties.RangedDefense += 15;		
		}
	}
	function reset()
	{
		if (this.m.TurnsLeft != 2)
		{
			this.m.TurnsLeft = 2;
			this.spawnIcon("perk_37", this.getContainer().getActor().getTile());
		}
	}

	function onTurnStart()
	{
		if (--this.m.TurnsLeft <= 0)
		{
			this.removeSelf();
		}
	}

});

