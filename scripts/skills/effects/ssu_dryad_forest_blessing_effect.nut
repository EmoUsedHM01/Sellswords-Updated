this.ssu_dryad_forest_blessing_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 2
	},
	function create()
	{
		this.m.ID = "effects.ssu_dryad_forest_blessing_effect";
		this.m.Name = ::Mod_Sellswords.Strings.ssu_dryad_forest_blessing_effect.Name;
		this.m.Icon = "ui/perks/perk_druid_heal.png";
		this.m.IconMini = "ssu_dryad_buff_mini";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return ::Mod_Sellswords.text(::Mod_Sellswords.Strings.ssu_dryad_forest_blessing_effect.Text, this.m.TurnsLeft);
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

	function resetTime()
	{
		if (this.m.TurnsLeft != 2)
		{
			this.m.TurnsLeft = 2;
			this.spawnIcon("ssu_dryad_buff", this.getContainer().getActor().getTile());
		}
	}

	function onTurnEnd()
	{
		if (--this.m.TurnsLeft <= 0)
			this.removeSelf();
	}

});