this.mod_raise_all_undead <- ::inherit("scripts/skills/skill", {
	m = {
		IsSpent = false,
		SpawnedUndead = []
	},
	function create()
	{
		this.m.ID = "actives.raise_all_undead";
		this.m.Name = "The Danse Macabre";
		this.m.Description = "Witness the darkest depths of necromantic power. Unleash a wave of unholy energy that reanimates all suitable corpses.";
		this.m.Icon = "skills/active_213.png";
		this.m.IconDisabled = "skills/active_213_sw.png";
		this.m.Overlay = "active_black_book";
		this.m.SoundOnUse = [
			"sounds/enemies/necromancer_01.wav",
			"sounds/enemies/necromancer_02.wav",
			"sounds/enemies/necromancer_03.wav"
		];
		this.m.SoundVolume = 1.35;
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.BeforeLast;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = false;
		this.m.IsTargetingActor = false;
		this.m.IsVisibleTileNeeded = false;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.ActionPointCost = 9;
		this.m.FatigueCost = 0;
		this.m.MinRange = 0;
		this.m.MaxRange = 0;
		this.m.MaxLevelDifference = 4;
	}

	function getTooltip()
	{
		local ret = this.getDefaultUtilityTooltip();

		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/vision.png",
			text = "Has an [color=%positive%]unlimited[/color] range."
		});
		ret.push({
			id = 8,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Raises all suitable corpses on the map as a Wiederganger, lasts until the end of combat."
		});
		ret.push({
			id = 9,
			type = "text",
			icon = "ui/tooltips/warning.png",
			text = "[color=%negative%]Can only be used once per battle.[/color]"
		});

		if (this.m.IsSpent)
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=%negative%]Has been spent[/color]."
			});

			return ret;
		}

		if (::Tactical.isActive())
		{
			local count = this.getNumAvailableCorpsesOnTheMap();

			if (count == 1)
			{
				ret.push({
					id = 11,
					type = "text",
					icon = "ui/icons/kills.png",
					text = "There is [color=%positive%]" + count + "[/color] corpse available for resurrection"
				});
			}
			else if (count >= 2)
			{
				ret.push({
					id = 12,
					type = "text",
					icon = "ui/icons/kills.png",
					text = "There are [color=%positive%]" + count + "[/color] corpses available for resurrection"
				});
			}
			else
			{
				ret.push({
					id = 13,
					type = "text",
					icon = "ui/tooltips/warning.png",
					text = "[color=%negative%]There is currently no suitable corpse on the map[/color]"
				});
			}
		}

		return ret;
	}

	function getNumAvailableCorpsesOnTheMap()
	{
		local count = 0;

		foreach ( c in ::Tactical.Entities.getCorpses() )
		{
			if (!this.isViableTile(c))
				continue;

			++count;
		}
		
		return count;
	}

	function isUsable()
	{
		if (this.getNumAvailableCorpsesOnTheMap() == 0)
			return false;

		return this.skill.isUsable() && !this.m.IsSpent;
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		return true;
	}

	function isViableTile( _tile )
	{
		if (!this.MSU.Tile.canResurrectOnTile(_tile))
			return false;

		if (!_tile.IsEmpty)
			return false;

		return true;
	}

	function spawnUndead( _user, _tile )
	{
		local p = _tile.Properties.get("Corpse");
		p.Faction = _user.getFaction();

		if (p.Faction == this.Const.Faction.Player)
			p.Faction = this.Const.Faction.PlayerAnimals;

		local e = this.Tactical.Entities.onResurrect(p, true);

		if (e != null)
			e.getSprite("socket").setBrush(_user.getSprite("socket").getBrush().Name);
		
		local zombie = _tile.getEntity();
		this.m.SpawnedUndead.push([::MSU.asWeakTableRef(e), _user]);
	}

	function onUse( _user, _targetTile )
	{
		local corpses = clone ::Tactical.Entities.getCorpses();

		foreach( c in corpses )
		{
			if (!this.isViableTile(c))
				continue;

			if (c.IsVisibleForPlayer)
			{
				if (this.Const.Tactical.RaiseUndeadParticles.len() != 0)
				{
					for( local i = 0; i < this.Const.Tactical.RaiseUndeadParticles.len(); i = i )
					{
						this.Tactical.spawnParticleEffect(true, this.Const.Tactical.RaiseUndeadParticles[i].Brushes, _targetTile, this.Const.Tactical.RaiseUndeadParticles[i].Delay, this.Const.Tactical.RaiseUndeadParticles[i].Quantity, this.Const.Tactical.RaiseUndeadParticles[i].LifeTimeQuantity, this.Const.Tactical.RaiseUndeadParticles[i].SpawnRate, this.Const.Tactical.RaiseUndeadParticles[i].Stages);
						i = ++i;
					}
				}
			}

			local e = this.spawnUndead(_user, c);

			if (e != null)
			{
				if (e.getItems().getItemAtSlot(::Const.ItemSlot.Mainhand) == null)
				{
					local items = this.getContainer().getActor().getItems();
					local weapons = [
						"weapons/ancient/ancient_sword",
						"weapons/wooden_stick",
						"weapons/shortsword"
					];
					items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
				}

				if (!c.IsVisibleForPlayer)
					c.addVisibilityForFaction(::Const.Faction.Player);
			}
		}

		::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_user) + " has reanimated the fallen!");
		this.m.IsSpent = true;
		return true;
	}

	function onCombatStarted()
	{
		this.m.IsSpent = false;
	}

	function onCombatFinished()
	{
		this.m.IsSpent = false;
		while(this.m.SpawnedUndead.len() != 0)
		{
			local pair = this.m.SpawnedUndead.pop();
			if (pair[0] != null && !pair[0].isNull() && pair[0].isAlive())
				pair[0].kill(pair[1], this, this.Const.FatalityType.Kraken, true);
		}
	}

});