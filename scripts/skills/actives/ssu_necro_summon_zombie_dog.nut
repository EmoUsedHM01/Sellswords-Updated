this.ssu_necro_summon_zombie_dog <- this.inherit("scripts/skills/actives/legend_spawn_skill", {
	m = {
		Casts = 0
	},
	function create()
	{
		this.legend_spawn_skill.create();
		this.m.ID = "actives.ssu_necro_summon_zombie_dog_skill";
		this.m.Name = ::Mod_Sellswords.Strings.ssu_necro_summon_zombie_dog.Name1;
		this.m.Description = ::Mod_Sellswords.Strings.ssu_necro_summon_zombie_dog.Description;
		this.m.Icon = "skills/ssu_active_summon_zombie_dog.png";
		this.m.IconDisabled = "skills/ssu_active_summon_zombie_dog_sw.png";
		this.m.Overlay = "ssu_active_summon_zombie_dog";
		this.m.SoundOnUse = [
			"sounds/enemies/wardog_charge_00.wav",
			"sounds/enemies/wardog_charge_01.wav",
			"sounds/enemies/wardog_charge_02.wav"
		];
		this.m.SoundOnHit = [
			"sounds/enemies/necromancer_01.wav",
			"sounds/enemies/necromancer_02.wav",
			"sounds/enemies/necromancer_03.wav"
		];
		this.m.SpawnItem = "spawns.ssu_necro_zombie_dog";
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 15;
		this.m.MaxLevelDifference = 4;
		this.m.Order = this.Const.SkillOrder.NonTargeted + 5;
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
			text = ::Mod_Sellswords.Strings.ssu_necro_summon_zombie_dog.Tooltip1
		}]);
		ret.extend([{
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Mod_Sellswords.Strings.ssu_necro_summon_zombie_dog.Tooltip2
		}]);
		ret.extend([{
			id = 8,
			type = "text",
			icon = "ui/icons/miniboss.png",
			text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.ssu_necro_summon_zombie_dog.Tooltip3, this.getNumberOfSpawnsAvailable())
		}]);
		ret.extend([{
			id = 9,
			type = "text",
			icon = "ui/icons/miniboss.png",
			text = ::Mod_Sellswords.Strings.ssu_necro_summon_zombie_dog.Tooltip4
		}]);
		
		return ret;
	}
	
	function getScript()
	{
		return "scripts/entity/tactical/ssu_necro_zombie_dog";
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
		entity.setName(::Mod_Sellswords.Strings.ssu_necro_summon_zombie_dog.Name2);
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
		
		this.m.Casts ++;
		
		for (local i = 0; i < this.m.Casts; ++i)
		{
			actor.checkMorale(-1, 0, this.Const.MoraleCheckType.MentalAttack);
			this.Tactical.EventLog.log(::Mod_Sellswords.text(::Mod_Sellswords.Strings.ssu_necro_summon_zombie_dog.Log, this.Const.UI.getColorizedEntityName(actor)));
		}
		
		this.Sound.play("sounds/enemies/horrific_scream_01.wav", this.Const.Sound.Volume.RacialEffect * 0.5, actor.getPos());
		
		return true;
	}
	
	function onCombatStarted()
	{
		this.m.Casts = 0;
	}
	
});