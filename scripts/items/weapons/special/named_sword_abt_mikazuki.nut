this.named_sword_abt_mikazuki <- this.inherit("scripts/items/weapons/weapon", {
	m = {
	innateperk = false
	},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.named_sword_abt_mikazuki";
		this.m.Name = "Mikazuki, the Crescent Moon";
		this.m.Description = "A Shamshir already is an exquisite and exotic weapon in these parts, but this piece is of extraordinary quality. It will cut through flesh and bone just as easily as through a ripe melon.";
		this.m.WeaponType = this.Const.Items.WeaponType.Sword | this.Const.Items.WeaponType.Cleaver;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.OneHanded;
		this.m.IsDoubleGrippable = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.Value = 15000;
		this.m.Condition = 72.0;
		this.m.ConditionMax = 72.0;
		this.m.StaminaModifier = -8;
		this.m.RegularDamage = 55;
		this.m.RegularDamageMax = 60;
		this.m.ArmorDamageMult = 0.85;
		this.m.DirectDamageMult = 0.2;
		this.m.DirectDamageAdd = 0.1;		
		this.m.IconLarge = "weapons/melee/scimitar_01_named_02.png";
		this.m.Icon = "weapons/melee/scimitar_01_named_02_70x70.png";
		this.m.ArmamentIcon = "icon_scimitar_01_named_02";		
	}
	
	function getTooltip()
	{
		local result = this.weapon.getTooltip();
		result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Attacks inflict \'Bleeding\' on the target for [color=" + this.Const.UI.Color.NegativeValue + "]10[/color] damage"
		});		
		result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Grants \'Sanguinary\' and \'Bloodbath\'"
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
		//local skill = this.new("scripts/skills/actives/cleave");
		//skill.m.Icon = "skills/active_172.png";
		//skill.m.IconDisabled = "skills/active_172_sw.png";
		//skill.m.Overlay = "active_172";
		//this.addSkill(skill);	
		local skill = this.new("scripts/skills/actives/slash");
		skill.m.Icon = "skills/active_172.png";
		skill.m.IconDisabled = "skills/active_172_sw.png";
		skill.m.Overlay = "active_172";
		this.addSkill(skill);		
		this.addSkill(this.new("scripts/skills/actives/gash_skill"));
		this.addSkill(this.new("scripts/skills/actives/decapitate"));
		
		if (!::Is_PTR_Exist || this.m.innateperk) return;
		//if (!this.getContainer().getActor().getSkills().hasSkill("perk.ptr_swordlike"))
		//{
		//	local skill = ::new("scripts/skills/perks/perk_ptr_swordlike");
		//	skill.m.IsSerialized = false;
		//	this.addSkill(skill);
		//}		
		if (!this.getContainer().getActor().getSkills().hasSkill("perk.ptr_sanguinary"))
		{
			local skill = ::new("scripts/skills/perks/perk_ptr_sanguinary");
			skill.m.IsSerialized = false;
			this.addSkill(skill);
		}
		if (!this.getContainer().getActor().getSkills().hasSkill("perk.ptr_bloodbath"))
		{
			local skill = ::new("scripts/skills/perks/perk_ptr_bloodbath");
			skill.m.IsSerialized = false;
			this.addSkill(skill);
		}
		this.addSkill(this.new("scripts/skills/effects/cr_sword_butcher_effect"));			
	}	
});

