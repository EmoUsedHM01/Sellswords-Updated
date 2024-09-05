this.mod_ghost_depossess <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.ghost_depossess";
		this.m.Name = "Depossess";
		this.m.Description = "Leave your victim\'s body.";
		this.m.Icon = "skills/scry_skill.png";
		this.m.IconDisabled = "skills/scry_skill_bw.png";
		this.m.Overlay = "scry";
		this.m.SoundOnUse = [
			"sounds/combat/indomitable_01.wav",
			"sounds/combat/indomitable_02.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.Last;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = false;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 0;
		this.m.MinRange = 0;
		this.m.MaxRange = 0;
	}

	function getTooltip()
	{
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 3,
				type = "text",
				text = this.getCostString()
			},
		];
	}

	function isUsable()
	{
		return this.skill.isUsable() && this.getContainer().hasSkill("effects.ghost_possessed");
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		return true;
	}

	function onUse( _user, _targetTile )
	{
		this.getContainer().removeByID("effects.ghost_possessed");
		this.Tactical.TurnSequenceBar.initNextTurnBecauseOfWait();
		return true;
	}

});