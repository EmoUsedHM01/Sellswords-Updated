this.ssu_ranged_flail <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.ssu_ranged_flail";
		this.m.Name = ::Mod_Sellswords.Strings.ssu_ranged_flail.Name;
		this.m.Description = ::Mod_Sellswords.Strings.ssu_ranged_flail.Description;
		this.m.IconLarge = "weapons/melee/ssu_legend_flail_ranged_03.png";
		this.m.Icon = "weapons/melee/ssu_legend_flail_ranged_03_70x70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Flail;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded | this.Const.Items.ItemType.Cultist;
		this.m.ItemProperty = this.Const.Items.Property.IgnoresShieldwall;
		this.m.IsAgainstShields = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "ssu_icon_flail_ranged_03";
		this.m.Value = 2900;
		this.m.ShieldDamage = 0;
		this.m.Condition = 96.0;
		this.m.ConditionMax = 96.0;
		this.m.StaminaModifier = -16;
		this.m.RangeMin = 1;
		this.m.RangeMax = 2;
		this.m.RangeIdeal = 2;
		this.m.RegularDamage = 40;
		this.m.RegularDamageMax = 80;
		this.m.ArmorDamageMult = 1.1;
		this.m.DirectDamageMult = 0.3;
		this.m.ChanceToHitHead = 15;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.Flail, function ( _skill )
		{
			_skill.m.IsRanged = true;
		}.bindenv(this));
		::Legends.Actives.grant(this, ::Legends.Active.Lash, function ( _skill )
		{
			_skill.m.IsRanged = true;
		}.bindenv(this));
	}

	function onUpdateProperties( _properties )
	{
		this.weapon.onUpdateProperties(_properties);
	}

});

