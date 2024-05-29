::mods_hookExactClass("skills/perks/perk_legend_escape_artist", function (o)
{
	//Autobreak free on turn start
	o.onTurnStart <- function()
	{
		local _user = this.getContainer().getActor();
		if ( !_user.getSkills().hasSkill("effects.net")
			&& !_user.getSkills().hasSkill("effects.rooted")
			&& !_user.getSkills().hasSkill("effects.web")
			&& !_user.getSkills().hasSkill("effects.kraken_ensnare")
			&& !_user.getSkills().hasSkill("effects.serpent_ensnare") ) return;

		local skill = _user.getCurrentProperties().getMeleeSkill();
		local toHit = this.Math.min(100, skill - 10);
		local rolled = this.Math.rand(1, 100);

		if (rolled <= toHit)
		{
			this.Tactical.EventLog.logEx(::Const.UI.getColorizedEntityName(_user) + " breaks free (Chance: " + toHit + ", Rolled: " + rolled + ")");

			local SoundOnHitHitpoints = [
				"sounds/combat/break_free_net_01.wav",
				"sounds/combat/break_free_net_02.wav",
				"sounds/combat/break_free_net_03.wav"
			];
			this.Sound.play(SoundOnHitHitpoints[this.Math.rand(0, SoundOnHitHitpoints.len() - 1)], ::Const.Sound.Volume.Skill, _user.getTile().Pos);

			_user.getSprite("status_rooted").Visible = false;
			_user.getSprite("status_rooted_back").Visible = false;

			local breakfree_decal = _user.getSkills().getSkillByID("actives.break_free").m.Decal;
			if (breakfree_decal != "")
			{
				local ourTile = _user.getTile();
				local candidates = [];

				if (ourTile.Properties.has("IsItemSpawned") || ourTile.IsCorpseSpawned)
				{
					for( local i = 0; i < ::Const.Direction.COUNT; i = i )
					{
						if (!ourTile.hasNextTile(i))
						{
						}
						else
						{
							local tile = ourTile.getNextTile(i);

							if (tile.IsEmpty && !tile.Properties.has("IsItemSpawned") && !tile.IsCorpseSpawned && tile.Level <= ourTile.Level + 1)
							{
								candidates.push(tile);
							}
						}

						i = ++i;
					}
				}
				else
				{
					candidates.push(ourTile);
				}

				if (candidates.len() != 0)
				{
					local tileToSpawnAt = candidates[this.Math.rand(0, candidates.len() - 1)];
					tileToSpawnAt.spawnDetail(breakfree_decal);
					tileToSpawnAt.Properties.add("IsItemSpawned");
				}
			}

			_user.setDirty(true);
			this.getContainer().removeByID("effects.net");
			this.getContainer().removeByID("effects.rooted");
			this.getContainer().removeByID("effects.web");
			this.getContainer().removeByID("effects.kraken_ensnare");
			this.getContainer().removeByID("effects.serpent_ensnare");
			this.getContainer().removeByID("actives.break_free");
			return true;
		}
		else
		{
			this.Tactical.EventLog.logEx(::Const.UI.getColorizedEntityName(_user) + " fails to break free (Chance: " + toHit + ", Rolled: " + rolled + ")");

			if (this.m.SoundOnMiss.len() != 0)
			this.Sound.play(this.m.SoundOnMiss[this.Math.rand(0, this.m.SoundOnMiss.len() - 1)], ::Const.Sound.Volume.Skill, _user.getTile().Pos);
		}

	}

});