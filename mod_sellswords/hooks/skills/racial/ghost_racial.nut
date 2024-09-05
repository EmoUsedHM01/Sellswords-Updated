::Mod_Sellswords.HooksMod.hook("scripts/skills/racial/ghost_racial", function( q ) {

	q.create = @(__original) function()
	{
		__original();
		this.m.Description = "This character doesn\'t have a corporeal form, making it extremely hard to land a hit.";
		this.m.Icon = "ui/racial/racial_ghost.png";
		this.m.IconMini = "racial_ghost_mini"
	}
	
	q.getTooltip <- function()
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
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Is always [color=" + this.Const.UI.Color.PositiveValue + "]Levitating[/color]"
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/miniboss.png",
				text = "Immune to bleeding, poison and most types of injuries."
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "Not effected by fatigue, but needs fatigue to equip items."
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/morale.png",
				text = "Not affected by morale or allies fleeing and dying."
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/xp_received.png",
				text = "Experience is gained at 50% normal rate."
			}
		];
	}
	
	q.onAdded = @(__original) function()
	{
		local actor = this.getContainer().getActor();
		if (!actor.isPlayerControlled())
		{
			return;
		}
		
		actor.m.MoraleState = this.Const.MoraleState.Ignore;
		actor.m.ExcludedInjuries = [
			"injury.cut_artery",
			"injury.cut_throat",
			"injury.deep_abdominal_cut",
			"injury.deep_chest_cut",
			"injury.exposed_ribs",
			"injury.grazed_kidney",
			"injury.grazed_neck",
			"injury.infected_wound",
			"injury.sickness",
			"injury.stabbed_guts",
			"injury.broken_nose",
			"injury.crushed_windpipe",
			"injury.inhaled_flames",
			"injury.pierced_chest",
			"injury.pierced_lung",
			"injury.pierced_side"
		];
		
		this.m.Type = this.Const.SkillType.Racial | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.First + 1;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}
	
	q.onUpdate = @(__original) function( _properties )
	{
		_properties.IsImmuneToBleeding = true;
		_properties.IsImmuneToPoison = true;
		_properties.IsImmuneToKnockBackAndGrab = true;
		_properties.IsImmuneToStun = true;
		_properties.IsImmuneToRoot = true;
		_properties.IsImmuneToDisarm = true;
		_properties.IsAffectedByRain = false;
		_properties.IsAffectedByNight = false;
		_properties.IsAffectedByInjuries = false;
		_properties.IsMovable = false;
		_properties.MoraleCheckBraveryMult[this.Const.MoraleCheckType.MentalAttack] *= 1000.0;
		_properties.Hitpoints == 1;
		_properties.RangedDefense == 999;
		_properties.XPGainMult *= 0.5;
		
		local actor = this.getContainer().getActor();
		actor.m.ActionPointCosts = this.Const.LegendFlightMovementAPCost;
		actor.m.FatigueCosts = this.Const.LegendFlightMovementFatigueCost;
		actor.m.LevelActionPointCost = 0;
	}

});