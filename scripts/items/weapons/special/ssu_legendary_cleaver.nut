this.ssu_legendary_cleaver <- ::inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.ssu_legendary_cleaver";
		this.m.Name = "[color=#456ca0]Bloodfang Twinblades[/color]";
		this.m.Description = "One of the seven legendary weapons,\n[color=#456ca0]Bloodfang Twinblades[/color] gleam with a sinister light, their edges serrated like the fangs they were crafted from.\nIndividually, they are lifeless, but when united, they pulse with a thirst for blood, their true power unleashed in a symphony of blood, bone, and steel.\nThe blades can cut through the toughest armor, leaving behind wounds that never fully heal.";
		this.m.IconLarge = "weapons/melee/ssu_bone_cleaver.png";
		this.m.Icon = "weapons/melee/ssu_bone_cleaver_70x70.png";
		this.m.SlotType = ::Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.Categories = "Cleaver, Two-Handed";
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
			icon = "ui/icons/legendary_weapon.png",
			text = "One of the seven [color=#456ca0]Legendary[/color] weapons."
		});
		result.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "When [color=" + this.Const.UI.Color.NegativeValue + "]Bloodied[/color], grants the user enhanced stats."
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
			text = "Bleeds inflicted with this weapon are permanent."
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
	}

	function onUnequip()
	{
		this.weapon.onUnequip();
		this.getContainer().getActor().getSkills().removeByID("effects.ssu_bone_cleaver");
	}

});