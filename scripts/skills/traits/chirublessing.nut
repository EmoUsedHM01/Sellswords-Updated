this.chirublessing <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.chirublessing";
		this.m.Name = "";
		this.m.Icon = "ui/traits/aggressive_trait.png";
		this.m.Description = "";
		this.m.Type = this.Const.SkillType.Special | this.Const.SkillType.Trait;
		this.m.IsHidden = true;
	}
	
	function onUpdate( _properties )
	{
		_properties.MeleeSkill += 100;
		_properties.RangedSkill += 100;	
		_properties.Initiative += 100;		
		_properties.ActionPoints += 300;
		_properties.FatigueEffectMult *= 0.1;
		_properties.MeleeDamageMult *= 50;		
	}	
	
});

