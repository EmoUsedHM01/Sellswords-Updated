this.perk_crrangedskill <- this.inherit("scripts/skills/skill", {
	m = {
		HitchanceConverted = 0	
	},
	function create()
	{
		this.m.ID = "perk.crrangedskill";
		this.m.Name = this.Const.Strings.PerkName.crrangedskill;
		this.m.Description = this.Const.Strings.PerkDescription.crrangedskill;
		this.m.Icon = "ui/perks/crrangedskill.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}
	
	function onGetHitFactors( _skill, _targetTile, _tooltip )
	{
		if (!_skill.isAttack() || !_skill.isRanged() || !_skill.isUsingHitchance())		
		{
			return;
		}		
		_tooltip.push({
			icon = "ui/tooltips/positive.png",
			text = "Ace of Aces"
		});			
	}	
});

