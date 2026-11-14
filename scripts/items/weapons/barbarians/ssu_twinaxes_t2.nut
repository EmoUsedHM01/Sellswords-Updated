this.ssu_twinaxes_t2 <- this.inherit("scripts/items/weapons/weapon", {
	m = {
		LastSkillUse = 0
	},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.ssu_twinaxes_t2";
		this.m.Name = ::Mod_Sellswords.Strings.ssu_twinaxes_t2.Name;
		this.m.Description = ::Mod_Sellswords.Strings.ssu_twinaxes_t2.Description;
		this.m.Categories = ::Mod_Sellswords.Strings.ssu_twinaxes_t2.Categories;
		this.m.IconLarge = "weapons/melee/ssu_berserker_twinaxes_02.png";
		this.m.Icon = "weapons/melee/ssu_berserker_twinaxes_02_70.png";
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.IsAgainstShields = true;
		this.m.IsAoE = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "ssu_barbarian_twinaxes2";
		this.m.Value = 1800;
		this.m.ShieldDamage = 28;
		this.m.Condition = 80.0;
		this.m.ConditionMax = 80.0;
		this.m.StaminaModifier = -20;
		this.m.RegularDamage = 55;
		this.m.RegularDamageMax = 75;
		this.m.ArmorDamageMult = 1.3;
		this.m.DirectDamageMult = 0.4;
		this.m.ChanceToHitHead = 0;
		this.m.FatigueOnSkillUse = 2;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/ssu_twinaxes_1"));
		this.addSkill(this.new("scripts/skills/actives/ssu_twinaxes_2"));
		local skillToAdd = this.new("scripts/skills/actives/split_shield");
		skillToAdd.setApplyAxeMastery(true);
		skillToAdd.setFatigueCost(skillToAdd.getFatigueCostRaw() + 2);
		this.addSkill(skillToAdd);
	}

	function onDamageDealt( _target, _skill, _hitInfo )
	{
		local actor = this.getContainer().getActor();

		if (actor == null || actor.isNull() || this.m.LastSkillUse == this.Const.SkillCounter)
			return;

		if (actor.isPlayerControlled() && _skill.getDirectDamage() < 1.0 && !_skill.isRanged() && this.m.ConditionMax > 1)
		{
			this.m.LastSkillUse = this.Const.SkillCounter;

			if (_target.getArmorMax(_hitInfo.BodyPart) >= 50 && _hitInfo.DamageInflictedArmor >= 5 || this.m.ConditionMax == 2)
				this.lowerCondition();
		}
	}
  
});