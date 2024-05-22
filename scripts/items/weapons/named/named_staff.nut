this.named_staff <- this.inherit("scripts/items/weapons/named/named_weapon", {
	m = {},
	function create()
	{
		this.named_weapon.create();
		this.m.IconLarge = "weapons/melee/cr_staff_01.png";
		this.m.Icon = "weapons/melee/cr_staff_01_70x70.png";
		this.m.ID = "weapon.named_staff";
		this.m.Name = "Grimwar's Staff";
		this.m.Description = "A sturdy staff with a crystal ball on its tip, it catches the light in mysterious ways.";
		this.m.IconLarge = "weapons/melee/cr_staff_01.png";
		this.m.Icon = "weapons/melee/cr_staff_01_70x70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Staff | this.Const.Items.WeaponType.MagicStaff;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Named | this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded | this.Const.Items.ItemType.Defensive;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_cr_staff_01";
		this.m.Value = 6666;
		this.m.ShieldDamage = 0;
		this.m.Condition = 120.0;
		this.m.ConditionMax = 120.0;
		this.m.StaminaModifier = -6;
		this.m.RangeMin = 1;
		this.m.RangeMax = 2;
		this.m.RangeIdeal = 2;
		this.m.RegularDamage = 35;
		this.m.RegularDamageMax = 40;
		this.m.ArmorDamageMult = 0.3;
		this.m.DirectDamageMult = 0.95;
		this.randomizeValues();		
	}

	function onEquip()
	{
		this.named_weapon.onEquip();
		local s = this.new("scripts/skills/actives/legend_staff_bash");
		s.m.Icon = "skills/staff_bash_mystic.png";
		s.m.IconDisabled = "skills/staff_bash_mystic_bw.png";
		this.addSkill(s);
		local t = this.new("scripts/skills/actives/legend_staff_knock_out");
		t.m.Icon = "skills/staff_knock_out_mystic.png";
		t.m.IconDisabled = "skills/staff_knock_out_mystic_bw.png";
		this.addSkill(t);
	}

});

