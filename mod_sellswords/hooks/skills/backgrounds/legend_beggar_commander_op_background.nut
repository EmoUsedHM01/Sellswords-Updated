::mods_hookExactClass("skills/backgrounds/legend_beggar_commander_op_background", function ( o )
{
	o.onTargetKilled = function ( _targetEntity, _skill )
	{
		local actor = this.getContainer().getActor();

		if (actor.isAlliedWith(_targetEntity))
		{
			return;
		}

		actor.getBaseProperties().Hitpoints += actor.getBaseProperties().Hitpoints < _targetEntity.getBaseProperties().Hitpoints ? 1 : 0;
		actor.getBaseProperties().Bravery += actor.getBaseProperties().Bravery < _targetEntity.getBaseProperties().Bravery ? 1 : 0;
		actor.getBaseProperties().Stamina += actor.getBaseProperties().Stamina < _targetEntity.getBaseProperties().Stamina ? 1 : 0;
		actor.getBaseProperties().MeleeSkill += actor.getBaseProperties().MeleeSkill < _targetEntity.getBaseProperties().MeleeSkill ? 1 : 0;
		actor.getBaseProperties().RangedSkill += actor.getBaseProperties().RangedSkill < _targetEntity.getBaseProperties().RangedSkill ? 1 : 0;
		actor.getBaseProperties().MeleeDefense += actor.getBaseProperties().MeleeDefense < _targetEntity.getBaseProperties().MeleeDefense ? 1 : 0;
		actor.getBaseProperties().RangedDefense += actor.getBaseProperties().RangedDefense < _targetEntity.getBaseProperties().RangedDefense ? 1 : 0;
		actor.getBaseProperties().Initiative += actor.getBaseProperties().Initiative < _targetEntity.getBaseProperties().Initiative ? 1 : 0;
		local beggar_skills = actor.getSkills().getSkillsByFunction(function ( skill )
		{
			return skill.isType(::Const.SkillType.Perk);
		});
		beggar_skills = beggar_skills.len();

		if (beggar_skills >= 50)
		{
			if (this.Math.rand(1, 100) <= beggar_skills && this.Math.rand(1, 100) >= 5)
			{
				return;
			}
		}

		local target_skills = _targetEntity.getSkills().getSkillsByFunction(function ( skill )
		{
			return skill.isType(::Const.SkillType.Perk);
		});
		local potentialPerks = [];

		foreach( perk in target_skills )
		{
			local id = perk.getID();

			if (id == "perk.stalwart" || id == "perk.legend_composure" || id == "perk.battering_ram" || id == "perk.crGrandslam")
			{
				continue;
			}

			if (!actor.getSkills().hasSkill(id))
			{
				potentialPerks.push(perk);
			}
		}

		if (potentialPerks.len() == 0)
		{
			return;
		}

		local perk = potentialPerks[this.Math.rand(0, potentialPerks.len() - 1)];

		foreach( i, v in this.Const.Perks.PerkDefObjects )
		{
			if (perk.getID() == v.ID)
			{
				if (v.Script != "")
				{
					this.Tactical.EventLog.log("The framed beggar learned [color=" + this.Const.UI.Color.NegativeValue + "]" + perk.getName() + "[/color] from " + _targetEntity.getName());
					actor.getSkills().add(this.new(v.Script));
					local rowToAddPerk = 0;
					local length = actor.getBackground().getPerkTree()[0].len();

					foreach( i, row in actor.getBackground().getPerkTree() )
					{
						if (row.len() < length)
						{
							rowToAddPerk = i;
						}
					}

					actor.getBackground().addPerk(i, rowToAddPerk);
					break;
				}
			}
		}
	};
});