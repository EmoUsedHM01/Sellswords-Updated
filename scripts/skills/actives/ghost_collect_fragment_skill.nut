this.ghost_collect_fragment_skill <- ::inherit("scripts/skills/skill", {
	m = {
		IsSpent = false
	},
	function create()
	{
		this.m.ID = "actives.ghost_collect_fragment";
		this.m.Name = "";
		this.m.Description = "";
		this.m.Icon = "";
		this.m.IconDisabled = "";
		this.m.Overlay = "demon_hound_bite_effect";
		this.m.SoundOnUse = [
			"sounds/enemies/dlc6/lich_death_01.wav"
		];
		this.m.Delay = 1000;
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.NonTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = false;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.ActionPointCost = 0;
		this.m.FatigueCost = 0;
		this.m.MinRange = 0;
		this.m.MaxRange = 0;
	}

	function onTurnStart()
	{
		this.m.IsSpent = false;
	}

	function isUsable()
	{
		return this.skill.isUsable() && !this.m.IsSpent && this.getContainer().getActor().canReturnFragment();
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		return true;
	}

	function onUse( _user, _targetTile )
	{
		if (!_user.isHiddenToPlayer())
			::Tactical.EventLog.logEx(::Const.UI.getColorizedEntityName(_user) + "\'s fragments return to itself");

		local totalHP = 0;
		local time = ::Time.getRound();
		foreach (a in ::Tactical.Entities.getInstancesOfFaction(_user.getFaction()))
		{
			if (a.getFlags().has("ghost_fragment") && a.getFlags().getAsInt("return") <= time)
			{
				totalHP += a.getHitpoints();
				a.m.XP = 0; // to make sure player can't get morale boost
				a.kill(null, null, ::Const.FatalityType.Suicide, true);
			}
		}

		_user.setHitpoints(::Math.min(_user.getHitpointsMax(), _user.getHitpoints() + totalHP));
		this.m.IsSpent = true;
		return true;
	}

});