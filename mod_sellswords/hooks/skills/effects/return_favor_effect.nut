::mods_hookExactClass("skills/effects/return_favor_effect", function(o) {
	o.onMissed = function( _attacker, _skill )
	{
		if (!_skill.isRanged())
		{
			local actor = this.getContainer().getActor();
			local weapon = actor.getMainhandItem();
			if (weapon != null && !weapon.isItemType(::Const.Items.ItemType.MeleeWeapon)) return;

			local distance = _attacker.getTile().getDistanceTo(actor.getTile());
			if (distance == 1 || (weapon != null && weapon.getRangeMax() >= distance))
			{
				local r = ::Math.rand(1, 100);

				if (r <= 10 && !_attacker.getCurrentProperties().IsImmuneToStun)
				{
					local effect = ::new("scripts/skills/effects/stunned_effect");
					effect.addTurns(1);
					_attacker.getSkills().add(effect);
					if (!actor.isHiddenToPlayer() && _attacker.getTile().IsVisibleForPlayer)
					{
						::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(actor) + " has stunned " + this.Const.UI.getColorizedEntityName(_attacker) + " for one turn");
					}
				}
				else if (r <= 50 && !_attacker.getCurrentProperties().IsImmuneToStun)
				{
					_attacker.getSkills().add(::new("scripts/skills/effects/dazed_effect"));
					if (!actor.isHiddenToPlayer() && _attacker.getTile().IsVisibleForPlayer)
					{
						::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(actor) + " has dazed " + this.Const.UI.getColorizedEntityName(_attacker) + " for one turn");
					}
				}
				else if (r <= 75)
				{
					_attacker.getSkills().add(::new("scripts/skills/effects/staggered_effect"));
					if (!actor.isHiddenToPlayer() && _attacker.getTile().IsVisibleForPlayer)
					{
						::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(actor) + " has staggered " + this.Const.UI.getColorizedEntityName(_attacker) + " for one turn");
					}
				}
			}
		}
	}
})	