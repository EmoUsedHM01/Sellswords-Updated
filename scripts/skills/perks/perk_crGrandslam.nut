this.perk_crGrandslam <- this.inherit("scripts/skills/skill", {
	m = {
	},
	function create()
	{
		this.m.ID = "perk.crGrandslam";
		this.m.Name = "Grand Slam";
		this.m.Description = this.Const.Strings.PerkDescription.crGrandslam;
		this.m.Icon = "ui/perks/crGrandslam.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}
	
	function onAfterUpdate( _properties )
	{
		local bodyHealth = this.getContainer().getActor().getHitpoints();
		bodyHealth = this.Math.min(150, bodyHealth);
		//_properties.MeleeSkill -= (0.08 * bodyHealth);
		//_properties.RangedSkill -= (0.08 * bodyHealth);
		_properties.MeleeDefense -= (0.08 * bodyHealth);
		_properties.RangedDefense -= (0.08 * bodyHealth);
		_properties.Initiative -= (0.08 * bodyHealth);
		//_properties.TargetAttractionMult *= 1.5;
		
		local skills = this.getContainer().getAllSkillsOfType(this.Const.SkillType.Active);
		local weapon = this.getContainer().getActor().getMainhandItem();
		local throwing = (weapon != null && weapon.isWeaponType(this.Const.Items.WeaponType.Throwing)) ? true: false;
		local polearm = (weapon != null && weapon.isItemType(this.Const.Items.ItemType.MeleeWeapon)) ? true: false;
		foreach (s in skills)
		{
			if (s.isAttack() && (!s.isRanged() || throwing || polearm))
			{
				s.m.ActionPointCost += 1;
				s.m.FatigueCost += this.Math.ceil(0.04 * bodyHealth);
			}		
		}
	}
	
});
