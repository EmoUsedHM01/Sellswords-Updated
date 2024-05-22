::mods_hookExactClass("skills/perks/perk_ptr_vigorous_assault", function ( o )
{
	local getTooltip = o.getTooltip;
	o.getTooltip = function ()
	{
		local tooltip = this.skill.getTooltip();

		if (this.m.CurrAPBonus > 0)
		{
			tooltip.push({
				id = 10,
				type = "text",
				icon = "ui/icons/action_points.png",
				text = "The next attack costs [color=" + this.Const.UI.Color.PositiveValue + "]-" + this.m.CurrAPBonus + "[/color] Action Point(s)"
			});
		}

		if (this.m.CurrFatBonus > 0)
		{
			tooltip.push({
				id = 10,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "The next attack builds up [color=" + this.Const.UI.Color.PositiveValue + "]-" + this.m.CurrFatBonus + "%[/color] Fatigue"
			});
			tooltip.push({
				id = 10,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "The next attack inflicts [color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.CurrFatBonus + "%[/color] more Damage"
			});
		}

		if (this.m.CurrAPBonus != 0 || this.m.CurrFatBonus != 0)
		{
			tooltip.push({
				id = 10,
				type = "text",
				icon = "ui/icons/warning.png",
				text = "Will expire upon waiting or ending the turn, using any skill, or swapping your weapon except to/from a throwing weapon"
			});
		}

		return tooltip;
	};
	local onAfterUpdate = o.onAfterUpdate;
	o.onAfterUpdate = function ( _properties )
	{
		this.resetBonus();

		if (!this.isEnabled() || this.m.StartingTile == null || this.Tactical.TurnSequenceBar.getActiveEntity() == null || this.Tactical.TurnSequenceBar.getActiveEntity().getID() != this.getContainer().getActor().getID())
		{
			return;
		}

		local actor = this.getContainer().getActor();
		local distanceMoved = this.m.StartingTile.getDistanceTo(actor.getTile());
		local aoo = this.getContainer().getAttackOfOpportunity();
		local mult = distanceMoved / this.m.BonusEveryXTiles;

		if (!actor.isPlayerControlled() && aoo != null && distanceMoved < this.m.BonusEveryXTiles)
		{
			local myTile = actor.getTile();
			local actors = this.Tactical.Entities.getAllInstancesAsArray();
			local numEnemiesInRange = 0;
			local numEnemiesApproachable = 0;

			foreach( a in actors )
			{
				if (a.isAlliedWith(actor))
				{
					continue;
				}

				local distance = a.getTile().getDistanceTo(myTile);

				if (distance == aoo.getMaxRange())
				{
					numEnemiesInRange++;
				}
				else if (distance == this.m.BonusEveryXTiles + aoo.getMaxRange())
				{
					numEnemiesApproachable++;
				}
			}

			if (numEnemiesInRange == 0 && numEnemiesApproachable > 0)
			{
				mult = 1;
			}
		}

		this.m.CurrAPBonus = this.m.APReduction * mult;
		this.m.CurrAPBonus = this.m.APReduction * mult;			
		this.m.CurrFatBonus = this.m.FatCostReduction * mult;

		if (this.m.CurrAPBonus != 0 && this.m.CurrFatBonus != 0)
		{
			foreach( skill in this.getContainer().getSkillsByFunction(function ( _skill )
			{
				return _skill.isAttack();
			}) )
			{
				if (skill.m.ActionPointCost > 2)
				{
					skill.m.ActionPointCost = this.Math.max(2, skill.m.ActionPointCost - this.m.CurrAPBonus);
				}					
				skill.m.FatigueCostMult *= 1.0 - this.m.CurrFatBonus * 0.01;
			}
		}
	};
	o.onAnySkillUsed <- function ( _skill, _targetEntity, _properties )
	{
		if (!_skill.isAttack() || _skill.isRanged() || !_skill.m.IsWeaponSkill)
		{
			return;
		}

		_properties.DamageTotalMult *= 1.0 + this.m.CurrFatBonus * 0.01;
	};
	o.onAnySkillExecuted = function ( _skill, _targetTile, _targetEntity, _forFree )
	{
		if (this.getContainer().getActor().isPlacedOnMap())
		{
			if (!_forFree )
			{
				this.m.StartingTile = this.getContainer().getActor().getTile();
			}
		}
	}		
});