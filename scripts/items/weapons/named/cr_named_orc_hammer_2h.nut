this.cr_named_orc_hammer_2h <- this.inherit("scripts/items/weapons/named/named_weapon", {
	m = {},
	function create()
	{
		this.named_weapon.create();
		this.m.ID = "weapon.cr_named_orc_hammer_2h";
		this.m.NameList = this.Const.Strings.HammerNames;
		this.m.UseRandomName = false;		
		this.m.Description = "A massive crude hammer with a head fashioned from a chunk of solid iron. Too heavy to be used effectively by the average human.";
		this.m.IconLarge = "weapons/melee/named_orc_hammer_2h.png";
		this.m.Icon = "weapons/melee/named_orc_hammer_2h_70x70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Hammer;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Named | this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.IsAoE = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_legend_skullbreaker_01";
		this.m.Value = 3200;
		this.m.ShieldDamage = 38;
		this.m.Condition = 72.0;
		this.m.ConditionMax = 72.0;
		this.m.StaminaModifier = -38;
		this.m.RegularDamage = 70;
		this.m.RegularDamageMax = 110;
		this.m.ArmorDamageMult = 2.10;
		this.m.DirectDamageMult = 0.5;
		this.m.ChanceToHitHead = 0;
		this.m.FatigueOnSkillUse = 5;
		this.randomizeValues();
	}

	function onEquip()
	{
		this.named_weapon.onEquip();
		local skillToAdd = this.new("scripts/skills/actives/smite_skill");
		this.addSkill(skillToAdd);
		skillToAdd = this.new("scripts/skills/actives/shatter_skill");
		this.addSkill(skillToAdd);
		skillToAdd = this.new("scripts/skills/actives/split_shield");
		this.addSkill(skillToAdd);
	}

});

