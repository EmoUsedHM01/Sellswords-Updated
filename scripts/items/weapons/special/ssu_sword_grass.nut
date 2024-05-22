this.ssu_sword_grass <- ::inherit("scripts/items/weapons/weapon", {
	m = 
	{
	},

	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.ssu_sword_grass";
		this.m.Name = "Mistletoe, Blessing of Gaia";
		this.m.Description = "One of the seven Legendary Swords, Mistletoe is the embodiment of nature. Crafted from the heart of the most powerful Dryad in recorded history, that power is now imbued into this extraordinary blade.";
		this.m.IconLarge = "weapons/melee/grass_sword_70x140.png"; 
		this.m.Icon = "weapons/melee/grass_sword_70x70.png";
		this.m.SlotType = ::Const.ItemSlot.Mainhand;
		this.m.WeaponType = ::Const.Items.WeaponType.Sword;
		this.m.ItemType = ::Const.Items.ItemType.Weapon | ::Const.Items.ItemType.MeleeWeapon | ::Const.Items.ItemType.OneHanded | ::Const.Items.ItemType.Legendary;
		this.m.IsDoubleGrippable = true;
		this.m.IsAgainstShields = true;
		this.m.IsAoE = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.IsIndestructible = true;
		this.m.IsDroppedAsLoot = true;
		this.m.ArmamentIcon = "icon_grass_sword";
		this.m.Value = 15000;
		this.m.Condition = 95;
		this.m.ConditionMax = 95;
		this.m.StaminaModifier = -8;
		this.m.RegularDamage = 60;
		this.m.RegularDamageMax = 80;
		this.m.ArmorDamageMult = 1.0;
		this.m.DirectDamageMult = 0.4;
	}

	function getTooltip()
	{
		local result = this.weapon.getTooltip();
		result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "One of the seven Legendary Swords"
		});
		result.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Inflicts the Poisoned status effect on hit"
		});
		result.push({
			id = 8,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Inflicts the Rooted status effect on hit"
		});
		
		return result;
	}
	
	function onEquip()
	{
		this.weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/grass_slash"));
		
		local swing = this.new("scripts/skills/actives/swing");
		swing.m.Icon = "skills/grass_swing.png";
		swing.m.IconDisabled = "skills/grass_swing_sw.png";
		this.addSkill(swing);
		
		local riposte = this.new("scripts/skills/actives/riposte");
		riposte.m.Icon = "skills/grass_riposte.png";
		riposte.m.IconDisabled = "skills/grass_riposte_sw.png";
		this.addSkill(riposte);		
		
	}

	function onUpdateProperties( _properties )
	{
		this.weapon.onUpdateProperties(_properties);
	}

});

