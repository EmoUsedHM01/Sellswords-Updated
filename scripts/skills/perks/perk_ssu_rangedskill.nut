this.perk_ssu_rangedskill <- this.inherit("scripts/skills/skill", {
	m = {
		KillCount = 0
	},
	function create()
	{
		this.m.ID = "perk.ssu_rangedskill";
		this.m.Name = this.Const.Strings.PerkName.SsuRangedskill;
		this.m.Description = this.Const.Strings.PerkDescription.SsuRangedskill;
		this.m.Icon = "ui/perks/ssu_rangedskill.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		_properties.HitChance[::Const.BodyPart.Head] += 5;
		_properties.HitChance[::Const.BodyPart.Head] += this.m.KillCount;
	}

	function onTargetKilled( _targetEntity, _skill ) 
	{
		local actor = this.getContainer().getActor().get();

		if (_skill.isAttack() && _skill.isRanged()) 
		{
			local entityType = _targetEntity.getType();
			foreach (type in ::Mod_Sellswords.RangedEnemies)
			{
				if (entityType == type) 
				{
					this.m.KillCount += 1;
					break;
				}
			}
		}
	}

	function onSerialize( _out )
	{
		this.skill.onSerialize(_out);
		_out.writeU32(this.m.KillCount);
	}

	function onDeserialize( _in )
	{
		this.skill.onDeserialize(_in);
		this.m.KillCount = _in.readU32();
	}

});