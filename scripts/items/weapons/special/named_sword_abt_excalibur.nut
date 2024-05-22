this.named_sword_abt_excalibur <- this.inherit("scripts/items/weapons/weapon", {
	m = {
		StunChance = 0,
		innateperk = false		
	},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.named_sword_abt_excalibur";
		this.m.Name = "Excalibur, the Sword in the Stone";
		this.m.Description = "This zweihander is a true masterpiece, with a blade that is both flexible yet extremely durable.";
		this.m.WeaponType = this.Const.Items.WeaponType.Sword;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.IsAgainstShields = true;
		this.m.IsAoE = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.Value = 15000;
		this.m.ShieldDamage = 16;
		this.m.Condition = 72.0;
		this.m.ConditionMax = 72.0;
		this.m.StaminaModifier = -12;
		this.m.RegularDamage = 100;
		this.m.RegularDamageMax = 120;
		this.m.ArmorDamageMult = 1.2;
		this.m.DirectDamageMult = 0.25;
		this.m.ChanceToHitHead = 5;
		this.m.FatigueOnSkillUse = -3;	

		this.m.IconLarge = "weapons/melee/sword_two_hand_01_named_03.png";
		this.m.Icon = "weapons/melee/sword_two_hand_01_named_03_70x70.png";
		this.m.ArmamentIcon = "icon_named_greatsword_03";		
	}
	
	function getTooltip()
	{
		local result = this.weapon.getTooltip();
		result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Grants you the ability to \'Kick\', \'Push Through\' and \'Tackle\'"
		});	
		if (this.m.innateperk)
		{
			result.push({
				id = 6,
				type = "text",
				icon = "ui/icons/warning.png",
				text = "Even the most distinguished people can only master one skill"
			});
		}		
		return result;
	}	
	
	function onEquip()
	{
		this.weapon.onEquip();
		this.m.innateperk = false;		
		local skills = this.getContainer().getActor().getSkills().getAllSkillsOfType(this.Const.SkillType.Perk);
		foreach (s in skills)
		{
			if (s.getID().find("ptr_swordmaster_"))
			{
				this.m.innateperk = true;
			}		
		}
		
		local skillToAdd = this.new("scripts/skills/actives/overhead_strike");
		skillToAdd.setStunChance(this.m.StunChance);
		this.addSkill(skillToAdd);
		this.addSkill(this.new("scripts/skills/actives/split"));
		this.addSkill(this.new("scripts/skills/actives/swing"));
		local skillToAdd = this.new("scripts/skills/actives/split_shield");
		skillToAdd.setFatigueCost(skillToAdd.getFatigueCostRaw() + 5);
		this.addSkill(skillToAdd);
		
		if (!::Is_PTR_Exist || this.m.innateperk) return;				
		local skill = ::new("scripts/skills/perks/perk_ptr_swordmaster_grappler");
		skill.m.IsSerialized = false;
		this.addSkill(skill);		
	}

});

