this.cr_consecrated_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 4,
		Skeleton = false
	},
	function create()
	{
		this.m.ID = "effects.cr_consecrated";
		this.m.Name = "Consecrated";
		this.m.Description = "This character is being consecrated by holy light";
		this.m.Icon = "ui/perks/holyfire_circle.png";
		this.m.IconMini = "mini_fire_circle";
		this.m.Overlay = "fire_circle";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();
		ret.push({
			id = 12,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Loses any immunity to injuries for [color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.TurnsLeft + "[/color] more turns."
		});
		return ret;
	}

	function onAdded()
	{
		this.m.TurnsLeft = this.Math.max(3, 2 + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);
		this.Tactical.TurnSequenceBar.pushEntityBack(this.getContainer().getActor().getID());
	}

	function onRefresh()
	{
		this.m.TurnsLeft = this.Math.max(3, 2 + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);
		this.Tactical.TurnSequenceBar.pushEntityBack(this.getContainer().getActor().getID());
		this.spawnIcon("fire_circle", this.getContainer().getActor().getTile());
	}

	function onTurnEnd()
	{
		if (--this.m.TurnsLeft <= 0)
		{
			this.removeSelf();
		}
	}

	function onUpdate( _properties )
	{
		//_properties.IsAffectedByLosingHitpoints = true;
		_properties.IsAffectedByInjuries = true;
		_properties.IsAffectedByFreshInjuries = true;
		//_properties.IsImmuneToBleeding = false;
		//_properties.IsImmuneToPoison = false;
		if (this.m.Skeleton)
		{
			_properties.ActionPoints -= 1;		
		}
	}

});

