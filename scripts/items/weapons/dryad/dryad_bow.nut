this.dryad_bow <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.dryad_bow";
		this.m.Name = "Dryad Bow";
		this.m.Description = "This hardwood bow, crafted by the skilled hands of the Dryads, is a masterpiece of natural artistry. The bowstring, unique to the Heartwoods, is woven from the finest threads of spider silk.";
		this.m.IconLarge = "weapons/ranged/dryad_bow.png";
		this.m.Icon = "weapons/ranged/dryad_bow_70x70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Bow;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.RangedWeapon | this.Const.Items.ItemType.Defensive | this.Const.Items.ItemType.TwoHanded;
		this.m.EquipSound = this.Const.Sound.ArmorLeatherImpact;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = true;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_dryad_bow";
		this.m.Value = 1200;
		this.m.RangeMin = 2;
		this.m.RangeMax = 7;
		this.m.RangeIdeal = 7;
		this.m.StaminaModifier = -7;
		this.m.Condition = 50.0;
		this.m.ConditionMax = 50.0;
		this.m.RegularDamage = 40;
		this.m.RegularDamageMax = 55;
		this.m.ArmorDamageMult = 0.55;
		this.m.DirectDamageMult = 0.45;
	}

	function getTooltip()
	{
		local result = this.weapon.getTooltip();
		result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Slowly repairs [color=" + this.Const.UI.Color.PositiveValue + "]5[/color] durability each turn."
		});
		return result;
	}

	function getAmmoID()
	{
		return "ammo.arrows";
	}

	function getAdditionalRange( _actor )
	{
		return _actor.getCurrentProperties().IsSpecializedInBows ? 1 : 0;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/quick_shot"));
		this.addSkill(this.new("scripts/skills/actives/aimed_shot"));
		this.addSkill(this.new("scripts/skills/actives/legend_piercing_shot"));
		this.addSkill(this.new("scripts/skills/actives/legend_cascade_skill"));
	}

	function onTurnStart()
	{
		this.m.Condition = this.Math.minf(this.m.ConditionMax, this.m.Condition + 5.0);
	}

});