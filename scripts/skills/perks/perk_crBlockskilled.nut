this.perk_crBlockskilled <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.crBlockskilled";
		this.m.Name = this.Const.Strings.PerkName.crBlockskilled;
		this.m.Description = "You are poised to block enemies' melee attack";
		this.m.Icon = "ui/perks/crBlocknormal.png";			
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		if (_attacker != null && _attacker.getID() == this.getContainer().getActor().getID() || _skill == null || !_skill.isAttack() || _skill.isRanged() || !_skill.isUsingHitchance())
		{
			return;
		}

		local Roll = this.Math.rand(1, 100);		
		local ourMeleeskill = this.getContainer().getActor().getCurrentProperties().getMeleeSkill();
		local enemyCurrentMeleeskill = _attacker.getCurrentProperties().getMeleeSkill();
		local bonus = 1;

		if (Roll * ourMeleeskill >= 100 * enemyCurrentMeleeskill)
		{
			bonus = 65;
		}
		else
		{
			bonus = this.Math.floor(0.3 * Roll * ourMeleeskill / enemyCurrentMeleeskill);
		}		

		_properties.DamageReceivedTotalMult *= (1 - 0.01 * bonus);
		//this.logInfo("bonus: " + bonus);
		
		if (bonus >= 10)
		{
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(this.getContainer().getActor()) + " blocks the attack reducing [color=" + this.Const.UI.Color.NegativeValue + "]" + bonus + "%[/color] damage!");
		}
	}

});

