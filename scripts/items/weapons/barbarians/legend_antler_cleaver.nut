this.legend_antler_cleaver <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.legend_antler_cleaver";
		this.m.Name = "Dryad Antler Whip";
		this.m.Description = "A very unique style of whip crafted from an antler and a heart of oak. Unwieldy and blunt, but still dangerous.";
		this.m.IconLarge = "weapons/melee/druweapon_01.png";
		this.m.Icon = "weapons/melee/druweapon_01_70x70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Cleaver | this.Const.Items.WeaponType.Whip;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.OneHanded;
		this.m.IsDoubleGrippable = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_druweapon_01";
		this.m.ShieldDamage = 0;
		this.m.Condition = 60.0;
		this.m.ConditionMax = 60.0;
		this.m.StaminaModifier = -6;
		this.m.Value = 220;
		this.m.RegularDamage = 30;
		this.m.RegularDamageMax = 45;
		this.m.ArmorDamageMult = 0.75;
		this.m.DirectDamageMult = 0.35;
		this.m.DirectDamageAdd = 0.2;
	}
	
	function getTooltip()
	{
		local result = this.weapon.getTooltip();
		result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Slowly repairs [color=" + this.Const.UI.Color.PositiveValue + "] +5[/color] durability per turn."
		});
		return result;
	}
	
	function onEquip()
	{
		this.weapon.onEquip();
		local cleave = this.new("scripts/skills/actives/cleave");
		cleave.m.Icon = "skills/active_177.png";
		cleave.m.IconDisabled = "skills/active_177_sw.png";
		cleave.m.Overlay = "active_177";
		this.addSkill(cleave);
		local skill = this.new("scripts/skills/actives/whip_skill");
		skill.m.Icon = "skills/active_161.png";
		skill.m.IconDisabled = "skills/active_161_sw.png";
		skill.m.Overlay = "active_161";
		this.addSkill(skill);
		local skill = this.new("scripts/skills/actives/disarm_skill");
		this.addSkill(skill);
	}
	
	function onTurnStart()
	{
		this.m.Condition = this.Math.minf(this.m.ConditionMax, this.m.Condition + 5.0);
	}
});

