this.dryad_racial <- this.inherit("scripts/skills/skill", {
	m = {
		BonusArmor = 30
	},
	function create()
	{
		this.m.ID = "racial.dryad";
		this.m.Name = "";
		this.m.Description = "";
		this.m.Icon = "skills/status_effect_86.png";
		this.m.IconMini = "status_effect_86_mini";
		this.m.SoundOnUse = [];
		this.m.Type = this.Const.SkillType.Racial | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Last;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = true;
	}

	function onAdded()
	{
		if (!this.m.IsNew)
		{
			return;
		}

		local b = this.getContainer().getActor().getBaseProperties();
		b.Armor[0] += this.m.BonusArmor;
		b.ArmorMax[0] += this.m.BonusArmor;
		b.Armor[1] += this.m.BonusArmor;
		b.ArmorMax[1] += this.m.BonusArmor;
		this.m.IsNew = false;
	}

	function onRemoved()
	{
		local b = this.getContainer().getActor().getBaseProperties();
		b.Armor[0] = ::Math.max(0, b.Armor[0] - this.m.BonusArmor);
		b.ArmorMax[0] = ::Math.max(0, b.ArmorMax[0] - this.m.BonusArmor);
		b.Armor[1] = ::Math.max(0, b.Armor[1] - this.m.BonusArmor);
		b.ArmorMax[1] = ::Math.max(0, b.ArmorMax[1] - this.m.BonusArmor);
	}
	
	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		switch(_hitInfo.DamageType)
		{
		case this.Const.Damage.DamageType.Piercing:
		if (_skill == null)
		{
			_properties.DamageReceivedRegularMult *= 0.25;
		}
		else if (_skill.isRanged())
		{
			local weapon = _skill.getItem();

			if (weapon != null && weapon.isItemType(this.Const.Items.ItemType.Weapon))
			{
				if (weapon.isWeaponType(this.Const.Items.WeaponType.Bow) || weapon.isWeaponType(this.Const.Items.WeaponType.Crossbow))
				{
					_properties.DamageReceivedRegularMult *= 0.25;
				}
				else if (weapon.isWeaponType(this.Const.Items.WeaponType.Throwing))
				{
					_properties.DamageReceivedRegularMult *= 0.5;
				}
				else
				{
					_properties.DamageReceivedRegularMult *= 0.5;
				}
			}
			else
			{
				_properties.DamageReceivedRegularMult *= 0.2;
			}
		}
		break;

		case this.Const.Damage.DamageType.Burning:
			_properties.DamageReceivedRegularMult *= 2.0;
		break;
		}
	}

});

