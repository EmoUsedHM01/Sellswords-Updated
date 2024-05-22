this.spontoon02 <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.spontoon02";
		this.m.Name = "Spontoon";
		this.m.Description = "A pair of blades or lugs on each side, giving the weapon the look of a military fork. Can be used for striking and blocking, while its suitable length is designed to concentrate the force of a punch and thrust at enemies.";
		this.m.IconLarge = "weapons/melee/jin_weapon_18.png";
		this.m.Icon = "weapons/melee/jin_weapon_18_70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Spear;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.IsAgainstShields = true;
		this.m.IsAoE = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "jin_weapon_18";
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
		thrust.m.Icon = "skills/jinweapon18_01.png";
		thrust.m.IconDisabled = "skills/jinweapon18_01_sw.png";
		thrust.m.Overlay = "jinweapon18_01";
		thrust.setFatigueCost(15);
		thrust.m.DirectDamageMult = this.m.DirectDamageMult;		
		thrust.m.ActionPointCost = 6;
		thrust.m.spontoon = 1;				
		this.addSkill(thrust);
		this.addSkill(this.new("scripts/skills/actives/jab"));		
		local strike = this.new("scripts/skills/actives/crstrike");
		strike.m.Icon = "skills/jinweapon18_02.png";
		strike.m.IconDisabled = "skills/jinweapon18_02_sw.png";
		strike.m.Overlay = "jinweapon18_02";
		this.addSkill(strike);		
	}

});

