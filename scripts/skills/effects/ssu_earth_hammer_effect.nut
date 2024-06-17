this.ssu_earth_hammer_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.ssu_earth_hammer";
		this.m.Name = " ";
		this.m.Description = " ";
		this.m.Icon = "";
		this.m.Type = this.Const.SkillType.Special | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.VeryLast;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = true;
	}

	function getTooltip()
	{
		return this.getDefaultTooltip();
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		local actor = this.getContainer().getActor().get();

		if (!actor.isAlive() || actor.isDying())
			return;

		if (!_targetEntity.isAlive() || _targetEntity.isDying() || _targetEntity.getSkills().getSkillByID("effects.rooted") || _targetEntity.getCurrentProperties().IsImmuneToRoot))
			return;

		if (!_targetEntity.isHiddenToPlayer())
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_targetEntity) + " is rooted");

		_targetEntity.getSkills().add(this.new("scripts/skills/effects/rooted_effect"));
		local breakFree = this.new("scripts/skills/actives/break_free_skill");
		breakFree.setDecal("roots_destroyed");
		breakFree.m.Icon = "skills/active_75.png";
		breakFree.m.IconDisabled = "skills/active_75_sw.png";
		breakFree.m.Overlay = "active_75";
		breakFree.m.SoundOnUse = this.m.SoundOnHitHitpoints;
		_targetEntity.getSkills().add(breakFree);
		_targetEntity.raiseRootsFromGround("bust_roots", "bust_roots_back");
	}

});