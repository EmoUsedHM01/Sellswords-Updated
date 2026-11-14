this.ssu_named_spontoon <- this.inherit("scripts/items/weapons/named/named_weapon", {
	m = {},
	function create()
	{
		this.named_weapon.create();
		this.m.ID = "weapon.ssu_named_spontoon";
		this.m.NameList = this.Const.Strings.SpetumNames;
		this.m.Description = ::Mod_Sellswords.Strings.ssu_named_spontoon.Description;
		this.m.Variants = [
			1,
			2
		];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.WeaponType = this.Const.Items.WeaponType.Spear;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Named | this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.IsAoE = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.Value = 4200;
		this.m.ShieldDamage = 0;
		this.m.Condition = 72.0;
		this.m.ConditionMax = 72.0;
		this.m.StaminaModifier = -16;
		this.m.RegularDamage = 75;
		this.m.RegularDamageMax = 90;
		this.m.ArmorDamageMult = 1.1;
		this.m.DirectDamageMult = 0.3;
		this.m.ChanceToHitHead = 0;
		this.randomizeValues();
	}

	function updateVariant()
	{
		if (this.m.Variant == 1)
		{
			this.m.IconLarge = "weapons/melee/ssu_named_spontoon_01.png";
			this.m.Icon = "weapons/melee/ssu_named_spontoon_01_70x70.png";
			this.m.ArmamentIcon = "ssu_named_spontoon_01";
		}
		else
		{
			this.m.IconLarge = "weapons/melee/ssu_named_spontoon_02.png";
			this.m.Icon = "weapons/melee/ssu_named_spontoon_02_70x70.png";
			this.m.ArmamentIcon = "ssu_named_spontoon_02";
		}
	}

	function onEquip()
	{
		this.named_weapon.onEquip();
		local thrust = this.new("scripts/skills/actives/thrust");
		thrust.m.Icon = "skills/ssu_named_spontoon_thrust.png";
		thrust.m.IconDisabled = "skills/ssu_named_spontoon_thrust_sw.png";
		thrust.m.Overlay = "ssu_spontoon_skill_02_01";
		thrust.setFatigueCost(15);
		thrust.m.DirectDamageMult = this.m.DirectDamageMult;
		thrust.m.ActionPointCost = 6;
		thrust.m.spontoon = 1;
		this.addSkill(thrust);
		local jab = this.new("scripts/skills/actives/ssu_jab");
		jab.m.Icon = "skills/ssu_named_spontoon_jab.png";
		jab.m.IconDisabled = "skills/ssu_named_spontoon_jab_sw.png";
		jab.m.Overlay = "ssu_spontoon_skill_19_01";
		this.addSkill(jab);	
		local crstrike = this.new("scripts/skills/actives/ssu_strike");
		crstrike.m.Icon = "skills/ssu_named_spontoon_strike.png";
		crstrike.m.IconDisabled = "skills/ssu_named_spontoon_strike_sw.png";
		crstrike.m.Overlay = "ssu_spontoon_skill_02_02";
		this.addSkill(crstrike);
	}

});