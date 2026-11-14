this.ssu_legendary_axe <- ::inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.ssu_legendary_axe";
		this.m.Name = ::Mod_Sellswords.Strings.ssu_legendary_axe.Name;
		this.m.Description = ::Mod_Sellswords.Strings.ssu_legendary_axe.Description;
		this.m.IconLarge = "weapons/melee/ssu_ice_axe.png"; 
		this.m.Icon = "weapons/melee/ssu_ice_axe_70x70.png";
		this.m.SlotType = ::Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.Categories = ::Mod_Sellswords.Strings.ssu_legendary_axe.Categories;
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
			icon = "ui/icons/ssu_legendary_weapon.png",
			text = ::Mod_Sellswords.Strings.ssu_legendary_axe.Tooltip1
		});
		result.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Mod_Sellswords.Strings.ssu_legendary_axe.Tooltip2
		});
		result.push({
			id = 8,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Mod_Sellswords.Strings.ssu_legendary_axe.Tooltip3
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