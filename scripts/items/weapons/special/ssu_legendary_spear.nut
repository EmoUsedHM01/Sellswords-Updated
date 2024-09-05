this.ssu_legendary_spear <- ::inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.ssu_legendary_spear";
		this.m.Name = "[color=#456ca0]Specter\'s Requiem[/color]";
		this.m.Description = "One of the seven legendary weapons,\n[color=#456ca0]Specter\'s Requiem[/color] emits a low, mournful wail that echoes through the air when swung, freezing the blood of any nearby foes. Said to be wielded by a forgotten warrior cursed to eternal unrest, this weapon can phase through armor and shields, leaving only ghostly wounds that fester in the soul of those unfortunate enough to face against the wielder.";
		this.m.IconLarge = "weapons/melee/ssu_ghost_spear.png";
		this.m.Icon = "weapons/melee/ssu_ghost_spear_70x70.png";
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.Categories = "Spear, Polearm, Two-Handed";
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded | ::Const.Items.ItemType.Legendary;
		this.m.IsAgainstShields = false;
		this.m.IsAoE = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.IsIndestructible = true;
		this.m.IsDroppedAsLoot = true;
		this.m.ArmamentIcon = "ssu_ghost_spear";
		this.m.Value = 15000;
		this.m.RangeMin = 1;
		this.m.RangeMax = 2;
		this.m.RangeIdeal = 2;
		this.m.Condition = 100;
		this.m.ConditionMax = 100;
		this.m.StaminaModifier = 0;
		this.m.RegularDamage = 75;
		this.m.RegularDamageMax = 90;
		this.m.ArmorDamageMult = 0;
		this.m.DirectDamageMult = 1.0;
		this.m.ChanceToHitHead = 5;
	}

	function getTooltip()
	{
		local result = this.weapon.getTooltip();
		result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/legendary_weapon.png",
			text = "One of the seven [color=#456ca0]Legendary[/color] weapons."
		});
		result.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Attacks from this weapon [color=" + this.Const.UI.Color.NegativeValue + "]ignore[/color] armor."
		});

		return result;
	}

	function onEquip()
	{
		this.weapon.onEquip();

		this.addSkill(this.new("scripts/skills/actives/ssu_ghost_spear_strike"));

		local skill = this.new("scripts/skills/actives/jab");
		skill.m.Icon = "skills/ssu_ghost_spear_jab.png";
		skill.m.IconDisabled = "skills/ssu_ghost_spear_jab_sw.png";
		skill.m.Overlay = "ssu_ghost_spear_jab";
		skill.m.DirectDamageMult = this.m.DirectDamageMult;
		this.addSkill(skill);

		local skill = this.new("scripts/skills/actives/reap_skill");
		skill.m.Icon = "skills/ssu_ghost_spear_reap.png";
		skill.m.Overlay = "ssu_ghost_spear_reap";
		skill.m.DirectDamageMult = this.m.DirectDamageMult;
		this.addSkill(skill);
	}

	function onUpdateProperties( _properties )
	{
		this.weapon.onUpdateProperties(_properties);

		if (this.getContainer().getActor().getSkills().getSkillByID("racial.ghost_boss"))
			this.m.ArmamentIcon = "ssu_ghost_spear_boss";
		else
			this.m.ArmamentIcon = "ssu_ghost_spear";
	}

	function onUnequip()
	{
		this.weapon.onUnequip();
	}

});