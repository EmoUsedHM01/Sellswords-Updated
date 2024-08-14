this.cr_orc_mace <- this.inherit("scripts/items/weapons/weapon", {
	m = {
		StunChance = 30
	},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.cr_orc_mace";
		this.m.Name = "Spiked Mace";
		this.m.Description = "A wooden shaft fitted with a skull for good measure, used to deliver a combination of blunt-force and puncturing blows. Not well suited for human hands.";
		this.m.Categories = "Mace, One-Handed";
		this.m.IconLarge = "weapons/melee/orc_mace.png";
		this.m.Icon = "weapons/melee/orc_mace_70x70.png";
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.OneHanded;
		this.m.IsDoubleGrippable = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "cr_orc_mace";
		this.m.Value = 900;
		this.m.ShieldDamage = 0;
		this.m.Condition = 72.0;
		this.m.ConditionMax = 72.0;
		this.m.StaminaModifier = -18;
		this.m.RegularDamage = 35;
		this.m.RegularDamageMax = 65;
		this.m.ArmorDamageMult = 1.2;
		this.m.DirectDamageMult = 0.4;
		this.m.FatigueOnSkillUse = 5;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		local bash = this.new("scripts/skills/actives/bash");
		bash.m.Icon = "skills/active_76.png";
		bash.m.IconDisabled = "skills/active_76_sw.png";
		bash.m.Overlay = "active_76";
		this.addSkill(bash);
		this.addSkill(this.new("scripts/skills/actives/knock_out"));
	}

});

