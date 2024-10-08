this.cr_orc_sword <- this.inherit("scripts/items/weapons/weapon", {
	m = {
		StunChance = 30
	},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.cr_orc_sword";
		this.m.Name = "Unhold Gutter";
		this.m.Description = "A huge two-handed blade with a rough, jagged edge. The Orcs use this for carving through giants. Not well suited for human hands.";
		this.m.IconLarge = "weapons/melee/cr_orc_sword.png";
		this.m.Icon = "weapons/melee/cr_orc_sword_70x70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Sword;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.IsDoubleGrippable = false;
		this.m.IsAgainstShields = true;
		this.m.IsAoE = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "cr_orc_sword";
		this.m.Value = 2800;
		this.m.ShieldDamage = 32;
		this.m.Condition = 92.0;
		this.m.ConditionMax = 92.0;
		this.m.StaminaModifier = -28;
		this.m.RegularDamage = 95;
		this.m.RegularDamageMax = 130;
		this.m.ArmorDamageMult = 1.4;
		this.m.DirectDamageMult = 0.2;
		this.m.FatigueOnSkillUse = 5;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		local skillToAdd = this.new("scripts/skills/actives/overhead_strike");
		skillToAdd.setStunChance(this.m.StunChance);
		this.addSkill(skillToAdd);
		this.addSkill(this.new("scripts/skills/actives/split"));
		this.addSkill(this.new("scripts/skills/actives/swing"));
		local skillToAdd = this.new("scripts/skills/actives/split_shield");
		skillToAdd.setFatigueCost(skillToAdd.getFatigueCostRaw() + 5);
		this.addSkill(skillToAdd);
	}

});