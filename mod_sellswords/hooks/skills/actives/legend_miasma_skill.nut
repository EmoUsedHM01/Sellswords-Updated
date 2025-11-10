::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/legend_miasma_skill", function( q ) {

	q.create = @(__original) function()
	{
		__original();
		this.m.Description = "Release a dense cloud of noxious gas that only effects living beings";
		this.m.Icon = "skills/active_101.png";
		this.m.IconDisabled = "skills/active_101_sw.png";
		this.m.Order = this.Const.SkillOrder.UtilityTargeted + 3;
		this.m.IsTargeted = true;
		this.m.IsTargetingActor = false;
		this.m.IsAttack = false;
		this.m.IsRanged = false;
		this.m.ActionPointCost = 7;
		this.m.FatigueCost = 30;
		this.m.MaxRange = 8;
	}

	q.getTooltip = @(__original) function()
	{
		return [
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
				icon = "ui/icons/vision.png",
				text = "Has a range of [color=%positive%]" + this.getMaxRange() + "[/color] tiles"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/damage_received.png",
				text = "Deals 5-10 damage directly to hitpoints to any living units that end their turn in the miasma"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/damage_received.png",
				text = "Lasts for four turns. While the damage can't stack, you reset the duration if you overlap the tiles with subsequent casts"
			}
		];
	}

	q.onVerifyTarget = @(__original) function( _originTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_originTile, _targetTile))
			return false;

		return true;
	}

	q.isViableTarget = @(__original) function( _user, _target )
	{
	}

	q.onTargetSelected = @(__original) function( _targetTile )
	{
		local ownTile = _targetTile;

		for( local i = 0; i != 6; i = ++i )
		{
			if (!ownTile.hasNextTile(i))
			{
			}
			else
			{
				local tile = ownTile.getNextTile(i);

				if (this.Math.abs(tile.Level - ownTile.Level) <= 1)
				{
					this.Tactical.getHighlighter().addOverlayIcon(this.Const.Tactical.Settings.AreaOfEffectIcon, tile, tile.Pos.X, tile.Pos.Y);
				}
			}
		}
	}

});