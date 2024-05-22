this.advancedfirelance <- this.inherit("scripts/items/weapons/weapon", {
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
		this.m.ID = "weapon.advancedfirelance";
		this.m.Name = "Advanced Fire Lance";
		this.m.Description = "An experimental two-handed spear of southern design with multiple explosive charges that will spew fire over two tiles when ignited. This more advanced design can be used up to 3 times per battle and is automatically refilled after.";
		this.m.IconLarge = "weapons/ranged/huomao.png";
		this.m.Icon = "weapons/ranged/huomao_70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Spear | this.Const.Items.WeaponType.Firearm;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.Ammo | this.Const.Items.ItemType.TwoHanded;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.IsDroppedAsLoot = true;
		this.m.AddGenericSkill = true;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_huomao_01_empty";
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
		this.addSkill(this.new("scripts/skills/actives/jab"));
		this.addSkill(this.new("scripts/skills/actives/ignite_firelance_skill"));
	}

	function setAmmo( _a )
	{
		this.weapon.setAmmo(_a);

		if (this.m.Ammo > 0)
		{
			this.m.Name = "Advanced Fire Lance";
			this.m.IconLarge = "weapons/ranged/huomao.png";
			this.m.Icon = "weapons/ranged/huomao_70.png";
			this.m.ArmamentIcon = "icon_huomao_01_empty";
		}
		else
		{
			this.m.Name = "Advanced Fire Lance (Spent)";
			this.m.IconLarge = "weapons/ranged/huomao.png";
			this.m.Icon = "weapons/ranged/huomao_70.png";
			this.m.ArmamentIcon = "icon_huomao_01_loaded";
		}

		this.updateAppearance();
	}

});

