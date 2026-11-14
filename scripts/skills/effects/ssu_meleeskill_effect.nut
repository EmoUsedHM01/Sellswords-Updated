this.ssu_meleeskill_effect <- this.inherit("scripts/skills/skill", {
	m = {
		Inflicter = null,
		InflictedSkill = null,
		SkillProperties = null
	},
	function create()
	{
		this.m.ID = "effects.ssu_meleeskill";
		this.m.Name = "";
		this.m.Icon = "ui/perks/ssu_meleeskill.png";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function setSkill(_inflicter, _inflicted, _targetEntity)
	{
		this.m.Inflicter = _inflicter;
		this.m.InflictedSkill = _inflicted;
		this.m.SkillProperties = _inflicted.getContainer().buildPropertiesForUse(_inflicted, _targetEntity);
	}
	
	function onRemoved()
	{
		local actor = this.getContainer().getActor();
		if (actor == null)
		{
			return;
		}

		if (!actor.isAlive() || actor.isDying())
		{
			return;
		}

		this.m.SkillProperties.DamageTotalMult *= 0.2;
		local chance_to_hit = this.m.InflictedSkill.getHitchance(actor);
		local rolled = Math.rand(1,100);
		local info = {
			Skill = this.m.InflictedSkill,
			Container = this.getContainer(),
			User = this.m.Inflicter,
			TargetEntity = actor,
			Properties = this.m.SkillProperties,
			DistanceToTarget = this.m.Inflicter.getTile().getDistanceTo(actor.getTile())
		};

		if (rolled <= chance_to_hit)
		{
			this.Tactical.EventLog.logEx(::Mod_Sellswords.text(::Mod_Sellswords.Strings.ssu_meleeskill_effect.Log1, this.Const.UI.getColorizedEntityName(this.m.Inflicter), this.m.InflictedSkill.getName(), this.Const.UI.getColorizedEntityName(actor), this.Math.min(95, this.Math.max(5, chance_to_hit)), rolled));
			this.onScheduledTargetHit(info);
		}

		else
		{
			this.Tactical.EventLog.logEx(::Mod_Sellswords.text(::Mod_Sellswords.Strings.ssu_meleeskill_effect.Log2, this.Const.UI.getColorizedEntityName(this.m.Inflicter), this.m.InflictedSkill.getName(), this.Const.UI.getColorizedEntityName(actor), this.Math.min(95, this.Math.max(5, chance_to_hit)), rolled));
		}
	}

});