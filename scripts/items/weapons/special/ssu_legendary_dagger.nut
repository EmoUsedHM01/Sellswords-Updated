this.ssu_legendary_dagger <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.ssu_legendary_dagger";
		this.m.Name = ::Mod_Sellswords.Strings.ssu_legendary_dagger.Name;
		this.m.Description = ::Mod_Sellswords.Strings.ssu_legendary_dagger.Description;
		this.m.IconLarge = "weapons/melee/obsidian_dagger_01.png";
		this.m.Icon = "weapons/melee/obsidian_dagger_70x70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Dagger;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.OneHanded | this.Const.Items.ItemType.Legendary;
		this.m.IsDoubleGrippable = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_obsidian_dagger";
		this.m.Condition = 1.0;
		this.m.ConditionMax = 1.0;
		this.m.Value = 15000;
		this.m.RegularDamage = 45;
		this.m.RegularDamageMax = 60;
		this.m.ArmorDamageMult = 1.15;
		this.m.DirectDamageMult = 0.2;
	}

	function getTooltip()
	{
		local result = this.weapon.getTooltip();
		result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/ssu_legendary_weapon.png",
			text = ::Mod_Sellswords.Strings.ssu_legendary_dagger.Tooltip1
		});
		result.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Mod_Sellswords.Strings.ssu_legendary_dagger.Tooltip2
		});
		result.push({
			id = 8,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Mod_Sellswords.Strings.ssu_legendary_dagger.Tooltip3
		});
		result.push({
			id = 9,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Mod_Sellswords.Strings.ssu_legendary_dagger.Tooltip4
		});

		return result;
	}

	function onEquip()
	{
		this.getContainer().getActor().getSkills().add(this.new("scripts/skills/effects/ssu_obsidian_dagger_effect"));

		this.weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/stab"));
		this.addSkill(this.new("scripts/skills/actives/puncture"));
		this.addSkill(this.new("scripts/skills/actives/deathblow_skill"));
	}

	function onUnequip()
	{
		this.weapon.onUnequip();
		this.getContainer().getActor().getSkills().removeByID("effects.ssu_obsidian_dagger");
	}

});