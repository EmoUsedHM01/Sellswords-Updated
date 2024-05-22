this.pseudohack <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.pseudohack";
		this.m.Name = "Hack";
		this.m.Description = "A powerful chopping attack that bears full force on any target.";
		this.m.KilledString = "Hacked";
		this.m.Icon = "skills/active_25.png";
		this.m.IconDisabled = "skills/active_25_sw.png";
		this.m.Overlay = "active_25";
		this.m.SoundOnUse = [
			"sounds/combat/chop_01.wav",
			"sounds/combat/chop_02.wav",
			"sounds/combat/chop_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/chop_hit_01.wav",
			"sounds/combat/chop_hit_02.wav",
			"sounds/combat/chop_hit_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsIgnoredAsAOO = false;
		this.m.IsWeaponSkill = true;
		this.m.InjuriesOnBody = this.Const.Injury.CuttingBody;
		this.m.InjuriesOnHead = this.Const.Injury.CuttingHead;
		this.m.DirectDamageMult = 0.4;
		this.m.ActionPointCost = 2;
		this.m.FatigueCost = 5;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.ChanceDecapitate = 25;
		this.m.ChanceDisembowel = 25;
		this.m.ChanceSmash = 0;
	}

	function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		ret.extend([
			{
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Inflicts additional [color=" + this.Const.UI.Color.PositiveValue + "]50%[/color] damage on a hit to the head"
			}
		]);
		return ret;
	}

	function isHidden()
	{
		return !this.getContainer().hasSkill("actives.barbarian_fury");
	}	
	
	function onAfterUpdate( _properties )
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInAxes ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
	}

	function onUse( _user, _targetTile )
	{
		this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectChop);
		return this.attackEntity(_user, _targetTile.getEntity());
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.DamageTotalMult *= 0.6;		
			_properties.DamageAgainstMult[this.Const.BodyPart.Head] += 0.35;
		}
	}

});

