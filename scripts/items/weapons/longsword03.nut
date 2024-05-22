this.longsword03 <- this.inherit("scripts/items/weapons/weapon", {
	m = {
		StunChance = 0
	},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.longsword03";
		this.m.Name = "Kriegsmesser";
		this.m.Description = "Messer are characterized by their single-edged blades. The blade is certainly brutally efficient in cutting, but the simple design has also a subtlety that is easily overlooked.";
		this.m.IconLarge = "weapons/melee/legend_crusader_sword_01.png";
		this.m.Icon = "weapons/melee/legend_crusader_sword_01_70x70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Sword;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.IsAgainstShields = false;
		this.m.IsAoE = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_legend_crusader_sword_01";
		this.m.Value = 3000;
		this.m.Condition = 68.0;
		this.m.ConditionMax = 68.0;
		this.m.StaminaModifier = -12;
		this.m.RegularDamage = 75;
		this.m.RegularDamageMax = 90;
		this.m.ArmorDamageMult = 0.85;
		this.m.DirectDamageMult = 0.25;
		this.m.ChanceToHitHead = 10;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		local skillToAdd = this.new("scripts/skills/actives/overhead_strike");
		skillToAdd.setStunChance(this.m.StunChance);
		this.addSkill(skillToAdd);
		local skill = this.new("scripts/skills/actives/slash");
		skill.m.isBunt = true;
		skill.m.Name = "Bunt";
		skill.m.Icon = "skills/active_bunt.png";
		skill.m.IconDisabled = "skills/active_bunt_sw.png";
		skill.m.FatigueCost = 13;
		skill.m.DirectDamageMult = this.m.DirectDamageMult;
		this.addSkill(skill);
		this.addSkill(this.new("scripts/skills/actives/split"));
	}

});