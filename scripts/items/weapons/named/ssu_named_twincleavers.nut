this.ssu_named_twincleavers <- this.inherit("scripts/items/weapons/named/named_weapon", {
	m = {},
	function create()
	{
		this.named_weapon.create();
		this.updateVariant();
		this.m.ID = "weapon.ssu_named_twincleavers";
		this.m.Name = ::Mod_Sellswords.Strings.ssu_named_twincleavers.Name;
		this.m.Description = ::Mod_Sellswords.Strings.ssu_named_twincleavers.Description;
		this.m.Categories = ::Mod_Sellswords.Strings.ssu_named_twincleavers.Categories;
		this.m.IconLarge = "weapons/melee/ssu_double_cleaver_01.png";
		this.m.Icon = "weapons/melee/ssu_double_cleaver_01_70.png";
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Named | this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "ssu_doublecleaver_01";
		this.m.Value = 1600;
		this.m.ShieldDamage = 0;
		this.m.Condition = 92.0;
		this.m.ConditionMax = 92.0;
		this.m.StaminaModifier = -18;
		this.m.RegularDamage = 60;
		this.m.RegularDamageMax = 80;
		this.m.ArmorDamageMult = 1.1;
		this.m.DirectDamageAdd = 0.1;
		this.m.DirectDamageMult = 0.25;
		this.m.FatigueOnSkillUse = 2;
		this.randomizeValues();
	}

	function onEquip()
	{
		this.weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/ssu_twincleavers_1"));
		this.addSkill(this.new("scripts/skills/actives/ssu_twincleavers_2"));
	}

});