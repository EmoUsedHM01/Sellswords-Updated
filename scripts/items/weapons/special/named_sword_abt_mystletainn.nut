this.named_sword_abt_mystletainn <- this.inherit("scripts/items/weapons/weapon", {
	m = {
	innateperk = false
	},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.named_sword_abt_mystletainn";
		this.m.Name = "Mystletainn, the Mistletoe";
		this.m.Description = "Crafting a proper fencing sword, both delicate and flexible, is no less difficult than wielding it. The smith that brought this particular weapon into existence must have been among the best in his trade.";
		this.m.WeaponType = this.Const.Items.WeaponType.Sword;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.OneHanded;
		this.m.IsDoubleGrippable = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.Condition = 56.0;
		this.m.ConditionMax = 56.0;
		this.m.StaminaModifier = -4;
		this.m.Value = 15000;
		this.m.RegularDamage = 40;
		this.m.RegularDamageMax = 60;
		this.m.ArmorDamageMult = 0.3;
		this.m.DirectDamageMult = 0.25;
		this.m.DirectDamageAdd = 0.45;	
		this.m.ChanceToHitHead = -25;		
		this.m.IconLarge = "weapons/melee/sword_fencing_01_named_01.png";
		this.m.Icon = "weapons/melee/sword_fencing_01_named_01_70x70.png";
		this.m.ArmamentIcon = "icon_fencing_sword_01_named_01";		
	}

	function getTooltip()
	{
		local result = this.weapon.getTooltip();
		result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Gain additional [color=" + this.Const.UI.Color.PositiveValue + "]10[/color] melee skill and [color=" + this.Const.UI.Color.PositiveValue + "]20%[/color] armor penetration"
		});		
		result.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "The efficacy of the target\'s remaining armor after an attack to reduce received Hitpoints damage is halved"
		});
		result.push({
			id = 8,
			type = "text",
			icon = "ui/icons/special.png",
			text = "The efficacy of the target\'s remaining armor after an attack to reduce received Hitpoints damage is halved"
		});
		if (this.m.innateperk)
		{
			result.push({
				id = 9,
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
		
		this.addSkill(this.new("scripts/skills/actives/bf_sword_thrust_skill"));
		this.addSkill(this.new("scripts/skills/actives/lunge_skill"));
		this.addSkill(this.new("scripts/skills/actives/riposte"));
		if (this.m.innateperk) return;			
		this.addSkill(this.new("scripts/skills/effects/cr_sword_precise_effect"));		
	}
	
});

