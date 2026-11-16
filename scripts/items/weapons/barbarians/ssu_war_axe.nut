this.ssu_war_axe <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.ssu_war_axe";
		this.m.Name = ::Mod_Sellswords.Strings.ssu_war_axe.Name;
		this.m.Description = ::Mod_Sellswords.Strings.ssu_war_axe.Description;
		this.m.Categories = ::Mod_Sellswords.Strings.ssu_war_axe.Categories;
		this.m.IconLarge = "weapons/melee/ssu_war_axe.png";
		this.m.Icon = "weapons/melee/ssu_war_axe_70x70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Axe;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.OneHanded;
		this.m.IsDoubleGrippable = true;
		this.m.IsAgainstShields = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "ssu_war_axe";
		this.m.Value = 1400;
		this.m.ShieldDamage = 18;
		this.m.Condition = 92.0;
		this.m.ConditionMax = 92.0;
		this.m.StaminaModifier = -14;
		this.m.RegularDamage = 40;
		this.m.RegularDamageMax = 55;
		this.m.ArmorDamageMult = 1.35;
		this.m.DirectDamageMult = 0.3;
		this.m.DirectDamageAdd = 0.1;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		local skill = this.new("scripts/skills/actives/chop");
		skill.m.Icon = "skills/active_185.png";
		skill.m.IconDisabled = "skills/active_185_sw.png";
		skill.m.Overlay = "active_185";
		this.addSkill(skill);
		skill = this.new("scripts/skills/actives/split_shield");
		skill.setApplyAxeMastery(true);
		this.addSkill(skill);
	}

});
