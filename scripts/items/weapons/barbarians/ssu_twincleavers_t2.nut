this.ssu_twincleavers_t2 <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.ssu_twincleavers_t2";
		this.m.Name = ::Mod_Sellswords.Strings.ssu_twincleavers_t2.Name;
		this.m.Description = ::Mod_Sellswords.Strings.ssu_twincleavers_t2.Description;
		this.m.IconLarge = "weapons/melee/ssu_berserker_twincleavers.png";
		this.m.Icon = "weapons/melee/ssu_berserker_twincleavers_70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Cleaver;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "ssu_barbarian_twincleavers";
		this.m.Value = 2200;
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
	}

	function onEquip()
	{
		this.weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/ssu_twincleavers_1"));
		this.addSkill(this.new("scripts/skills/actives/ssu_twincleavers_2"));
	}

});