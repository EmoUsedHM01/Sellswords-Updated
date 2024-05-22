::mods_hookExactClass("skills/actives/ptr_blitzkrieg_skill", function ( o )
{
	o.onUse = function ( _user, _targetTile )
	{
		this.m.IsSpent = true;
		if (_user.isPlayerControlled())
		{
			local rosterBros = this.World.getPlayerRoster().getAll();
			foreach (bro in rosterBros)
			{
				local skill = bro.getSkills().getSkillByID("actives.ptr_blitzkrieg");
				if (skill != null) skill.m.IsSpent = true;
			}
		}
		local bros = clone this.Tactical.Entities.getInstancesOfFaction(_user.getFaction());
		local sortByInitiative = function( _bro1, _bro2 )
		{
			local ini1 = _bro1.getInitiative();
			local ini2 = _bro2.getInitiative();

			if (ini1 > ini2) return -1;
			if (ini1 < ini2) return 1;
			return 0;
		}
		bros.sort(sortByInitiative);
		local myTile = _user.getTile();
		foreach (bro in bros)
		{
			if (bro.getMoraleState() == this.Const.MoraleState.Fleeing || bro.getCurrentProperties().IsStunned)
			{
				continue;
			}
			if (bro.getID() == _user.getID())
			{
				this.getContainer().add(this.new("scripts/skills/effects/adrenaline_effect"));
			}			
			else 
			{
				local skill = bro.getSkills().getSkillByID("actives.ptr_blitzkrieg");
				if (skill != null) skill.m.IsSpent = true;				
				if (bro.getTile().getDistanceTo(myTile) <= 4 && bro.getFatigueMax() - bro.getFatigue() >= 10)
				{
					bro.setFatigue(bro.getFatigue() + (bro.isPlayerControlled() ? 10 : 30));
					local effect = this.new("scripts/skills/effects/adrenaline_effect");				
					if (!bro.isTurnStarted() && !bro.isTurnDone())
					{
						effect.m.TurnsLeft++;
					}
					bro.getSkills().add(effect);
				}
			}
		}
	}
});	