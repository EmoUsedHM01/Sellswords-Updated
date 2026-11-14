this.ssu_twincleavers_t1 <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.ssu_twincleavers_t1";
		this.m.Name = ::Mod_Sellswords.Strings.ssu_twincleavers_t1.Name;
		this.m.Description = ::Mod_Sellswords.Strings.ssu_twincleavers_t1.Description;
		this.m.Categories = ::Mod_Sellswords.Strings.ssu_twincleavers_t1.Categories;
		this.m.IconLarge = "weapons/melee/ssu_berserker_twincleavers_02.png";
		this.m.Icon = "weapons/melee/ssu_berserker_twincleavers_02_70.png";
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "ssu_barbarian_twincleavers02";
		this.m.Value = 1200;
		this.m.ShieldDamage = 0;
		this.m.Condition = 80.0;
		this.m.ConditionMax = 80.0;
		this.m.StaminaModifier = -16;
		this.m.RegularDamage = 45;
		this.m.RegularDamageMax = 60;
		this.m.ArmorDamageMult = 0.9;
		this.m.DirectDamageMult = 0.25;
		this.m.DirectDamageAdd = 0.1;
		this.m.ChanceToHitHead = 0;
		this.m.FatigueOnSkillUse = 1;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/ssu_twincleavers_1"));
		this.addSkill(this.new("scripts/skills/actives/ssu_twincleavers_2"));
	}

});