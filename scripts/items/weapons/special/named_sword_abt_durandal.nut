this.named_sword_abt_durandal <- this.inherit("scripts/items/weapons/weapon", {
	m = {
	innateperk = false
	},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.named_sword_abt_durandal";
		this.m.Name = "Durandal, the Enduring Flame";	
		this.m.Description = "This blade shows great craftmanship. It is certainly brutally efficient in cutting, but the simple design has also a subtlety that is easily overlooked.";
		this.m.WeaponType = this.Const.Items.WeaponType.Sword;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.IsAgainstShields = false;
		this.m.IsAoE = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.Value = 15000;
		this.m.Condition = 64.0;
		this.m.ConditionMax = 64.0;
		this.m.StaminaModifier = -10;
		this.m.RegularDamage = 85;
		this.m.RegularDamageMax = 110;
		this.m.ArmorDamageMult = 0.8;
		this.m.DirectDamageMult = 0.25;
		this.m.DirectDamageAdd = 0.05;			
		this.m.ChanceToHitHead = 35;
		this.m.IconLarge = "weapons/melee/longsword_01_named.png";
		this.m.Icon = "weapons/melee/longsword_01_named_70x70.png";
		this.m.ArmamentIcon = "icon_named_longsword_01";		
	}

	function getTooltip()
	{
		local result = this.weapon.getTooltip();
		result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Grants you the ability to charge towards a tile up to 2 tiles away, staggering all enemies adjacent to that tile and performing a free attack against a random enemy that does [color=" + this.Const.UI.Color.PositiveValue + "]50%[/color] increased damage"
		});
		result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Each single-target attack additionally does [color=" + this.Const.UI.Color.PositiveValue + "]50%[/color] of its damage to a random enemy adjacent to the target"
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
		this.addSkill(this.new("scripts/skills/actives/overhead_strike"));		
		local skillToAdd = this.new("scripts/skills/actives/slash");
		skillToAdd.m.isBunt = true;			
		skillToAdd.m.Name = "Bunt";		
		skillToAdd.m.Icon = "skills/active_bunt.png";
		skillToAdd.m.IconDisabled = "skills/active_bunt_sw.png";		
		skillToAdd.m.Overlay = "active_1";
		skillToAdd.m.FatigueCost = 13;	
		skillToAdd.m.DirectDamageMult = this.m.DirectDamageMult;		
		this.addSkill(skillToAdd);
		this.addSkill(this.new("scripts/skills/actives/split"));
		
		if (!::Is_PTR_Exist || this.m.innateperk) return;			
		this.addSkill(this.new("scripts/skills/actives/ptr_swordmaster_charge_skill"));		
		this.addSkill(this.new("scripts/skills/effects/cr_sword_jugg_effect"));			
	}	
});

