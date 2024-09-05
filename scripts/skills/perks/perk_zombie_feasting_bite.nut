this.perk_zombie_feasting_bite <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.zombie_feasting_bite";
		this.m.Name = this.Const.Strings.PerkName.ZombieFeasting;
		this.m.Description = this.Const.Strings.PerkDescription.ZombieFeasting;
		this.m.Icon = "ui/perks/perk_zombie_feasting_bite.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (_skill == null || _damageInflictedHitpoints <= 0)
			return

		if (_skill.getID() != "actives.zombie_bite")
			return;

		local actor = this.m.Container.getActor();

		if (actor.getHitpoints() == actor.getHitpointsMax())
			return;

		local mult = this.Math.rand(33, 50) * 0.01;
		local heals = this.Math.min(actor.getHitpointsMax() - actor.getHitpoints(), this.Math.round(_damageInflictedHitpoints * mult))

		if (!actor.isHiddenToPlayer())
		{
			if (this.m.SoundOnUse.len() != 0)
				this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.RacialEffect, actor.getPos());

			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(actor) + " heals for " + heals + " points");
		}

		actor.setHitpoints(this.Math.min(actor.getHitpointsMax(), actor.getHitpoints() + this.Math.round(_damageInflictedHitpoints * mult)));
		actor.onUpdateInjuryLayer();
	}

});