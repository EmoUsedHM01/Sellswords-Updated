this.named_sword_abt_zhanlu <- this.inherit("scripts/items/weapons/weapon", {
	m = {
	innateperk = false
	},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.named_sword_abt_zhanlu";
		this.m.Name = "Zhanlu, the Deep Black";
		this.m.Description = "A well-balanced long sword with a double-edged blade. A weapon crafted as well as this one is hard to find.";
		this.m.Categories = "Sword, One-Handed";
		this.m.IconLarge = "weapons/melee/sword_03_named_03.png";
		this.m.Icon = "weapons/melee/sword_03_named_03_70x70.png";
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.OneHanded;
		this.m.IsDoubleGrippable = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_named_sword_03";
		this.m.Condition = 72.0;
		this.m.ConditionMax = 72.0;
		this.m.StaminaModifier = -8;
		this.m.Value = 15000;
		this.m.RegularDamage = 60;
		this.m.RegularDamageMax = 65;
		this.m.ArmorDamageMult = 1.15;
		this.m.DirectDamageMult = 0.2;
	}

	function getTooltip()
	{
		local result = this.weapon.getTooltip();
		result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "The Action Point costs of sword skills is reduced by [color=" + this.Const.UI.Color.PositiveValue + "]1[/color] as well as \'Kata Step\'"
		});
		if (this.m.innateperk)
		{
			result.push({
				id = 6,
				type = "text",
				icon = "ui/icons/warning.png",
				text = "Even the most distinguished people can only master one skill"
			});
		}		
		return result;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		this.m.innateperk = false;			
		local skills = this.getContainer().getActor().getSkills().getAllSkillsOfType(this.Const.SkillType.Perk);
		foreach (s in skills)
		{
			if (s.getID().find("ptr_swordmaster_"))
			{
				this.m.innateperk = true;
			}		
		}

		local slash = this.new("scripts/skills/actives/slash");
		local riposte = this.new("scripts/skills/actives/riposte");		
		//if (!this.m.innateperk)
		//{
		//	slash.m.ActionPointCost = 3;	
		//	riposte.m.ActionPointCost = 3;
		//}
		this.addSkill(slash);		
		this.addSkill(riposte);
		
		if (!::Is_PTR_Exist || this.m.innateperk) return;			
		local skill = ::new("scripts/skills/perks/perk_ptr_swordmaster_blade_dancer");
		skill.m.IsSerialized = false;
		this.addSkill(skill);			
	}	
});

