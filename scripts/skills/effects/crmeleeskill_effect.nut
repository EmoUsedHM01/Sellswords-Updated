this.crmeleeskill_effect <- this.inherit("scripts/skills/skill", {
	m = {
        Inflicter = null,
        InflictedSkill = null,
        SkillProperties = null
	},
	function create()
	{
		this.m.ID = "effects.crmeleeskill";
		this.m.Name = "";
		this.m.Icon = "ui/perks/crmeleeskill.png";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = false;
        this.m.IsHidden = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function setSkill(_inflicter, _inflicted)
	{
		this.m.Inflicter = _inflicter;
		this.m.InflictedSkill = _inflicted;
		this.m.SkillProperties = _inflicted.getContainer().buildPropertiesForUse(_inflicted, this.getContainer().getActor());
	}

	function onDamageReceived( _attacker, _damageHitpoints, _damageArmor )
	{
		this.removeSelf();
	}
	
	function onRemoved()
	{
		if (this.getContainer().getActor() == null)
		{
			return;
		}
		local actor = this.getContainer().getActor();
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
			this.Tactical.EventLog.logEx(this.Const.UI.getColorizedEntityName(this.m.Inflicter) + " uses " + this.m.InflictedSkill.getName() + " and hits " + this.Const.UI.getColorizedEntityName(actor) + " (Chance: " + this.Math.min(95, this.Math.max(5, chance_to_hit)) + ", Rolled: " + rolled + ")");
			this.onScheduledTargetHit(info);
		}
		else
		{
			this.Tactical.EventLog.logEx(this.Const.UI.getColorizedEntityName(this.m.Inflicter) + " uses " + this.m.InflictedSkill.getName() + " and misses " + this.Const.UI.getColorizedEntityName(actor) + " (Chance: " + this.Math.min(95, this.Math.max(5, chance_to_hit)) + ", Rolled: " + rolled + ")");
		}
	}

});