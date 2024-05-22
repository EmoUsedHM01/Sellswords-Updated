this.spontoon01 <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.spontoon01";
		this.m.Name = "Short Spear";
		this.m.Description = "A simple pike with a short shaft. Can be used for striking and blocking, while its suitable length is designed to concentrate the force of a punch and thrust at enemies.";
		this.m.IconLarge = "weapons/melee/changji.png";
		this.m.Icon = "weapons/melee/changji_70x70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Spear;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.IsAgainstShields = true;
		this.m.IsAoE = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "weapon_changji";
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
		thrust.m.Icon = "skills/changji_01.png";
		thrust.m.IconDisabled = "skills/changji_01_sw.png";
		thrust.m.Overlay = "changji_01";
		thrust.setFatigueCost(15);
		thrust.m.DirectDamageMult = this.m.DirectDamageMult;		
		thrust.m.ActionPointCost = 6;
		thrust.m.spontoon = 1;				
		this.addSkill(thrust);
		this.addSkill(this.new("scripts/skills/actives/jab"));	
	}

});

