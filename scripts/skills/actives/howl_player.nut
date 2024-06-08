this.howl_player <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.howl_player";
		this.m.Name = "Howl";
		this.m.Description = "Let loose a howl, boosting the morale of all allied direwolves within 6 tiles.";
		this.m.Icon = "skills/active_22.png";
		this.m.IconDisabled = "skills/active_22_sw.png";
		this.m.Overlay = "active_22";
		this.m.SoundOnUse = [
			"sounds/enemies/werewolf_howl.wav"
		];
		this.m.Type = this.Const.SkillType.Active | this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.IsRemovedAfterBattle = false;
		this.m.IsSerialized = true;
		this.m.IsActive = true;
		this.m.IsTargeted = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
		this.m.IsAttack = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 20;
		this.m.MinRange = 0;
		this.m.MaxRange = 0;
	}

	function getTooltip()
	{
		local p = this.getContainer().getActor().getCurrentProperties();
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
			}
		];
	}

	function raiseMorale( _actor, _tag )
	{
		this.logInfo("Checking actor: " + _actor.getName());
		if (_actor.getFaction() == _tag.Self.getFaction() && _actor.getFlags().has("werewolf"))
		{
			_actor.setMoraleState(this.Math.min(this.Const.MoraleState.Confident, _actor.getMoraleState() + 1))
			_tag.Skill.spawnIcon("status_effect_06", _actor.getTile());
		}
	}

	function onUse( _user, _targetTile )
	{
		this.result <- {
			Self = _user,
			Skill = this
		};
		this.Tactical.queryActorsInRange(_user.getTile(), 1, 6, this.raiseMorale, this.result);
		return true;
	}

});

