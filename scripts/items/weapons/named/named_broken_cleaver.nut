this.named_broken_cleaver <- this.inherit("scripts/items/weapons/named/named_weapon", {
	m = {},
	function create()
	{
		this.named_weapon.create();
		this.m.Variant = this.Math.rand(1, 5);
		this.updateVariant();
		this.m.ID = "weapon.named_broken_cleaver";
		this.m.Name = "Tribal's Honour";
		this.m.Description = "A heavy savage cleaver, worn and beaten, but made of some strange kind of incredibly heavy and durable metal which appears to have prolonged the weapons life long past its counterparts. It is capable of destroying all who stand against you with just the sheer weight alone.";
		this.m.Categories = "Cleaver, Axe, Two-Handed";
		this.m.IconLarge = "weapons/melee/canpodajian2.png";
		this.m.Icon = "weapons/melee/canpodajian2_70.png";
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Named | this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.IsAgainstShields = true;
		this.m.IsAoE = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "canpodajian2";
		this.m.Value = 4600;
		this.m.ShieldDamage = 36;
		this.m.Condition = 96.0;
		this.m.ConditionMax = 96.0;
		this.m.StaminaModifier = -28;
		this.m.RegularDamage = 60;
		this.m.RegularDamageMax = 85;
		this.m.ArmorDamageMult = 1.2;
		this.m.DirectDamageMult = 0.4;
		this.m.DirectDamageAdd = 0.1;			
		this.m.ChanceToHitHead = 10;
		this.randomizeValues();
	}

	
	function onEquip()
	{
		this.named_weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/cleave"));
		this.addSkill(this.new("scripts/skills/actives/crdecapitate"));
		local skillToAdd = this.new("scripts/skills/actives/split_shield");
		skillToAdd.setApplyAxeMastery(true);
		skillToAdd.setFatigueCost(skillToAdd.getFatigueCostRaw() + 5);
		this.addSkill(skillToAdd);
	}

});

