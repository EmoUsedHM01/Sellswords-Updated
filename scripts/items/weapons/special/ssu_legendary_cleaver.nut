this.ssu_legendary_cleaver <- ::inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.ssu_legendary_cleaver";
		this.m.Name = ::Mod_Sellswords.Strings.ssu_legendary_cleaver.Name;
		this.m.Description = ::Mod_Sellswords.Strings.ssu_legendary_cleaver.Description;
		this.m.IconLarge = "weapons/melee/ssu_bone_cleaver.png";
		this.m.Icon = "weapons/melee/ssu_bone_cleaver_70x70.png";
		this.m.WeaponType = ::Const.Items.WeaponType.Cleaver;
		this.m.SlotType = ::Const.ItemSlot.Mainhand;
		this.m.Categories = ::Mod_Sellswords.Strings.ssu_legendary_cleaver.Categories;
		this.m.ItemType = ::Const.Items.ItemType.Weapon | ::Const.Items.ItemType.MeleeWeapon | ::Const.Items.ItemType.OneHanded | ::Const.Items.ItemType.Legendary;
		this.m.IsDoubleGrippable = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.IsIndestructible = true;
		this.m.IsDroppedAsLoot = true;
		this.m.ArmamentIcon = "ssu_bone_cleaver";
		this.m.Value = 7500;
		this.m.Condition = 100.0;
		this.m.ConditionMax = 100.0;
		this.m.StaminaModifier = -8;
		this.m.RegularDamage = 75;
		this.m.RegularDamageMax = 100;
		this.m.ArmorDamageMult = 1.5;
		this.m.DirectDamageMult = 0.35;
		this.m.ChanceToHitHead = 15;
	}

	// the two blades are united while the character holds one of them in each hand
	function isUnited()
	{
		return this.isEquipped() && ::Mod_Sellswords.DualWield.hasUnitedTwinblades(this.getContainer().getActor());
	}

	function getTooltip()
	{
		local result = this.weapon.getTooltip();
		result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/ssu_legendary_weapon.png",
			text = ::Mod_Sellswords.Strings.ssu_legendary_cleaver.Tooltip1
		});
		result.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Mod_Sellswords.Strings.ssu_legendary_cleaver.Tooltip5
		});
		result.push({
			id = 8,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Mod_Sellswords.Strings.ssu_legendary_cleaver.Tooltip2
		});
		result.push({
			id = 9,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Mod_Sellswords.Strings.ssu_legendary_cleaver.Tooltip3
		});
		result.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Mod_Sellswords.Strings.ssu_legendary_cleaver.Tooltip4
		});

		return result;
	}

	function onEquip()
	{
		// the united blades have their own brush, it is the one with the red lightning when bloodied
		this.m.ArmamentIcon = this.isUnited() ? "ssu_bone_cleaver_united" : "ssu_bone_cleaver";
		this.weapon.onEquip();

		// a single blade is a normal cleaver
		if (!this.isUnited())
		{
			this.addSkill(this.new("scripts/skills/actives/cleave"));
			this.addSkill(this.new("scripts/skills/actives/decapitate"));
			return;
		}

		// the blade in the main hand carries the skills and the effect of the united blades
		if (this.getCurrentSlotType() == ::Const.ItemSlot.Mainhand)
		{
			this.addSkill(this.new("scripts/skills/effects/ssu_bone_cleaver_effect"));
			this.addSkill(this.new("scripts/skills/actives/ssu_bone_cleaver_slash"));
			this.addSkill(this.new("scripts/skills/actives/ssu_bone_cleaver_flurry"));
			this.addSkill(this.new("scripts/skills/actives/ssu_bone_cleaver_swing"));
			return;
		}

		// the second blade was just put in the off hand, so the first one is put on again to swap its skills
		// Legends does the same for the other blade whenever one of them is taken off or moved
		local main = this.getContainer().getItemAtSlot(::Const.ItemSlot.Mainhand);
		main.onUnequip();
		main.onEquip();
	}

	function setBloodied( _isBloodied )
	{
		this.weapon.setBloodied(_isBloodied);

		if (!this.isUnited())
			return;

		// the united blades are bloodied together
		local twin = this.getContainer().getItemAtSlot(this.getCurrentSlotType() == ::Const.ItemSlot.Mainhand ? ::Const.ItemSlot.Offhand : ::Const.ItemSlot.Mainhand);

		if (twin.m.IsBloodied != _isBloodied)
			twin.setBloodied(_isBloodied);
	}

	function onUpdateProperties( _properties )
	{
		this.weapon.onUpdateProperties(_properties);

		// only the united blades feed on blood, and the pair only counts once
		if (this.m.IsBloodied && this.getCurrentSlotType() == ::Const.ItemSlot.Mainhand && this.isUnited())
		{
			_properties.DamageRegularMult *= 1.2;
			_properties.DamageReceivedRegularMult *= 1.2;
		}
	}

});
