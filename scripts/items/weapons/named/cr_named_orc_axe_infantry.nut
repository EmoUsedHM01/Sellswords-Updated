this.cr_named_orc_axe_infantry <- this.inherit("scripts/items/weapons/named/named_weapon", {
	m = {},
	function create()
	{
		this.named_weapon.create();
		this.m.ID = "weapon.cr_named_orc_axe_infantry";
		this.m.NameList = this.Const.Strings.CleaverNames;
		this.m.UseRandomName = false;		
		this.m.Description = "A long shard of sharpened rock firmly wedged into a massive bone. Not well suited for human hands.";
		this.m.IconLarge = "weapons/melee/orc_axe_named_04.png";
		this.m.Icon = "weapons/melee/orc_axe_named_04_70x70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Axe;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.ItemType = this.Const.Items.ItemType.Named | this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.OneHanded;
		this.m.IsDoubleGrippable = true;		
		this.m.IsAoE = false;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "daqiuzhangdafu";
		this.m.Value = 3000;
		this.m.ShieldDamage = 32;
		this.m.Condition = 68.0;
		this.m.ConditionMax = 68.0;
		this.m.StaminaModifier = -18;
		this.m.RegularDamage = 45;
		this.m.RegularDamageMax = 65;
		this.m.ArmorDamageMult = 1.2;
		this.m.DirectDamageMult = 0.35;
		this.m.ChanceToHitHead = 0;
		this.m.FatigueOnSkillUse = 5;
		this.randomizeValues();
	}

	function onEquip()
	{
		this.named_weapon.onEquip();
		local skill;
		skill = this.new("scripts/skills/actives/split_man");
		skill.m.DirectDamageMult = this.m.DirectDamageMult;		
		skill.m.ActionPointCost = 5;
		skill.m.orc = true;
		skill.m.infantry = 1;
		this.addSkill(skill);
		skill = this.new("scripts/skills/actives/chop");
		skill.m.DirectDamageMult = this.m.DirectDamageMult;	
		skill.m.infantry = true;			
		skill.m.orc = true;
		this.addSkill(skill);		
		skill = this.new("scripts/skills/actives/split_shield");
		skill.m.ActionPointCost = 6;		
		skill.setApplyAxeMastery(true);
		this.addSkill(skill);
	}
	
	function onUpdateProperties( _properties )
	{
		this.weapon.onUpdateProperties(_properties);
	}	

});

