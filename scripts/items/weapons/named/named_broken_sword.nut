this.named_broken_sword <- this.inherit("scripts/items/weapons/named/named_weapon", {
	m = {
		StunChance = 0
	},
	function create()
	{
		this.named_weapon.create();
		this.m.Variant = this.Math.rand(1, 5);
		this.updateVariant();
		this.m.ID = "weapon.named_broken_sword";
		this.m.Name = "The Broken Savage";
		this.m.Description = "A heavy savage sword, worn and beaten, but made of some strange kind of incredibly heavy and durable metal which appears to have prolonged the weapons life long past its counterparts. It is capable of destroying all who stand against you with just the sheer weight alone.";
		this.m.Categories = "Sword, Mace, Hammer, Axe, Two-Handed";
		this.m.IconLarge = "weapons/melee/canpodajian.png";
		this.m.Icon = "weapons/melee/canpodajian_70.png";
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Named | this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.IsAgainstShields = true;
		this.m.IsAoE = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "canpodajian";
		this.m.Value = 4600;
		this.m.ShieldDamage = 32;
		this.m.Condition = 96.0;
		this.m.ConditionMax = 96.0;
		this.m.StaminaModifier = -28;
		this.m.RegularDamage = 75;
		this.m.RegularDamageMax = 90;
		this.m.ArmorDamageMult = 1.2;
		this.m.DirectDamageMult = 0.35;
		this.m.ChanceToHitHead = 10;			
		this.randomizeValues();
	}

	
	function onEquip()
	{
		this.named_weapon.onEquip();
		local skillToAdd = this.new("scripts/skills/actives/overhead_strike");
		skillToAdd.setStunChance(this.m.StunChance);
		skillToAdd.setFatigueCost(skillToAdd.getFatigueCostRaw() + 3);		
		skillToAdd.m.DirectDamageMult = this.m.DirectDamageMult;
		this.addSkill(skillToAdd);		
		//this.addSkill(this.new("scripts/skills/actives/canpodajian_01"));
		//this.addSkill(this.new("scripts/skills/actives/crcudgel_skill"));	
		skillToAdd = this.new("scripts/skills/actives/strike_down_skill");
		this.addSkill(skillToAdd);	
		skillToAdd = this.new("scripts/skills/actives/shatter_skill");
		skillToAdd.m.DirectDamageMult = this.m.DirectDamageMult + 0.05;		
		this.addSkill(skillToAdd);		
		local skillToAdd = this.new("scripts/skills/actives/split_shield");
		skillToAdd.setApplyAxeMastery(true);
		skillToAdd.setFatigueCost(skillToAdd.getFatigueCostRaw() + 5);
		this.addSkill(skillToAdd);
	}

});

