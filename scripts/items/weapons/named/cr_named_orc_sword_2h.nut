this.cr_named_orc_sword_2h <- this.inherit("scripts/items/weapons/named/named_weapon", {
	m = {
		StunChance = 15
	},
	function create()
	{
		this.named_weapon.create();
		this.m.ID = "weapon.cr_named_orc_sword_2h";
		this.m.NameList = this.Const.Strings.CleaverNames;
		this.m.UseRandomName = false;		
		this.m.Description = "A massive, crudely sharpened shard of metal that makes up for its stunted length through sheer weight. Too heavy to be used effectively by the average human.";
		this.m.IconLarge = "weapons/melee/orc_cleaver_2h.png";
		this.m.Icon = "weapons/melee/orc_cleaver_2h_70x70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Sword;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Named | this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.IsAoE = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "baliankandao";
		this.m.Value = 3200;
		this.m.ShieldDamage = 32;
		this.m.Condition = 64.0;
		this.m.ConditionMax = 64.0;
		this.m.StaminaModifier = -26;
		this.m.RegularDamage = 80;
		this.m.RegularDamageMax = 100;
		this.m.ArmorDamageMult = 1;
		this.m.DirectDamageMult = 0.25;			
		this.m.ChanceToHitHead = 10;
		this.m.FatigueOnSkillUse = 5;
		this.randomizeValues();
	}

	function onEquip()
	{
		this.named_weapon.onEquip();
		local skillToAdd = this.new("scripts/skills/actives/overhead_strike");
		skillToAdd.setStunChance(this.m.StunChance);
		this.addSkill(skillToAdd);		
		skillToAdd = this.new("scripts/skills/actives/slash");
		skillToAdd.m.isBunt = true;			
		skillToAdd.m.Name = "Bunt";		
		skillToAdd.m.Icon = "skills/active_bunt.png";
		skillToAdd.m.IconDisabled = "skills/active_bunt_sw.png";		
		skillToAdd.m.Overlay = "active_1";
		skillToAdd.m.FatigueCost = 13;	
		skillToAdd.m.DirectDamageMult = this.m.DirectDamageMult;		
		this.addSkill(skillToAdd);
		skillToAdd = this.new("scripts/skills/actives/split_shield");
		this.addSkill(skillToAdd);		
	}

});

