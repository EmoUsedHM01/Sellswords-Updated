this.dryad_staff <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.dryad_staff";
		this.m.Name = "Dryad Staff";
		this.m.Description = "A sturdy staff, good for walking and whacking";
		this.m.IconLarge = "weapons/melee/dryad_staff.png";
		this.m.Icon = "weapons/melee/dryad_staff_70x70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Staff;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded | this.Const.Items.ItemType.Defensive;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_dryad_staff";
		this.m.Value = 50;
		this.m.ShieldDamage = 0;
		this.m.Condition = 40.0;
		this.m.ConditionMax = 40.0;
		this.m.StaminaModifier = -4;
		this.m.RangeMin = 1;
		this.m.RangeMax = 2;
		this.m.RangeIdeal = 2;
		this.m.RegularDamage = 20;
		this.m.RegularDamageMax = 30;
		this.m.ArmorDamageMult = 0.3;
		this.m.DirectDamageMult = 0.4;
		this.m.DirectDamageAdd = -0.1;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/legend_staff_bash"));
		this.addSkill(this.new("scripts/skills/actives/legend_staff_knock_out"));
	}

});

