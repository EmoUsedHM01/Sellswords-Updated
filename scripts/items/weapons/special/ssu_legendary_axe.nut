this.ssu_legendary_axe <- ::inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.ssu_legendary_axe";
		this.m.Name = "[color=#456ca0]Winter\'s Touch, the Ijirok\'s Remembrance[/color]";
		this.m.Description = "One of the seven legendary weapons,\n[color=#456ca0]Winter\'s Touch[/color] is the embodiment of death\'s cold embrace.\nCreated from the frozen lake of the Hunting Grounds, the bitterly cold ice this blade has growing from it never seems to melt.";
		this.m.IconLarge = "weapons/melee/ssu_ice_axe.png"; 
		this.m.Icon = "weapons/melee/ssu_ice_axe_70x70.png";
		this.m.SlotType = ::Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.Categories = "Axe, Two-Handed";
		this.m.ItemType = ::Const.Items.ItemType.Weapon | ::Const.Items.ItemType.MeleeWeapon | ::Const.Items.ItemType.TwoHanded | ::Const.Items.ItemType.Legendary;
		this.m.IsAgainstShields = true;
		this.m.IsAoE = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.IsIndestructible = true;
		this.m.IsDroppedAsLoot = true;
		this.m.ArmamentIcon = "ssu_ice_axe";
		this.m.Value = 15000;
		this.m.Condition = 115;
		this.m.ConditionMax = 115;
		this.m.StaminaModifier = -18;
		this.m.ShieldDamage = 42;
		this.m.RegularDamage = 90;
		this.m.RegularDamageMax = 120;
		this.m.ArmorDamageMult = 1.6;
		this.m.DirectDamageMult = 0.4;
		this.m.ChanceToHitHead = 15;
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
			text = "Inflicts the [color=" + this.Const.UI.Color.PositiveValue + "]Chilled[/color] status effect on hit."
		});
		result.push({
			id = 8,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Inflicts the [color=" + this.Const.UI.Color.PositiveValue + "]Staggered[/color] status effect on hit."
		});
		
		return result;
	}

	function onEquip()
	{
		this.getContainer().getActor().getSkills().add(this.new("scripts/skills/effects/ssu_ice_axe_effect"));

		this.weapon.onEquip();
		local skill;
		skill = this.new("scripts/skills/actives/split_man");
		skill.m.Icon = "skills/ssu_ice_split_man.png";
		this.addSkill(skill);

		skill = this.new("scripts/skills/actives/round_swing");
		skill.m.Icon = "skills/ssu_ice_round_swing.png";
		this.addSkill(skill);

		skill = this.new("scripts/skills/actives/split_shield");
		skill.m.Icon = "skills/ssu_ice_split_shield.png";
		skill.setApplyAxeMastery(true);
		skill.setFatigueCost(skill.getFatigueCostRaw() + 5);
		this.addSkill(skill);
	}

	function onUpdateProperties( _properties )
	{
		this.weapon.onUpdateProperties(_properties);
	}

	function onUnequip()
	{
		this.weapon.onUnequip();
		this.getContainer().getActor().getSkills().removeByID("effects.ssu_ice_axe");
	}

});