this.cr_named_orc_sword_1h <- this.inherit("scripts/items/weapons/named/named_weapon", {
	m = {},
	function create()
	{
		this.named_weapon.create();
		this.m.ID = "weapon.cr_named_orc_sword_1h";
		this.m.NameList = this.Const.Strings.CleaverNames;
		this.m.UseRandomName = false;
		this.m.Description = "A huge one-handed blade with a rough, jagged edge. The Orcs use this for carving through fresh meat. Not well suited for human hands.";
		this.m.IconLarge = "weapons/melee/named_orc_1h_sword.png";
		this.m.Icon = "weapons/melee/named_orc_1h_sword_70x70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Sword;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.ItemType = this.Const.Items.ItemType.Named | this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.OneHanded;
		this.m.IsDoubleGrippable = true;
		this.m.IsAoE = false;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "cr_orc_1h_sword";
		this.m.Value = 3200;
		this.m.ShieldDamage = 32.0;
		this.m.Condition = 64.0;
		this.m.ConditionMax = 64.0;
		this.m.StaminaModifier = -18;
		this.m.RegularDamage = 50;
		this.m.RegularDamageMax = 65;
		this.m.ArmorDamageMult = 1.3;
		this.m.DirectDamageMult = 0.25;
		this.m.FatigueOnSkillUse = 5;
		this.randomizeValues();
	}

	function onEquip()
	{
		this.named_weapon.onEquip();
		local skill;
		skill = this.new("scripts/skills/actives/slash");
		this.addSkill(skill);
		skill = this.new("scripts/skills/actives/decapitate");
		this.addSkill(skill);
		skill = this.new("scripts/skills/actives/split_shield");
		skill.setApplyAxeMastery(true);
		this.addSkill(skill);
	}

});