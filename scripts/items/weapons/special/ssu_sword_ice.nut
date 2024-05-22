this.ssu_sword_ice <- ::inherit("scripts/items/weapons/weapon", {
	m = 
	{
	},

	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.ssu_sword_ice";
		this.m.Name = "Winter's Touch, the Ijirok's Remembrance";
		this.m.Description = "One of the seven Legendary Swords, Winter's Touch is the embodiment of death's cold embrace. Created from the frozen lake of the Hunting Grounds, the bitterly cold ice this blade is made from never seems to melt.";
		this.m.IconLarge = "weapons/melee/ice_sword_70x140.png"; 
		this.m.Icon = "weapons/melee/ice_sword_70x70.png";
		this.m.SlotType = ::Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.WeaponType = ::Const.Items.WeaponType.Sword;
		this.m.ItemType = ::Const.Items.ItemType.Weapon | ::Const.Items.ItemType.MeleeWeapon | ::Const.Items.ItemType.TwoHanded | ::Const.Items.ItemType.Legendary;
		this.m.IsDoubleGrippable = true;
		this.m.IsAgainstShields = true;
		this.m.IsAoE = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.IsIndestructible = true;
		this.m.IsDroppedAsLoot = true;
		this.m.ArmamentIcon = "icon_ice_sword";
		this.m.Value = 15000;
		this.m.Condition = 115;
		this.m.ConditionMax = 115;
		this.m.StaminaModifier = -16;
		this.m.RegularDamage = 85;
		this.m.RegularDamageMax = 110;
		this.m.ArmorDamageMult = 1.2;
		this.m.DirectDamageMult = 0.5;
		this.m.ChanceToHitHead = 15;
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
			text = "Inflicts the Chilled status effect on hit"
		});
		result.push({
			id = 8,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Inflicts the Staggered status effect on hit"
		});
		
		return result;
	}
	
	function onEquip()
	{
		this.weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/ice_slash"));
		
		this.addSkill(this.new("scripts/skills/actives/ice_swing"));
		
		local riposte = this.new("scripts/skills/actives/riposte");
		riposte.m.Icon = "skills/ice_riposte.png";
		riposte.m.IconDisabled = "skills/ice_riposte_sw.png";
		this.addSkill(riposte);		
		
	}

	function onUpdateProperties( _properties )
	{
		this.weapon.onUpdateProperties(_properties);
	}

});

