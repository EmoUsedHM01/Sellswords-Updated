this.ssu_legendary_dagger <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.ssu_legendary_dagger";
		this.m.Name = "[color=#456ca0]Obsidian Dagger[/color]";
		this.m.Description = "One of the seven legendary weapons,\nthe [color=#456ca0]Obsidian Dagger[/color] was given to you by a witch after tempering it with your blood.\nReflections in its glass seem to move on their own, but this is clearly a trick of the eye.\nVery curiously, however, blood never seems to dry if it rests upon the obsidian.";
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
			icon = "ui/icons/legendary_weapon.png",
			text = "One of the seven [color=#456ca0]Legendary[/color] weapons."
		});
		result.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Inflicts the [color=" + this.Const.UI.Color.PositiveValue + "]Withered[/color] status effect on hit."
		});
		result.push({
			id = 8,
			type = "text",
			icon = "ui/icons/special.png",
			text = "When attacking enemies that bleed, heals the player equal to the damage inflicted."
		});
		result.push({
			id = 9,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Resurrects any human killed with it as a Wiederganger fighting for you."
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