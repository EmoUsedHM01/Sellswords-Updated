this.dryad_staff <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.dryad_staff";
		this.m.Name = "Dryad Staff";
		this.m.Description = "A sturdy staff crafted by Dryads from their sacred Heartwood. When exposed to blood, the mystical properties of these staves reveal themselves.";
		this.m.IconLarge = "weapons/melee/dryad_staff.png";
		this.m.Icon = "weapons/melee/dryad_staff_70x70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Staff | this.Const.Items.WeaponType.MagicStaff;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded | this.Const.Items.ItemType.Defensive;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_dryad_staff";
		this.m.Value = 1050;
		this.m.ShieldDamage = 0;
		this.m.Condition = 60.0;
		this.m.ConditionMax = 60.0;
		this.m.StaminaModifier = -6;
		this.m.RangeMin = 1;
		this.m.RangeMax = 2;
		this.m.RangeIdeal = 2;
		this.m.RegularDamage = 35;
		this.m.RegularDamageMax = 50;
		this.m.ArmorDamageMult = 0.3;
		this.m.DirectDamageMult = 0.95;
	}

	function getTooltip()
	{
		local result = this.weapon.getTooltip();
		result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Slowly repairs [color=" + this.Const.UI.Color.PositiveValue + "]5[/color] durability each turn."
		});
		return result;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/legend_staff_bash"));
		this.addSkill(this.new("scripts/skills/actives/legend_staff_knock_out"));
		this.addSkill(this.new("scripts/skills/actives/crstaff_sweep"));
	}

	function onUpdateProperties( _properties )
	{
		this.weapon.onUpdateProperties(_properties);
	}

	function onTurnStart()
	{
		this.m.Condition = this.Math.minf(this.m.ConditionMax, this.m.Condition + 5.0);
	}

});