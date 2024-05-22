this.goblin_axe <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.goblin_axe";
		this.m.Name = "Raider Axe";
		this.m.Description = "A cruel and crude axe forged en masse by goblin hordes.";
		this.m.IconLarge = "weapons/melee/goblin_weapon_05.png";
		this.m.Icon = "weapons/melee/goblin_weapon_05_70x70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Axe;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.AddGenericSkill = true;		
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_goblin_weapon_05";
		this.m.Value = 1200;
		this.m.Condition = 60.0;
		this.m.ConditionMax = 60.0;
		this.m.StaminaModifier = -12;
		this.m.RegularDamage = 35;
		this.m.RegularDamageMax = 50;
		this.m.ArmorDamageMult = 1.1;
		this.m.DirectDamageMult = 0.35;
		this.m.FatigueOnSkillUse -= 2;		
	}
	
	function getTooltip()
	{
		local ret = this.weapon.getTooltip();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/action_points.png",
			text = "Melee attacks cost [color=" + this.Const.UI.Color.PositiveValue + "]-1[/color] Action Point"
		});
		return ret;
	}	

	function onEquip()
	{
		this.weapon.onEquip();
		local chop = this.new("scripts/skills/actives/chop");
		chop.m.DirectDamageMult = this.m.DirectDamageMult;	
		chop.m.infantry = true;		
		chop.m.Icon = "skills/active_79.png";
		chop.m.IconDisabled = "skills/active_79_sw.png";
		chop.m.Overlay = "active_79";
		this.addSkill(chop);
		local splitman = this.new("scripts/skills/actives/split_man");				
		splitman.m.DirectDamageMult = this.m.DirectDamageMult;
		splitman.m.infantry = 1;		
		this.addSkill(splitman);
	}
	
	function onAfterUpdateProperties( _properties )	
	{
		if (!this.getContainer().getActor().getSkills().hasSkill("racial.ptr_goblin"))
		{
			local skills = this.getSkills();
			foreach (s in skills)
			{
				if (s.isAttack() && !s.isRanged())
				{
					s.m.ActionPointCost -= 1;
				}						
			}
		}	
	}			
});

