this.spontoon03 <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.spontoon03";
		this.m.Name = "Heavy Halberd";
		this.m.Description = "A half-pike featured a more elaborate head than the typical pike. Can be used to thrust at the enemy, or pummel them into submission.";
		this.m.IconLarge = "weapons/melee/jin_weapon_12.png";
		this.m.Icon = "weapons/melee/jin_weapon_12_70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Spear;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.IsAgainstShields = true;
		this.m.IsAoE = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "jin_weapon_12";
		this.m.Value = 2600;
		this.m.ShieldDamage = 0;
		this.m.Condition = 72.0;
		this.m.ConditionMax = 72.0;
		this.m.StaminaModifier = -16;
		this.m.RegularDamage = 75;
		this.m.RegularDamageMax = 90;
		this.m.ArmorDamageMult = 1.1;
		this.m.DirectDamageMult = 0.3;		
		this.m.ChanceToHitHead = 0;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		local thrust = this.new("scripts/skills/actives/thrust");
		thrust.m.Icon = "skills/jinweapon12_01.png";
		thrust.m.IconDisabled = "skills/jinweapon12_01_sw.png";
		thrust.m.Overlay = "jinweapon12_01";
		thrust.setFatigueCost(15);
		thrust.m.DirectDamageMult = this.m.DirectDamageMult;		
		thrust.m.ActionPointCost = 6;
		thrust.m.spontoon = 1;				
		this.addSkill(thrust);
		this.addSkill(this.new("scripts/skills/actives/jab"));		
		this.addSkill(this.new("scripts/skills/actives/crstrike"));			
	}

});

