this.ssu_spontoon02 <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.ssu_spontoon02";
		this.m.Name = ::Mod_Sellswords.Strings.ssu_spontoon02.Name;
		this.m.Description = ::Mod_Sellswords.Strings.ssu_spontoon02.Description;
		this.m.IconLarge = "weapons/melee/ssu_spontoon_02.png";
		this.m.Icon = "weapons/melee/ssu_spontoon_02_70x70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Spear;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.IsAoE = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "ssu_spontoon_02";
		this.m.Value = 1100;
		this.m.ShieldDamage = 0;
		this.m.Condition = 64.0;
		this.m.ConditionMax = 64.0;
		this.m.StaminaModifier = -14;
		this.m.RegularDamage = 60;
		this.m.RegularDamageMax = 75;
		this.m.ArmorDamageMult = 0.95;
		this.m.DirectDamageMult = 0.3;	
		this.m.ChanceToHitHead = 0;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		local thrust = this.new("scripts/skills/actives/thrust");
		thrust.m.Icon = "skills/ssu_spontoon_02_thrust.png";
		thrust.m.IconDisabled = "skills/ssu_spontoon_02_thrust_sw.png";
		thrust.m.Overlay = "ssu_spontoon_skill_18_01";
		thrust.setFatigueCost(15);
		thrust.m.DirectDamageMult = this.m.DirectDamageMult;		
		thrust.m.ActionPointCost = 6;
		thrust.m.spontoon = 1;				
		this.addSkill(thrust);
		this.addSkill(this.new("scripts/skills/actives/ssu_jab"));		
		local strike = this.new("scripts/skills/actives/ssu_strike");
		strike.m.Icon = "skills/ssu_spontoon_02_strike.png";
		strike.m.IconDisabled = "skills/ssu_spontoon_02_strike_sw.png";
		strike.m.Overlay = "ssu_spontoon_skill_18_02";
		this.addSkill(strike);		
	}

});

