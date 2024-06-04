this.twinaxes_t1 <- this.inherit("scripts/items/weapons/weapon", {
	m = {
	LastSkillUse = 0
	},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.twinaxes_t1";
		this.m.Name = "Twinned Crude Axes";
		this.m.Description = "A unique way of northern fighting, maybe holding these two rusty axes in each hand is a good idea? It seemed effective enough when used against you.";
		this.m.Categories = "Axe, Two-Handed";
		this.m.IconLarge = "weapons/melee/kuangzhanshishuangfu03.png";
		this.m.Icon = "weapons/melee/kuangzhanshishuangfu03_70.png";
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.IsAgainstShields = true;
		this.m.IsAoE = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "yemanrenshuangfu3";
		this.m.Value = 1400;
		this.m.ShieldDamage = 24;
		this.m.Condition = 72.0;
		this.m.ConditionMax = 72.0;
		this.m.StaminaModifier = -16;
		this.m.RegularDamage = 45;
		this.m.RegularDamageMax = 60;
		this.m.ArmorDamageMult = 1.2;
		this.m.DirectDamageMult = 0.40;
		this.m.ChanceToHitHead = 0;
		this.m.FatigueOnSkillUse = 1;		
	}

	function onEquip()
	{
		this.weapon.onEquip();
		//this.addSkill(this.new("scripts/skills/actives/pseudohack"));
		this.addSkill(this.new("scripts/skills/actives/twinaxes_1"));		
		this.addSkill(this.new("scripts/skills/actives/twinaxes_2"));
		local skillToAdd = this.new("scripts/skills/actives/split_shield");
		skillToAdd.setApplyAxeMastery(true);
		skillToAdd.setFatigueCost(skillToAdd.getFatigueCostRaw() + 1);
		this.addSkill(skillToAdd);
	}
  
	function onDamageDealt( _target, _skill, _hitInfo )
	{
		local actor = this.getContainer().getActor();

		if (actor == null || actor.isNull() || this.m.LastSkillUse == this.Const.SkillCounter)
		{
			return;
		}

		if (actor.isPlayerControlled() && _skill.getDirectDamage() < 1.0 && !_skill.isRanged() && this.m.ConditionMax > 1)
		{
			this.m.LastSkillUse = this.Const.SkillCounter;

			if (_target.getArmorMax(_hitInfo.BodyPart) >= 50 && _hitInfo.DamageInflictedArmor >= 5 || this.m.ConditionMax == 2)
			{
				this.lowerCondition();
			}
		}
	}
  
});

