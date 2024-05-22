this.named_sword_abt_guinevere <- this.inherit("scripts/items/weapons/weapon", {
	m = {
	innateperk = false
	},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.named_sword_abt_guinevere";
		this.m.Name = "Guinevere, the Sword in the Lake";
		this.m.Description = "A masterfully crafted and somewhat uncommon variant of the sword with a long and thin blade, sharpened only on one side, and no crossguard. Can be used both for quick slashes and sweeping strikes.";
		this.m.WeaponType = this.Const.Items.WeaponType.Sword;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.IsAgainstShields = false;
		this.m.IsAoE = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.Value = 15000;
		this.m.ShieldDamage = 0;
		this.m.Condition = 64.0;
		this.m.ConditionMax = 64.0;
		this.m.StaminaModifier = -8;
		this.m.RegularDamage = 60;
		this.m.RegularDamageMax = 85;
		this.m.ArmorDamageMult = 0.75;
		this.m.DirectDamageMult = 0.2;
		this.m.DirectDamageAdd = 0.25;			
		this.m.ChanceToHitHead = 10;		
		this.m.IconLarge = "weapons/melee/military_scythe_named_02.png";
		this.m.Icon = "weapons/melee/military_scythe_named_02_70x70.png";
		this.m.ArmamentIcon = "icon_named_warbrand_02";		
	}

	function getTooltip()
	{
		local result = this.weapon.getTooltip();
		result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "\'Split\' and \'Swing\' cost less Action Points and Fatigue"
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
		slash.m.FatigueCost = 13;
		this.addSkill(slash);
		local split = this.new("scripts/skills/actives/split");
		split.m.FatigueCost = 25;
		local swing = this.new("scripts/skills/actives/swing");
		swing.m.FatigueCost = 25;
		
		if (!this.m.innateperk)
		{
			split.m.ActionPointCost = 4;	
			swing.m.ActionPointCost = 4;
			split.m.FatigueCost = 20;			
			swing.m.FatigueCost = 20;			
		}		
		this.addSkill(split);		
		this.addSkill(swing);					
	}
	

});

