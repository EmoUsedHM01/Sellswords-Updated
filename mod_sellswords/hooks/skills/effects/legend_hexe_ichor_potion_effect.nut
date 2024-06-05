::Mod_Sellswords.HooksMod.hook("scripts/skills/effects/legend_hexe_ichor_potion_effect", function ( q ) {

	q.m.SkillsUsedCount <- 0;
	q.m.MalusPerCount <- 15;
	q.m.IsSpent <- false;


	q.create = @(__original) function()
	{
		__original();

		this.m.TurnsLeft = 3;
		this.m.Name = "Perfect Focus";
		this.m.Description = "This character has achieved perfect focus as if time itself were to stand still, gaining additional Action Points for this turn.";		
		this.m.Type = this.Const.SkillType.StatusEffect;
	}

	q.getDescription = @(__original) function()
	{
		return this.skill.getDescription();
	}

	q.getTooltip = @(__original) function()
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

	q.onUpdate = @(__original) function(_properties)
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

	q.onAdded = @(__original) function()
	{
		this.m.TurnsLeft = 3;
	}

	q.onRemoved <- function()
	{
		if (!::Is_PTR_Exist) return;

		this.getContainer().add(this.new("scripts/skills/effects/ptr_exhausted_effect_severe"));
	}

	q.onAnySkillExecuted <- function(_skill, _targetTile, _targetEntity, _forFree)
	{
		if (this.Tactical.TurnSequenceBar.getActiveEntity() != null && this.Tactical.TurnSequenceBar.getActiveEntity().getID() == this.getContainer().getActor().getID())
		{
			this.m.SkillsUsedCount++;
		}
	}

	q.getMalus <- function()
	{
		return this.m.SkillsUsedCount * this.m.MalusPerCount;
	}
	
	q.onTurnEnd = @(__original) function()
	{
		this.m.SkillsUsedCount = this.Math.max(1, this.m.SkillsUsedCount - 1);	
		if (--this.m.TurnsLeft <= 0)
		{
			this.removeSelf();
		}
	}	
});
