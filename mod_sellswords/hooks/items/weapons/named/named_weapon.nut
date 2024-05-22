::mods_hookExactClass("items/weapons/named/named_weapon", function ( o ) {
	o.m.IsAllowedRandomizeValues <- true;

	o.randomizeValues = function ()
	{
		if (!this.m.IsAllowedRandomizeValues) return;

		if (this.m.ConditionMax > 1)
		{
			this.m.Condition = this.Math.round(this.m.Condition * this.Math.rand(90, 140) * 0.01) * 1.0;
			this.m.ConditionMax = this.m.Condition;
		}

		local available = [];
		available.push(function ( _i )
		{
			local f = this.Math.rand(110, 130) * 0.01;
			_i.m.RegularDamage = this.Math.round(_i.m.RegularDamage * f);
			_i.m.RegularDamageMax = this.Math.round(_i.m.RegularDamageMax * f);
		});
		available.push(function ( _i )
		{
			_i.m.ArmorDamageMult = _i.m.ArmorDamageMult + this.Math.rand(10, 30) * 0.01;
		});

		if (this.m.ChanceToHitHead > 0)
		{
			available.push(function ( _i )
			{
				_i.m.ChanceToHitHead = _i.m.ChanceToHitHead + this.Math.rand(10, 20);
			});
		}

		if (this.m.DirectDamageMult <= 0.9)
		{
			available.push(function ( _i )
			{
				_i.m.DirectDamageAdd = _i.m.DirectDamageAdd + this.Math.rand(8, 16) * 0.01;
			});
		}			

		if (this.m.StaminaModifier <= -10)
		{
			available.push(function ( _i )
			{
				_i.m.StaminaModifier = this.Math.round(_i.m.StaminaModifier * this.Math.rand(50, 80) * 0.01);
			});
		}

		if (this.m.ShieldDamage >= 16)
		{
			available.push(function ( _i )
			{
				_i.m.ShieldDamage = this.Math.round(_i.m.ShieldDamage * this.Math.rand(150, 200) * 0.01);
			});
		}

		if (this.m.AmmoMax > 0)
		{
			available.push(function ( _i )
			{
				_i.m.AmmoMax = _i.m.AmmoMax + this.Math.rand(1, 3);
				_i.m.Ammo = _i.m.AmmoMax;
			});
		}

		if (this.m.AdditionalAccuracy != 0 || this.isItemType(this.Const.Items.ItemType.RangedWeapon))
		{
			available.push(function ( _i )
			{
				_i.m.AdditionalAccuracy = _i.m.AdditionalAccuracy + this.Math.rand(5, 15);
			});
		}

		available.push(function ( _i )
		{
			_i.m.FatigueOnSkillUse = _i.m.FatigueOnSkillUse - this.Math.rand(1, 3);
		});

		for( local n = 2; n != 0 && available.len() != 0; n = n )
		{
			local r = this.Math.rand(0, available.len() - 1);
			available[r](this);
			available.remove(r);
			n = --n;
		}
	}
});	