this.mod_summon_zombie <- this.inherit("scripts/skills/actives/legend_spawn_skill", {
	m = {
		Casts = 0
	},
	function create()
	{
		this.legend_spawn_skill.create();
		this.m.ID = "actives.summon_zombie_skill";
		this.m.Name = "Reanimate Zombie";
		this.m.Description = "Use blood magic to re-animate a fashioned corpse, and send it stumbling into the enemy. Takes a toll on the users mental state as they try and drag a spirit from the afterlife to inhabit the corpse.";
		this.m.Icon = "skills/active_summon_zombie.png";
		this.m.IconDisabled = "skills/active_summon_zombie_sw.png";
		this.m.Overlay = "active_summon_zombie";
		this.m.SoundOnUse = [
			"sounds/combat/meat_01.wav",
			"sounds/combat/meat_02.wav",
			"sounds/combat/meat_03.wav",
			"sounds/combat/meat_04.wav"
		];
		this.m.SoundOnHit = [
			"sounds/enemies/necromancer_01.wav",
			"sounds/enemies/necromancer_02.wav",
			"sounds/enemies/necromancer_03.wav"
		];
		this.m.SpawnItem = "spawns.zombie";
		this.m.ActionPointCost = 7;
		this.m.FatigueCost = 35;
		this.m.MaxLevelDifference = 4;
		this.m.Order = this.Const.SkillOrder.NonTargeted + 4;
		this.m.IsControlledByPlayer = false,
		this.m.HPCost = 5;
	}
	
	function getTooltip()
	{
		local actor = this.getContainer().getActor();
		local resolve = actor.getCurrentProperties().getBravery();
		local ret = this.getDefaultUtilityTooltip();
		ret.extend([{
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "The strength of the reanimated corpse scales based on the current resolve of the caster."
		}]);
		ret.extend([{
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Each successive cast makes it harder for the user to drag another soul from the ethereal plane."
		}]);
		ret.extend([{
			id = 8,
			type = "text",
			icon = "ui/icons/miniboss.png",
			text = "There are " + this.getNumberOfSpawnsAvailable() + " spawns available in your inventory"
		}]);
		if (resolve >= 120)
		{
			ret.extend([{
				id = 9,
				type = "text",
				icon = "ui/icons/miniboss.png",
				text = "Will reanimate a strengthened undead."
			}]);
		}
		else if (resolve >= 60)
		{
			ret.extend([{
				id = 10,
				type = "text",
				icon = "ui/icons/miniboss.png",
				text = "Will reanimate a regular undead."
			}]);
		}
		else 
		{
			ret.extend([{
				id = 11,
				type = "text",
				icon = "ui/icons/miniboss.png",
				text = "Will reanimate a weakened undead."
			}]);
		}
		
		return ret;
	}
	
	function getScript()
	{
		local actor = this.getContainer().getActor();
		local resolve = actor.getCurrentProperties().getBravery();
		if (resolve >= 120)
			return "scripts/entity/tactical/legends_zombie_high";
		else if (resolve >= 60)
			return "scripts/entity/tactical/legends_zombie_med";
		else
			return "scripts/entity/tactical/legends_zombie_low";
	}

	function onUse( _user, _targetTile )
	{
		local spawnItem;
		local items = this.World.Assets.getStash().getItems();

		foreach( item in items )
		{
			if (item == null)
				continue;

			if (item.getID() != this.m.SpawnItem)
				continue;

			if (item.isUnleashed())
				continue;

			spawnItem = item;
			this.World.Assets.getStash().remove(item);
			break;
		}

		if (spawnItem == null)
			return false;

		local entity = this.Tactical.spawnEntity(this.getScript(), _targetTile.Coords.X, _targetTile.Coords.Y);

		if (this.m.IsControlledByPlayer)
			entity.setFaction(this.Const.Faction.Player);
		else
			entity.setFaction(this.Const.Faction.PlayerAnimals);

		entity.setItem(spawnItem);
		entity.setName("Raised Wiederganger");
		entity.assignRandomEquipment();
		entity.riseFromGround();
		entity.getFlags().add("IsSummoned", true);
		entity.getFlags().add("Summoner", _user);
		entity.setActionPoints(this.Math.round(this.m.APStartMult * entity.getActionPoints()));
		spawnItem.setEntity(entity);
		this.m.Items.push(spawnItem);
		this.spawnIcon("status_effect_01", this.getContainer().getActor().getTile());
		local actor = this.getContainer().getActor();
		actor.setHitpoints(this.Math.max(actor.getHitpoints() - this.m.HPCost, 1));
		
		this.m.Casts += 2;
		
		for (local i = 0; i < this.m.Casts; ++i)
		{
			actor.checkMorale(-1, 0, this.Const.MoraleCheckType.MentalAttack);
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(actor) + " suffered [color=%negative%]backlash[/color] from the summoning ritual");
		}
		
		this.Sound.play("sounds/enemies/horrific_scream_01.wav", this.Const.Sound.Volume.RacialEffect * 0.5, actor.getPos());
		
		return true;
	}
	
	function onCombatStarted()
	{
		this.m.Casts = 0;
	}
	
});