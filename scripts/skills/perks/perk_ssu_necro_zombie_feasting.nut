this.perk_ssu_necro_zombie_feasting <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.ssu_necro_zombie_feasting";
		this.m.Name = this.Const.Strings.PerkName.SsuNecroZombieFeasting;
		this.m.Description = this.Const.Strings.PerkDescription.SsuNecroZombieFeasting;
		this.m.Icon = "ui/perks/ssu_necro_zombie_feasting.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (_skill == null || _damageInflictedHitpoints <= 0)
			return;

		if (_skill.getID() != "actives.zombie_bite")
			return;

		local actor = this.m.Container.getActor();

		if (actor.getHitpoints() == actor.getHitpointsMax())
			return;

		local mult = this.Math.rand(33, 50) * 0.01;
		local heals = this.Math.min(actor.getHitpointsMax() - actor.getHitpoints(), this.Math.round(_damageInflictedHitpoints * mult));

		if (!actor.isHiddenToPlayer())
		{
			if (this.m.SoundOnUse.len() != 0)
				this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.RacialEffect, actor.getPos());

			this.Tactical.EventLog.log(::Mod_Sellswords.text(::Mod_Sellswords.Strings.perk_ssu_necro_zombie_feasting.Log, this.Const.UI.getColorizedEntityName(actor), heals));
		}

		actor.setHitpoints(this.Math.min(actor.getHitpointsMax(), actor.getHitpoints() + this.Math.round(_damageInflictedHitpoints * mult)));
		actor.onUpdateInjuryLayer();
	}

});