this.ssu_smackdown_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 2
	},
	function create()
	{
		this.m.ID = "effects.ssu_smackdown";
		this.m.Name = ::Mod_Sellswords.Strings.ssu_smackdown_effect.Name;
		this.m.Icon = "ui/perks/legend_vala_trance_mastery.png";
		this.m.IconMini = "ssu_smackdown_mini";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
		this.m.IsRemovedAfterBattle = true;
	}	

	function onUpdate( _properties )
	{ 
		_properties.ActionPoints -= 2;
	}

	function onAdded()
	{
		this.m.TurnsLeft = 2;
	}

	function onRefresh()
	{
		this.m.TurnsLeft = 2;
	}
	
	function onTurnEnd()
	{
		--this.m.TurnsLeft;
		if (this.m.TurnsLeft <= 0)
			this.removeSelf();
	}

});