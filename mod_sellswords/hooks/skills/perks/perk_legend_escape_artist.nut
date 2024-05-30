::Mod_Sellswords.HooksMod.hook("scripts/skills/perks/perk_legend_escape_artist", function ( q ) {

	// Getting the skill effects that net you
	q.hasAnySkill <- function( user, skillsToCheck )
	{
	    foreach (skill in skillsToCheck)
	        if (user.getSkills().hasSkill(skill))
	            return true;

	    return false;
	}

	// Removing said skills
	q.removeSkills <- function( container, skillsToCheck )
	{
	    foreach (skill in skillsToCheck)
	        container.removeByID(skill);
	}

	// Autobreak free on turn start
	q.onTurnStart <- function()
	{
	    local _user = this.getContainer().getActor();
	    local skillsToCheck = [
	        "effects.net", 
	        "effects.rooted", 
	        "effects.web", 
	        "effects.kraken_ensnare", 
	        "effects.serpent_ensnare"
	    ];

	    if (!hasAnySkill(_user, skillsToCheck))
	        return;

	    local toHit = this.Math.min(100, 95);
	    local rolled = this.Math.rand(1, 100);

	    if (rolled <= toHit) {
	        this.Tactical.EventLog.logEx(::Const.UI.getColorizedEntityName(_user) + " breaks free (Chance: " + toHit + ", Rolled: " + rolled + ")");

	        local soundFiles = [
	            "sounds/combat/break_free_net_01.wav",
	            "sounds/combat/break_free_net_02.wav",
	            "sounds/combat/break_free_net_03.wav"
	        ];
	        this.Sound.play(soundFiles[this.Math.rand(0, soundFiles.len() - 1)], ::Const.Sound.Volume.Skill, _user.getTile().Pos);

	        _user.getSprite("status_rooted").Visible = false;
	        _user.getSprite("status_rooted_back").Visible = false;

	        local breakfreeDecal = _user.getSkills().getSkillByID("actives.break_free").m.Decal;
	        if (breakfreeDecal != "") {
	            local ourTile = _user.getTile();
	            local candidates = [];

	            if (ourTile.Properties.has("IsItemSpawned") || ourTile.IsCorpseSpawned) 
	            {
	                for (local i = 0; i < ::Const.Direction.COUNT; i++) 
	                {
	                    local tile = ourTile.getNextTile(i);

	                    if (tile && tile.IsEmpty && !tile.Properties.has("IsItemSpawned") && !tile.IsCorpseSpawned && tile.Level <= ourTile.Level + 1)
	                        candidates.push(tile);
	                }
	            }
	            else
	                candidates.push(ourTile);

	            if (candidates.len() != 0) 
	            {
	                local tileToSpawnAt = candidates[this.Math.rand(0, candidates.len() - 1)];
	                tileToSpawnAt.spawnDetail(breakfreeDecal);
	                tileToSpawnAt.Properties.add("IsItemSpawned");
	            }
	        }

	        _user.setDirty(true);
	        removeSkills(this.getContainer(), skillsToCheck);
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