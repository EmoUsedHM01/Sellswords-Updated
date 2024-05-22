::mods_hookExactClass("skills/effects/legend_hexe_ichor_potion_effect", function(o) {
	o.m.SkillsUsedCount <- 0;
	o.m.MalusPerCount <- 15;
	o.m.IsSpent <- false;

	local ws_create = o.create;
	o.create = function()
	{
		ws_create();

		this.m.TurnsLeft = 3;
		this.m.Name = "Perfect Focus";
		this.m.Description = "This character has achieved perfect focus as if time itself were to stand still, gaining additional Action Points for this turn.";		
		this.m.Type = this.Const.SkillType.StatusEffect;
	}

	o.getDescription = function()
	{
		return this.skill.getDescription();
	}

	o.getTooltip = function()
	{
		local tooltip = this.skill.getTooltip();
		if (this.m.SkillsUsedCount > 0)
		{
			tooltip.push({
				id = 10,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]+" + this.getMalus() + "%[/color] Fatigue built"
			});
		}

		if (this.m.IsSpent)
		{
			tooltip.extend([
				{
					id = 10,
					type = "text",
					icon = "ui/icons/warning.png",
					text = "[color=" + this.Const.UI.Color.NegativeValue + "]This character has lost focus due to switching to a ranged weapon[/color]"
				}
			]);
		}
		else
		{
			tooltip.extend([
				{
					id = 10,
					type = "text",
					icon = "ui/icons/action_points.png",
					text = "Action Point Cost is [color=" + this.Const.UI.Color.PositiveValue + "]halved[/color]"
				}				
				{
					id = 10,
					type = "text",
					icon = "ui/icons/warning.png",
					text = "[color=" + this.Const.UI.Color.NegativeValue + "]Will be lost upon switching to a ranged weapon[/color]"
				}
			]);
		}

		return tooltip;
	}

	o.onUpdate = function(_properties)
	{
		if (this.getContainer().hasSkill("effects.perfect_focus"))
		{
			return;
		}
		local actor  = this.getContainer().getActor();
		if (actor.isArmedWithRangedWeapon())
		{
			this.m.IsSpent = true;
			return;
		}
		else
		{
			//_properties.IsRooted = true;
			//_properties.IsImmuneToKnockBackAndGrab = true;
			_properties.IsSkillUseHalfCost = true;
			local malus = this.getMalus() * 0.01;
			_properties.FatigueEffectMult *= 1.0 + malus;			
		}
	}

	o.onAdded = function()
	{
		this.m.TurnsLeft = 3;
	}

	o.onRemoved <- function()
	{
		if (!::Is_PTR_Exist) return;

		this.getContainer().add(this.new("scripts/skills/effects/ptr_exhausted_effect_severe"));
	}

	o.onAnySkillExecuted <- function(_skill, _targetTile, _targetEntity, _forFree)
	{
		if (this.Tactical.TurnSequenceBar.getActiveEntity() != null && this.Tactical.TurnSequenceBar.getActiveEntity().getID() == this.getContainer().getActor().getID())
		{
			this.m.SkillsUsedCount++;
		}
	}

	o.getMalus <- function()
	{
		return this.m.SkillsUsedCount * this.m.MalusPerCount;
	}
	
	o.onTurnEnd = function()
	{
		this.m.SkillsUsedCount = this.Math.max(1, this.m.SkillsUsedCount - 1);	
		if (--this.m.TurnsLeft <= 0)
		{
			this.removeSelf();
		}
	}	
})