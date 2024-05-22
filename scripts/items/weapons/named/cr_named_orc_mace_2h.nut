this.cr_named_orc_mace_2h <- this.inherit("scripts/items/weapons/named/named_weapon", {
	m = {},
	function create()
	{
		this.named_weapon.create();
		this.m.ID = "weapon.cr_named_orc_mace_2h";
		this.m.NameList = this.Const.Strings.TwoHandedMaceNames;
		this.m.UseRandomName = false;		
		this.m.Description = "Almost a whole bronze statue uprooted, haphazardly reinforced with protruding iron rivets. Too heavy to be used effectively by the average human.";
		this.m.IconLarge = "weapons/melee/orc_named_mace_2h.png";
		this.m.Icon = "weapons/melee/orc_named_mace_2h_70x70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Mace;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Named | this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.IsAoE = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_orc_named_mace";
		this.m.Value = 3200;
		this.m.ShieldDamage = 38;
		this.m.Condition = 84.0;
		this.m.ConditionMax = 84.0;
		this.m.StaminaModifier = -32;
		this.m.RegularDamage = 85;
		this.m.RegularDamageMax = 115;
		this.m.ArmorDamageMult = 1.35;
		this.m.DirectDamageMult = 0.5;
		this.m.ChanceToHitHead = 0;
		this.m.FatigueOnSkillUse = 5;
		this.randomizeValues();
	}

	function onEquip()
	{
		this.named_weapon.onEquip();
		local skill;
		skill = this.new("scripts/skills/actives/cudgel_skill");
		this.addSkill(skill);
		skill = this.new("scripts/skills/actives/strike_down_skill");
		this.addSkill(skill);
		skill = this.new("scripts/skills/actives/split_shield");
		skill.setFatigueCost(skill.getFatigueCostRaw() + 5);
		this.addSkill(skill);
	}

});

