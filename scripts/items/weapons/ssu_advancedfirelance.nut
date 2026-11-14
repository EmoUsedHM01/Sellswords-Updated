this.ssu_advancedfirelance <- this.inherit("scripts/items/weapons/weapon", {
	m = {
		IsLoaded = true
	},
	function isLoaded()
	{
		return this.m.IsLoaded;
	}

	function setLoaded( _l )
	{
		this.m.IsLoaded = _l;
	}
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.ssu_advancedfirelance";
		this.m.Name = ::Mod_Sellswords.Strings.ssu_advancedfirelance.Name1;
		this.m.Description = ::Mod_Sellswords.Strings.ssu_advancedfirelance.Description;
		this.m.IconLarge = "weapons/ranged/ssu_firelance.png";
		this.m.Icon = "weapons/ranged/ssu_firelance_70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Spear | this.Const.Items.WeaponType.Firearm;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.Ammo | this.Const.Items.ItemType.TwoHanded;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.IsDroppedAsLoot = true;
		this.m.AddGenericSkill = true;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "ssu_icon_firelance_01_empty";
		this.m.Value = 2050;
		this.m.Ammo = 3;
		this.m.AmmoMax = 3;
		this.m.AmmoCost = 4;
		this.m.RangeMin = 1;
		this.m.RangeMax = 1;
		this.m.RangeIdeal = 1;
		this.m.RangeMaxBonus = 0;
		this.m.Condition = 30.0;
		this.m.ConditionMax = 30.0;
		this.m.StaminaModifier = -15;
		this.m.RegularDamage = 30;
		this.m.RegularDamageMax = 40;
		this.m.ArmorDamageMult = 1.2;
		this.m.DirectDamageMult = 0.35;
		this.m.ShieldDamage = 0;
		this.m.ChanceToHitHead = 0;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/thrust"));
		this.addSkill(this.new("scripts/skills/actives/ssu_jab"));
		this.addSkill(this.new("scripts/skills/actives/ignite_firelance_skill"));
	}

	function setAmmo( _a )
	{
		this.weapon.setAmmo(_a);

		if (this.m.Ammo > 0)
		{
			this.m.Name = ::Mod_Sellswords.Strings.ssu_advancedfirelance.Name1;
			this.m.IconLarge = "weapons/ranged/ssu_firelance.png";
			this.m.Icon = "weapons/ranged/ssu_firelance_70.png";
			this.m.ArmamentIcon = "ssu_icon_firelance_01_empty";
		}
		else
		{
			this.m.Name = ::Mod_Sellswords.Strings.ssu_advancedfirelance.Name2;
			this.m.IconLarge = "weapons/ranged/ssu_firelance.png";
			this.m.Icon = "weapons/ranged/ssu_firelance_70.png";
			this.m.ArmamentIcon = "ssu_icon_firelance_01_loaded";
		}

		this.updateAppearance();
	}

});

