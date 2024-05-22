this.cr_sword_butcher_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.cr_sword_butcher";
		this.m.Name = "Hidden Effect";
		this.m.Icon = "ui/perks/perk_20.png";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = false;		
		this.m.IsHidden = true;
	}	

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (!_targetEntity.isAlive() || _targetEntity.isDying()) return;

		if (!_targetEntity.getCurrentProperties().IsImmuneToBleeding && _damageInflictedHitpoints >= ::Const.Combat.MinDamageToApplyBleeding)
		{
			local actor = this.getContainer().getActor();
			local effect = this.new("scripts/skills/effects/bleeding_effect");
			effect.setDamage(10);

			if (actor.getFaction() == this.Const.Faction.Player)
			{
				effect.setActor(this.getContainer().getActor());
			}

			_targetEntity.getSkills().add(effect);
		}
	}
});

