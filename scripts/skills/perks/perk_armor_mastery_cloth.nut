this.perk_armor_mastery_cloth <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.armor_mastery_cloth";
		this.m.Name = this.Const.Strings.PerkName.ArmorMasteryCloth;
		this.m.Description = this.Const.Strings.PerkDescription.ArmorMasteryCloth;
		this.m.Icon = "ui/perks/crSpecialize_ca.png";
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function enemyCheck()
	{
		local actor = this.getContainer().getActor();
		if (actor.getTile().hasZoneOfControlOtherThan(actor.getAlliedFactions()))
		{
			local myTile = this.getContainer().getActor().getTile();

			for( local i = 0; i < 6; i++ )
			{
				if (myTile.hasNextTile(i))
				{
					local nextTile = myTile.getNextTile(i);

					if (nextTile.IsOccupiedByActor && this.Math.abs(nextTile.Level - myTile.Level) <= 1)
					{
						local entity = nextTile.getEntity();

						if (!entity.getCurrentProperties().IsStunned && !entity.isAlliedWith(this.getContainer().getActor()))
							return true;
					}
				}
			}
		}
		return false;  // Ensure a boolean is always returned
	}

	function teleportMe( _user, _targetTile )
	{
		local tag = {
			Skill = this,
			User = _user,
			OldTile = _user.getTile(),
			TargetTile = _targetTile
		};

		if (tag.OldTile.IsVisibleForPlayer || _targetTile.IsVisibleForPlayer)
		{
			local myPos = _user.getPos();
			local targetPos = _targetTile.Pos;
			local distance = tag.OldTile.getDistanceTo(_targetTile);
			local Dx = (targetPos.X - myPos.X) / distance;
			local Dy = (targetPos.Y - myPos.Y) / distance;

			// Add an incremental loop to find the tile
			for( local i = 0; i < distance; i++ )
			{
				local x = myPos.X + Dx * i;
				local y = myPos.Y + Dy * i;
				local tile = this.Tactical.worldToTile(this.createVec(x, y));

				if (this.Tactical.isValidTile(tile.X, tile.Y) && this.Const.Tactical.DustParticles.len() != 0)
				{
					for( local j = 0; j < this.Const.Tactical.DustParticles.len(); j++ )
					{
						this.Tactical.spawnParticleEffect(false, this.Const.Tactical.DustParticles[j].Brushes, this.Tactical.getTile(tile), this.Const.Tactical.DustParticles[j].Delay, this.Const.Tactical.DustParticles[j].Quantity * 0.5, this.Const.Tactical.DustParticles[j].LifeTimeQuantity * 0.5, this.Const.Tactical.DustParticles[j].SpawnRate, this.Const.Tactical.DustParticles[j].Stages);
					}
				}
			}
		}

		this.Tactical.getNavigator().teleport(_user, _targetTile, this.onTeleportDone, tag, false, 2.0);
		return true;
	}

	function onTurnStart()
	{
		local actor = this.getContainer().getActor();
		if (this.enemyCheck() == false || actor == null || actor.getCurrentProperties().IsStunned || (actor.getCurrentProperties().IsRooted && !actor.getSkillByID("perk.legend_escape_artist")))
			return;

		local currentTile = actor.getTile();
		local closestTile = null;
		local minDistance = 99;

		// Loop through all possible tiles in a certain radius (e.g 10 tiles)
		for (local x = currentTile.X - 10; x <= currentTile.X + 10; x++)
		{
			for (local y = currentTile.Y - 10; y <= currentTile.Y + 10; y++)
			{
				if (!this.Tactical.isValidTile(x, y))
					continue;

				local tile = this.Tactical.getTileSquare(x, y);

				// Skip all tiles that are occupied or within enemy ZoC
				if (tile.IsOccupiedByActor || tile.hasZoneOfControlOtherThan(actor.getAlliedFactions()))
					continue;

				local distance = currentTile.getDistanceTo(tile);
				if (distance < minDistance)
				{
					minDistance = distance;
					closestTile = tile;
				}
			}
		}

		// If a valid tile was found, teleport the actor
		if (closestTile != null)
			this.teleportMe(actor, closestTile);
	}

});