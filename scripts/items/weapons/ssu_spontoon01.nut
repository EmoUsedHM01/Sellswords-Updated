this.ssu_spontoon01 <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.ssu_spontoon01";
		this.m.Name = ::Mod_Sellswords.Strings.ssu_spontoon01.Name;
		this.m.Description = ::Mod_Sellswords.Strings.ssu_spontoon01.Description;
		this.m.IconLarge = "weapons/melee/ssu_spontoon_01.png";
		this.m.Icon = "weapons/melee/ssu_spontoon_01_70x70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Spear;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.IsAoE = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "ssu_spontoon_01";
		this.m.Value = 550;
		this.m.ShieldDamage = 0;
		this.m.Condition = 54.0;
		this.m.ConditionMax = 54.0;
		this.m.StaminaModifier = -12;
		this.m.RegularDamage = 45;
		this.m.RegularDamageMax = 60;
		this.m.ArmorDamageMult = 0.8;
		this.m.DirectDamageMult = 0.3;		
		this.m.ChanceToHitHead = 0;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		local thrust = this.new("scripts/skills/actives/thrust");
		thrust.m.Icon = "skills/ssu_spontoon_01_thrust.png";
		thrust.m.IconDisabled = "skills/ssu_spontoon_01_thrust_sw.png";
		thrust.m.Overlay = "ssu_spontoon_thrust_01";
		thrust.setFatigueCost(15);
		thrust.m.DirectDamageMult = this.m.DirectDamageMult;		
		thrust.m.ActionPointCost = 6;
		thrust.m.spontoon = 1;				
		this.addSkill(thrust);
		this.addSkill(this.new("scripts/skills/actives/ssu_jab"));	
	}

});

