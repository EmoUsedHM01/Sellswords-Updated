this.ssu_banner_wave <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.ssu_banner_wave";
		this.m.Name = ::Mod_Sellswords.Strings.ssu_banner_wave.Name;
		this.m.Description = ::Mod_Sellswords.Strings.ssu_banner_wave.Description;
		this.m.Icon = "skills/ssu_active_banner_wave.png";
		this.m.IconDisabled = "skills/ssu_active_banner_wave_bw.png";
		this.m.Overlay = "ssu_active_banner_wave";
		this.m.SoundOnUse = [
			"sounds/combat/inspire_01.wav",
			"sounds/combat/inspire_02.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.Any;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = false;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsVisibleTileNeeded = false;
		this.m.ActionPointCost = 9;
		this.m.FatigueCost = 45;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
	}

	function getTooltip()
	{
		local ret = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 3,
				type = "text",
				text = this.getCostString()
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Mod_Sellswords.Strings.ssu_banner_wave.Tooltip1
			}
		];
		
		if (this.Tactical.isActive() && this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions()))
		{
			ret.push({
				id = 5,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = ::Mod_Sellswords.Strings.ssu_banner_wave.Tooltip2
			});
		}
		
		return ret;
	}

	function isUsable()
	{
		if (!this.Tactical.isActive())
		{
			return false;
		}

		local tile = this.getContainer().getActor().getTile();
		return this.skill.isUsable() && !tile.hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions());
	}

	function onUse( _user, _targetTile )
	{
		local myTile = _user.getTile();
		local actors = this.Tactical.Entities.getInstancesOfFaction(_user.getFaction());

		foreach( a in actors )
		{
			if (a.getID() == _user.getID())
			{
				continue;
			}

			if (myTile.getDistanceTo(a.getTile()) > 8)
			{
				continue;
			}

			if (a.getFaction() == _user.getFaction())
			{
				a.getSkills().add(this.new("scripts/skills/effects/ssu_valor_effect"));
			}
		}

		this.getContainer().add(this.new("scripts/skills/effects/ssu_valor_effect"));
		return true;
	}

});

