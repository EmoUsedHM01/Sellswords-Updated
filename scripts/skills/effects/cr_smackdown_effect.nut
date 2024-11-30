this.cr_smackdown_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 2
	},
	function create()
	{
		this.m.ID = "effects.cr_smackdown";
		this.m.Name = "Smacked Down";
		this.m.Icon = "ui/perks/legend_vala_trance_mastery.png";
		this.m.IconMini = "crSmackdown_mini";
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
		this.m.TurnsLeft == 2;
	}
	
	function onTurnEnd()
	{
		--this.m.TurnsLeft;
		if (this.m.TurnsLeft <= 0)
			this.removeSelf();
	}

});