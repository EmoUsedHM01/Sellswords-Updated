this.named_sword_abt_herbstnebel <- this.inherit("scripts/items/weapons/weapon", {
	m = {
	innateperk = false
	},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.named_sword_abt_herbstnebel";
		this.m.Name = "Herbstnebel, the Autumn Mist";
		this.m.Description = "A masterfully crafted glaive that feels surprisingly light, yet sturdy.";
		this.m.Categories = "Sword/Spear, Two-Handed";
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.IsDoubleGrippable = false;		
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.OneHanded | this.Const.Items.ItemType.Defensive;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.Value = 15000;
		this.m.Condition = 72.0;
		this.m.ConditionMax = 72.0;
		this.m.StaminaModifier = -10;
		this.m.RegularDamage = 65;
		this.m.RegularDamageMax = 70;
		this.m.ArmorDamageMult = 1.15;
		this.m.DirectDamageMult = 0.25;
		this.m.DirectDamageAdd = 0.1;	
		this.m.IconLarge = "weapons/melee/legend_glaive_01_named_01.png";
		this.m.Icon = "weapons/melee/legend_glaive_01_named_01_70x70.png";		
		this.m.ArmamentIcon = "icon_legend_named_glaive_01";		
	}

	function getTooltip()
	{
		local result = this.weapon.getTooltip();
		result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Unlocks 3 stances which can be switched to during combat: \'Half-swording\' , \'Meisterhau\' and \'Reverse-grip\'"
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
		this.addSkill(this.new("scripts/skills/actives/legend_glaive_slash"));
		this.addSkill(this.new("scripts/skills/actives/swing"));	
		this.addSkill(this.new("scripts/skills/actives/spearwall"));
		if (!::Is_PTR_Exist || this.m.innateperk) return;			
		local skill = ::new("scripts/skills/perks/perk_ptr_swordmaster_versatile_swordsman");
		skill.m.IsSerialized = false;
		this.addSkill(skill);		
	}

});

