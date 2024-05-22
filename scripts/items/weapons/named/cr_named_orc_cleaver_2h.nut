this.cr_named_orc_cleaver_2h <- this.inherit("scripts/items/weapons/named/named_weapon", {
	m = {},
	function create()
	{
		this.named_weapon.create();
		this.m.ID = "weapon.cr_named_orc_cleaver_2h";
		this.m.NameList = this.Const.Strings.CleaverNames;
		this.m.UseRandomName = false;		
		this.m.Description = "A colossal cleaving weapon made of several overlapping crude blades wedged into a tree limb. Too heavy to be used effectively by the average human.";
		this.m.IconLarge = "weapons/melee/named_orc_cleaver_2h.png";
		this.m.Icon = "weapons/melee/named_orc_cleaver_2h_70x70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Cleaver;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Named | this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.IsAoE = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "niutouguaikandao";
		this.m.Value = 3200;
		this.m.ShieldDamage = 32.0;
		this.m.Condition = 64.0;
		this.m.ConditionMax = 64.0;
		this.m.StaminaModifier = -28;
		this.m.RegularDamage = 70;
		this.m.RegularDamageMax = 100;
		this.m.ArmorDamageMult = 1.3;
		this.m.DirectDamageMult = 0.25;
		this.m.FatigueOnSkillUse = 5;
		this.randomizeValues();
	}

	function onEquip()
	{
		this.named_weapon.onEquip();
		local skill;
		skill = this.new("scripts/skills/actives/cleave");
		skill.m.FatigueCost = 15;		
		this.addSkill(skill);
		skill = this.new("scripts/skills/actives/decapitate");
		this.addSkill(skill);
		skill = this.new("scripts/skills/actives/split_shield");
		skill.setApplyAxeMastery(true);
		this.addSkill(skill);
	}

});

