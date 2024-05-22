this.crpolemace <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.crpolemace";
		this.m.Name = "Refined Polemace";
		this.m.Description = "A long mace that can be used to deliver stunning blows over a distance.";
		this.m.Categories = "Mace, Two-Handed";
		this.m.IconLarge = "weapons/melee/polemace_03.png";
		this.m.Icon = "weapons/melee/polemace_03_70x70.png";
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "crpolemace";
		this.m.Value = 2900;
		this.m.ShieldDamage = 0;
		this.m.Condition = 96.0;
		this.m.ConditionMax = 96.0;
		this.m.StaminaModifier = -16;
		this.m.RangeMin = 1;
		this.m.RangeMax = 2;
		this.m.RangeIdeal = 2;
		this.m.RegularDamage = 65;
		this.m.RegularDamageMax = 90;
		this.m.ArmorDamageMult = 1.1;
		this.m.DirectDamageMult = 0.4;
		this.m.ChanceToHitHead = 5;
		this.m.DirectDamageAdd = 0.05;		
	}

	function onEquip()
	{
		this.weapon.onEquip();
		local skill = this.new("scripts/skills/actives/crumble_skill");
		this.addSkill(skill);
		skill = this.new("scripts/skills/actives/knock_over_skill");
		this.addSkill(skill);
	}

});

