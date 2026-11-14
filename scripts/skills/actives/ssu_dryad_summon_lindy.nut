this.ssu_dryad_summon_lindy <- this.inherit("scripts/skills/skill", {
	m = {
		EntityName = "Forest Avatar",
		Summon = "scripts/entity/tactical/enemies/ssu_dryad_lindy",
		Sounds0 = [
			"sounds/enemies/lindwurm_hurt_01.wav",
			"sounds/enemies/lindwurm_hurt_02.wav",
			"sounds/enemies/lindwurm_hurt_03.wav",
			"sounds/enemies/lindwurm_hurt_04.wav"
		],
		Sounds1 = [
			"sounds/enemies/lindwurm_death_01.wav",
			"sounds/enemies/lindwurm_death_02.wav",
			"sounds/enemies/lindwurm_death_03.wav",
			"sounds/enemies/lindwurm_death_04.wav"
		],
		Sounds2 = [
			"sounds/enemies/lindwurm_idle_01.wav",
			"sounds/enemies/lindwurm_idle_02.wav",
			"sounds/enemies/lindwurm_idle_03.wav",
			"sounds/enemies/lindwurm_idle_04.wav",
			"sounds/enemies/lindwurm_idle_05.wav",
			"sounds/enemies/lindwurm_idle_06.wav",
			"sounds/enemies/lindwurm_idle_07.wav",
			"sounds/enemies/lindwurm_idle_08.wav",
			"sounds/enemies/lindwurm_idle_09.wav",
			"sounds/enemies/lindwurm_idle_10.wav",
			"sounds/enemies/lindwurm_idle_11.wav"
		]
	},

	function create()
	{
		this.m.ID = "actives.ssu_dryad_summon_lindy";
		this.m.Name = ::Mod_Sellswords.Strings.ssu_dryad_summon_lindy.Name;
		this.m.Description = ::Mod_Sellswords.Strings.ssu_dryad_summon_lindy.Description;
		this.m.Icon = "skills/ssu_dryad_summon_lindy.png";
		this.m.IconDisabled = "skills/ssu_dryad_summon_lindy_sw.png";
		this.m.Overlay = "ssu_dryad_summon_lindy";
		this.m.SoundOnUse = [
			"sounds/enemies/lindwurm_idle_01.wav",
			"sounds/enemies/lindwurm_idle_02.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.Last + 5;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsTargetingActor = false;
		this.m.ActionPointCost = 9;
		this.m.FatigueCost = 50;
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
			text = ::Mod_Sellswords.Strings.ssu_dryad_summon_lindy.Tooltip1
		});
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Mod_Sellswords.Strings.ssu_dryad_summon_lindy.Tooltip2
		});
		if (ammo > 0)
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/icons/ammo.png",
				text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.ssu_dryad_summon_lindy.Tooltip3, ammo)
			});
		}
		else
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = ::Mod_Sellswords.Strings.ssu_dryad_summon_lindy.Tooltip4
			});
		}
		if (this.Tactical.isActive() && this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions()))
		{
			ret.push({
				id = 9,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = ::Mod_Sellswords.Strings.ssu_dryad_summon_lindy.Tooltip5
			});
		}
		return ret;
	}

	function isUsable()
	{
		return !this.Tactical.isActive() || this.skill.isUsable() && this.getAmmo() > 4 && !this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions());
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
			item.consumeAmmo();
			item.consumeAmmo();
			item.consumeAmmo();
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

