this.named_spontoon <- this.inherit("scripts/items/weapons/named/named_weapon", {
	m = {},
	function create()
	{
		this.named_weapon.create();
		this.m.ID = "weapon.named_spontoon";
		this.m.NameList = this.Const.Strings.SpetumNames;
		this.m.Description = "Some spontoon-style axes which used the same shaped blades mounted on the side of the weapon with a shorter handle, it's a huge and heavy battle spear with amazing power.";
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
			this.m.IconLarge = "weapons/melee/named_jin_weapon_02.png";
			this.m.Icon = "weapons/melee/named_jin_weapon_02_70.png";
			this.m.ArmamentIcon = "named_jin_weapon_02";
		}
		else
		{
			this.m.IconLarge = "weapons/melee/named_jin_weapon_18.png";
			this.m.Icon = "weapons/melee/named_jin_weapon_18_70.png";
			this.m.ArmamentIcon = "named_jin_weapon_18";		
		}
	}

	function onEquip()
	{
		this.named_weapon.onEquip();
		local thrust = this.new("scripts/skills/actives/thrust");
		thrust.m.Icon = "skills/jinweapon02_01.png";
		thrust.m.IconDisabled = "skills/jinweapon02_01_sw.png";
		thrust.m.Overlay = "jinweapon02_01";
		thrust.setFatigueCost(15);
		thrust.m.DirectDamageMult = this.m.DirectDamageMult;		
		thrust.m.ActionPointCost = 6;
		thrust.m.spontoon = 1;				
		this.addSkill(thrust);
		local jab = this.new("scripts/skills/actives/jab");
		jab.m.Icon = "skills/jinweapon19_01.png";
		jab.m.IconDisabled = "skills/jinweapon19_01_sw.png";
		jab.m.Overlay = "jinweapon19_01";				
		this.addSkill(jab);	
		local crstrike = this.new("scripts/skills/actives/crstrike");
		crstrike.m.Icon = "skills/jinweapon02_02.png";
		crstrike.m.IconDisabled = "skills/jinweapon02_02_sw.png";
		crstrike.m.Overlay = "jinweapon02_02";				
		this.addSkill(crstrike);			
	}

});

