this.ssu_dryad_summon_snake <- this.inherit("scripts/skills/skill", {
	m = {
		EntityName = "Thicket Stalker",
		Summon = "scripts/entity/tactical/enemies/ssu_dryad_snake",
		Sounds0 = [
			"sounds/enemies/dlc6/snake_hurt_01.wav",
			"sounds/enemies/dlc6/snake_hurt_02.wav",
			"sounds/enemies/dlc6/snake_hurt_03.wav",
			"sounds/enemies/dlc6/snake_hurt_04.wav"
		],
		Sounds1 = [
			"sounds/enemies/dlc6/snake_death_01.wav",
			"sounds/enemies/dlc6/snake_death_02.wav",
			"sounds/enemies/dlc6/snake_death_03.wav",
			"sounds/enemies/dlc6/snake_death_04.wav"
		],
		Sounds2 = [
			"sounds/enemies/dlc6/snake_idle_01.wav",
			"sounds/enemies/dlc6/snake_idle_02.wav",
			"sounds/enemies/dlc6/snake_idle_03.wav",
			"sounds/enemies/dlc6/snake_idle_04.wav",
			"sounds/enemies/dlc6/snake_idle_05.wav",
			"sounds/enemies/dlc6/snake_idle_06.wav",
			"sounds/enemies/dlc6/snake_idle_07.wav",
			"sounds/enemies/dlc6/snake_idle_08.wav",
			"sounds/enemies/dlc6/snake_idle_09.wav",
			"sounds/enemies/dlc6/snake_idle_10.wav",
			"sounds/enemies/dlc6/snake_idle_11.wav",
			"sounds/enemies/dlc6/snake_idle_12.wav",
			"sounds/enemies/dlc6/snake_idle_13.wav"
		]
	},

	function create()
	{
		this.m.ID = "actives.ssu_dryad_summon_snake";
		this.m.Name = ::Mod_Sellswords.Strings.ssu_dryad_summon_snake.Name;
		this.m.Description = ::Mod_Sellswords.Strings.ssu_dryad_summon_snake.Description;
		this.m.Icon = "skills/ssu_dryad_summon_snake.png";
		this.m.IconDisabled = "skills/ssu_dryad_summon_snake_sw.png";
		this.m.Overlay = "ssu_dryad_summon_snake";
		this.m.SoundOnUse = [
			"sounds/enemies/dlc6/snake_idle_01.wav",
			"sounds/enemies/dlc6/snake_idle_02.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.Last + 3;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsTargetingActor = false;
		this.m.ActionPointCost = 5;
		this.m.FatigueCost = 30;
		this.m.MinRange = 1;
		this.m.MaxRange = 3;
	}

	function addResources()
	{
		this.skill.addResources();

		foreach( r in this.m.Sounds0 )
		{
			this.Tactical.addResource(r);
		}

		foreach( r in this.m.Sounds1 )
		{
			this.Tactical.addResource(r);
		}

		foreach( r in this.m.Sounds2 )
		{
			this.Tactical.addResource(r);
		}
	}

	function getTooltip()
	{
		local ret = this.getDefaultUtilityTooltip();
		local ammo = this.getAmmo();
		
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Mod_Sellswords.Strings.ssu_dryad_summon_snake.Tooltip1
		});
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Mod_Sellswords.Strings.ssu_dryad_summon_snake.Tooltip2
		});
		if (ammo > 0)
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/icons/ammo.png",
				text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.ssu_dryad_summon_snake.Tooltip3, ammo)
			});
		}
		else
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = ::Mod_Sellswords.Strings.ssu_dryad_summon_snake.Tooltip4
			});
		}
		if (this.Tactical.isActive() && this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions()))
		{
			ret.push({
				id = 9,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = ::Mod_Sellswords.Strings.ssu_dryad_summon_snake.Tooltip5
			});
		}
		return ret;
	}

	function isUsable()
	{
		return !this.Tactical.isActive() || this.skill.isUsable() && this.getAmmo() > 0 && !this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions());
	}
	
	function getAmmo()
	{
		local item = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Ammo);

		if (item == null)
		{
			return 0;
		}

		if (item.getAmmoType() == this.Const.Items.AmmoType.Heart)
		{
			return item.getAmmo();
		}
	}
	
	function consumeAmmo()
	{
		local item = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Ammo);

		if (item != null)
		{
			item.consumeAmmo();
		}
	}
	
	function onVerifyTarget( _originTile, _targetTile )
	{
		local actor = this.getContainer().getActor();
		return this.skill.onVerifyTarget(_originTile, _targetTile) && _targetTile.IsEmpty;
	}

	function onUse( _user, _targetTile )
	{
		local target = _targetTile.getEntity();
		local summon = this.Tactical.spawnEntity(this.m.Summon, _targetTile.Coords.X, _targetTile.Coords.Y);
		this.consumeAmmo();

		summon.setFaction(_user.getFaction() == this.Const.Faction.Player ? this.Const.Faction.PlayerAnimals : this.getContainer().getActor().getFaction());
		summon.setName(this.m.EntityName);
		summon.setMoraleState(this.Const.MoraleState.Confident);
		
		return true;
	}

});

