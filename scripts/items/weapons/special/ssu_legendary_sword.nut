this.ssu_legendary_sword <- ::inherit("scripts/items/weapons/weapon", {
	m = {
		StunChance = 75
	},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.ssu_legendary_sword";
		this.m.Name = "[color=#456ca0]Reproach of the Old Gods[/color]";
		this.m.Description = "One of the seven legendary weapons,\n[color=#456ca0]Reproach of the Old Gods[/color] bends purples and oranges until it seemingly carries twilight itself in its fuller.\nHeld to the touch, one cannot tell if they are being burned or chilled. Magic or well-crafted, whatever the weapon is it vibrates as though it were fighting off power immense and you need only swing it to find the steel\'s true charge.";
		this.m.IconLarge = "weapons/melee/ssu_lightning_sword.png";
		this.m.Icon = "weapons/melee/ssu_lightning_sword_70x70.png";
		this.m.SlotType = ::Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.Categories = "Sword, Two-Handed";
		this.m.ItemType = ::Const.Items.ItemType.Weapon | ::Const.Items.ItemType.MeleeWeapon | ::Const.Items.ItemType.TwoHanded | ::Const.Items.ItemType.Legendary;
		this.m.IsAgainstShields = true;
		this.m.IsAoE = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.IsIndestructible = true;
		this.m.IsDroppedAsLoot = true;
		this.m.ArmamentIcon = "ssu_lightning_sword";
		this.m.Value = 15000;
		this.m.Condition = 100;
		this.m.ConditionMax = 100;
		this.m.StaminaModifier = -12;
		this.m.ShieldDamage = 24;
		this.m.RegularDamage = 90;
		this.m.RegularDamageMax = 115;
		this.m.ArmorDamageMult = 1.2;
		this.m.DirectDamageMult = 0.3;
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
			text = "Inflicts an additional [color=%positive%]15%[/color] damage that ignores armor, and chains, on up to three targets."
		});
		
		return result;
	}

	function onEquip()
	{
		this.getContainer().getActor().getSkills().add(this.new("scripts/skills/effects/ssu_lightning_sword_effect"));

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

	function onUpdateProperties( _properties )
	{
		this.weapon.onUpdateProperties(_properties);
	}

	function onUnequip()
	{
		this.weapon.onUnequip();
		this.getContainer().getActor().getSkills().removeByID("effects.ssu_lightning_sword");
	}

});