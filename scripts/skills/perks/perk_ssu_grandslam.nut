this.perk_ssu_grandslam <- this.inherit("scripts/skills/skill", {
	m = {
	},
	function create()
	{
		this.m.ID = "perk.ssu_grandslam";
		this.m.Name = this.Const.Strings.PerkName.SsuGrandslam;
		this.m.Description = this.Const.Strings.PerkDescription.SsuGrandslam;
		this.m.Icon = "ui/perks/ssu_grandslam.png";
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
		_properties.MeleeDefense -= (0.08 * bodyHealth);
		_properties.RangedDefense -= (0.08 * bodyHealth);
		_properties.Initiative -= (0.08 * bodyHealth);
		
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
