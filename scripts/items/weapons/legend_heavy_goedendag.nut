this.legend_heavy_goedendag <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.legend_heavy_goedendag";
		this.m.Name = "Lucerne Hammer";
		this.m.Description = "A military grade metal-reinforced hammer with a spike at the top. Can be used to thrust at the enemy, or pummel them into submission.";
		this.m.Variants = [1]
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() -1)];
		this.updateVariant();
		this.m.WeaponType = this.Const.Items.WeaponType.Spear | this.Const.Items.WeaponType.Hammer;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.IsAgainstShields = true;
		this.m.IsAoE = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.Value = 3500;
		this.m.ShieldDamage = 0;
		this.m.Condition = 96.0;
		this.m.ConditionMax = 96.0;
		this.m.StaminaModifier = -18;
		this.m.RegularDamage = 55;
		this.m.RegularDamageMax = 85;
		this.m.ArmorDamageMult = 1.85;
		this.m.DirectDamageMult = 0.4;			
		this.m.ChanceToHitHead = 0;
	}

	function updateVariant()
	{
		this.m.IconLarge = "weapons/melee/legend_military_goedendag_0" + this.m.Variant + ".png";
		this.m.Icon = "weapons/melee/legend_military_goedendag_0" + this.m.Variant + "_70x70.png";
		this.m.ArmamentIcon = "icon_legend_military_goedendag_0" + this.m.Variant;
	}


	function onEquip()
	{
		this.weapon.onEquip();
		local thrust = this.new("scripts/skills/actives/thrust");
		thrust.m.Icon = "skills/active_128.png";
		thrust.m.IconDisabled = "skills/active_128_sw.png";
		thrust.m.Overlay = "active_128";
		thrust.m.DirectDamageMult = this.m.DirectDamageMult;			
		thrust.setFatigueCost(15);
		thrust.m.ActionPointCost = 6;
		this.addSkill(thrust);
		local skill;
		skill = this.new("scripts/skills/actives/smite_skill");		
		skill.m.Icon = "skills/active_89.png";
		skill.m.IconDisabled = "skills/active_89_sw.png";
		skill.m.Overlay = "active_89";
		this.addSkill(skill);
		local skill;
		skill = this.new("scripts/skills/actives/shatter_skill");		
		skill.m.Icon = "skills/active_90.png";
		skill.m.IconDisabled = "skills/active_90_sw.png";
		skill.m.Overlay = "active_90";
		skill.setFatigueCost(skill.getFatigueCostRaw() + 5);
		this.addSkill(skill);
	}

});

