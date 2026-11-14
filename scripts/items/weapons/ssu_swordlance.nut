this.ssu_swordlance <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.ssu_swordlance";
		this.m.Name = ::Mod_Sellswords.Strings.ssu_swordlance.Name;
		this.m.Description = ::Mod_Sellswords.Strings.ssu_swordlance.Description;
		this.m.Categories = ::Mod_Sellswords.Strings.ssu_swordlance.Categories;
		this.m.IconLarge = "weapons/melee/ssu_swordlance_03.png";
		this.m.Icon = "weapons/melee/ssu_swordlance_03_70x70.png";
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.IsAoE = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "ssu_swordlance";
		this.m.Value = 3000;
		this.m.ShieldDamage = 0;
		this.m.Condition = 96.0;
		this.m.ConditionMax = 96.0;
		this.m.StaminaModifier = -16;
		this.m.RangeMin = 1;
		this.m.RangeMax = 2;
		this.m.RangeIdeal = 2;
		this.m.RegularDamage = 65;
		this.m.RegularDamageMax = 90;
		this.m.ArmorDamageMult = 1;
		this.m.DirectDamageMult = 0.3;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		local strike = this.new("scripts/skills/actives/strike_skill");
		strike.m.Icon = "skills/active_200.png";
		strike.m.IconDisabled = "skills/active_200_sw.png";
		strike.m.Overlay = "active_200";
		this.addSkill(strike);
		local reap = this.new("scripts/skills/actives/reap_skill");
		reap.m.Icon = "skills/active_201.png";
		reap.m.IconDisabled = "skills/active_201_sw.png";
		reap.m.Overlay = "active_201";
		this.addSkill(reap);
	}

});

