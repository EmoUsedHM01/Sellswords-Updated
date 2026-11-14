this.ssu_necro_summon_skeleton <- this.inherit("scripts/skills/actives/legend_spawn_skill", {
	m = {
		Casts = 0
	},
	function create()
	{
		this.legend_spawn_skill.create();
		this.m.ID = "actives.ssu_necro_summon_skeleton_skill";
		this.m.Name = ::Mod_Sellswords.Strings.ssu_necro_summon_skeleton.Name1;
		this.m.Description = ::Mod_Sellswords.Strings.ssu_necro_summon_skeleton.Description;
		this.m.Icon = "skills/ssu_active_summon_skeleton.png";
		this.m.IconDisabled = "skills/ssu_active_summon_skeleton_sw.png";
		this.m.Overlay = "ssu_active_summon_skeleton";
		this.m.SoundOnUse = [
			"sounds/combat/bones_01.wav",
			"sounds/combat/bones_02.wav",
			"sounds/combat/bones_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/enemies/necromancer_01.wav",
			"sounds/enemies/necromancer_02.wav",
			"sounds/enemies/necromancer_03.wav"
		];
		this.m.SpawnItem = "spawns.skeleton";
		this.m.ActionPointCost = 7;
		this.m.FatigueCost = 35;
		this.m.MaxLevelDifference = 4;
		this.m.Order = this.Const.SkillOrder.NonTargeted + 3;
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
			text = ::Mod_Sellswords.Strings.ssu_necro_summon_skeleton.Tooltip1
		}]);
		ret.extend([{
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Mod_Sellswords.Strings.ssu_necro_summon_skeleton.Tooltip2
		}]);
		ret.extend([{
			id = 8,
			type = "text",
			icon = "ui/icons/miniboss.png",
			text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.ssu_necro_summon_skeleton.Tooltip3, this.getNumberOfSpawnsAvailable())
		}]);
		if (resolve >= 120)
		{
			ret.extend([{
				id = 9,
				type = "text",
				icon = "ui/icons/miniboss.png",
				text = ::Mod_Sellswords.Strings.ssu_necro_summon_skeleton.Tooltip4
			}]);
		}
		else if (resolve >= 60)
		{
			ret.extend([{
				id = 10,
				type = "text",
				icon = "ui/icons/miniboss.png",
				text = ::Mod_Sellswords.Strings.ssu_necro_summon_skeleton.Tooltip5
			}]);
		}
		else 
		{
			ret.extend([{
				id = 11,
				type = "text",
				icon = "ui/icons/miniboss.png",
				text = ::Mod_Sellswords.Strings.ssu_necro_summon_skeleton.Tooltip6
			}]);
		}
		
		return ret;
	}
	
	function getScript()
	{
		local actor = this.getContainer().getActor();
		local resolve = actor.getCurrentProperties().getBravery();
		if (resolve >= 120)
			return "scripts/entity/tactical/ssu_necro_skeleton_high";
		else if (resolve >= 60)
			return "scripts/entity/tactical/ssu_necro_skeleton_med";
		else
			return "scripts/entity/tactical/ssu_necro_skeleton_low";
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
		entity.setName(::Mod_Sellswords.Strings.ssu_necro_summon_skeleton.Name2);
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
			this.Tactical.EventLog.log(::Mod_Sellswords.text(::Mod_Sellswords.Strings.ssu_necro_summon_skeleton.Log, this.Const.UI.getColorizedEntityName(actor)));
		}
		
		this.Sound.play("sounds/enemies/horrific_scream_01.wav", this.Const.Sound.Volume.RacialEffect * 0.5, actor.getPos());
		
		return true;
	}
	
	function onCombatStarted()
	{
		this.m.Casts = 0;
	}
	
});