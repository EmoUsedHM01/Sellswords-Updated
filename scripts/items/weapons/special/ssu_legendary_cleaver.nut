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
		this.m.SlotType = ::Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.Categories = ::Mod_Sellswords.Strings.ssu_legendary_cleaver.Categories;
		this.m.ItemType = ::Const.Items.ItemType.Weapon | ::Const.Items.ItemType.MeleeWeapon | ::Const.Items.ItemType.TwoHanded | ::Const.Items.ItemType.Legendary;
		this.m.IsAoE = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.IsIndestructible = true;
		this.m.IsDroppedAsLoot = true;
		this.m.ArmamentIcon = "ssu_bone_cleaver";
		this.m.Value = 15000;
		this.m.Condition = 100.0;
		this.m.ConditionMax = 100.0;
		this.m.StaminaModifier = -16;
		this.m.RegularDamage = 75;
		this.m.RegularDamageMax = 100;
		this.m.ArmorDamageMult = 1.5;
		this.m.DirectDamageMult = 0.35;
		this.m.ChanceToHitHead = 15;
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
			text = ::Mod_Sellswords.Strings.ssu_legendary_cleaver.Tooltip2
		});
		result.push({
			id = 8,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Mod_Sellswords.Strings.ssu_legendary_cleaver.Tooltip3
		});
		result.push({
			id = 9,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Mod_Sellswords.Strings.ssu_legendary_cleaver.Tooltip4
		});
		
		return result;
	}

	function onEquip()
	{
		this.getContainer().getActor().getSkills().add(this.new("scripts/skills/effects/ssu_bone_cleaver_effect"));

		this.weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/ssu_bone_cleaver_slash"));
		this.addSkill(this.new("scripts/skills/actives/ssu_bone_cleaver_flurry"));
		this.addSkill(this.new("scripts/skills/actives/ssu_bone_cleaver_swing"));
	}

	function onUpdateProperties( _properties )
	{
		this.weapon.onUpdateProperties(_properties);

		if (this.m.IsBloodied = true)
		{
			_properties.DamageRegularMult *= 1.2;
			_properties.DamageReceivedRegularMult *= 1.2
		}
	}

	function onUnequip()
	{
		this.weapon.onUnequip();
		this.getContainer().getActor().getSkills().removeByID("effects.ssu_bone_cleaver");
	}

});