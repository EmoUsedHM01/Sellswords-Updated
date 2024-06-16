this.ssu_legendary_hammer <- ::inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.ssu_legendary_hammer";
		this.m.Name = "[color=#679d5e]Nature\'s Judgement[/color]";
		this.m.Description = "One of the seven legendary weapons,\n[color=#679d5e]Nature\'s Judgement[/color] is forged from the heartwood of the oldest living tree in the forest and imbued with the essence of nature itself.\nIts construction is entwined with living roots and mystical runes that glow with green light. The sheer force its blows can bring will shatter flesh and steel alike.";
		this.m.IconLarge = "weapons/melee/ssu_earth_hammer.png"; 
		this.m.Icon = "weapons/melee/ssu_earth_hammer_70x70.png";
		this.m.SlotType = ::Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.Categories = "Hammer, Two-Handed";
		this.m.ItemType = ::Const.Items.ItemType.Weapon | ::Const.Items.ItemType.MeleeWeapon | ::Const.Items.ItemType.TwoHanded | ::Const.Items.ItemType.Legendary;
		this.m.IsAgainstShields = true;
		this.m.IsAoE = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.IsIndestructible = true;
		this.m.IsDroppedAsLoot = true;
		this.m.ArmamentIcon = "ssu_earth_hammer";
		this.m.Value = 15000;
		this.m.ShieldDamage = 32;
		this.m.Condition = 120.0;
		this.m.ConditionMax = 120.0;
		this.m.StaminaModifier = -18;
		this.m.RegularDamage = 85;
		this.m.RegularDamageMax = 110;
		this.m.ArmorDamageMult = 1.8;
		this.m.DirectDamageMult = 0.5;
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
			text = "When swung, this weapon unleashes a powerful shockwave to all enemies in adjacent tiles to the target."
		});
		result.push({
			id = 8,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Inflicts the [color=" + this.Const.UI.Color.PositiveValue + "]Rooted[/color] status effect on hit."
		});
		result.push({
			id = 9,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Slowly repairs [color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] durability per turn."
		});

		return result;
	}

	function onEquip()
	{
		this.getContainer().getActor().getSkills().add(this.new("scripts/skills/effects/ssu_earth_hammer_effect"));

		this.weapon.onEquip();
		local skill;

		skill = this.new("scripts/skills/actives/earth_hammer_smite_skill");
		this.addSkill(skill);

		skill = this.new("scripts/skills/actives/shatter_skill");
		skill.m.Icon = "skills/ssu_earth_shatter.png";
		this.addSkill(skill);

		skill = this.new("scripts/skills/actives/split_shield");
		skill.m.Icon = "skills/ssu_earth_split_shield.png";
		skill.setApplyAxeMastery(true);
		skill.setFatigueCost(skill.getFatigueCostRaw() + 5);
		this.addSkill(skill);
	}

	function onTurnStart()
	{
		this.m.Condition = this.Math.minf(this.m.ConditionMax, this.m.Condition + 10.0);
	}

	function onUpdateProperties( _properties )
	{
		this.weapon.onUpdateProperties(_properties);
	}

	function onUnequip()
	{
		this.weapon.onUnequip();
		this.getContainer().getActor().getSkills().removeByID("effects.ssu_earth_hammer");
	}

});