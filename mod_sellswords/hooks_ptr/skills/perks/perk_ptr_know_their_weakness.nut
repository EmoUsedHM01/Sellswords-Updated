::mods_hookExactClass("skills/perks/perk_ptr_know_their_weakness", function ( o )
{
	o.m.IsSpent <- false;

	o.isHidden = function()
	{
		return this.m.IsSpent;
	}

	o.onUpdate = function(_properties) {}

	o.onBeforeDamageReceived = function(_attacker, _skill, _hitInfo, _properties) {}

	o.onTargetKilled = function(_targetEntity, _skill) {}

	o.getTooltip = function()
	{
		local tooltip = this.skill.getTooltip();

		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = "this character's next attack will decrease targets' defense and resolve."
		});

		return tooltip;
	}

	o.onTargetHit <- function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (this.m.IsSpent)
		{
			return;
		}
		if (!_targetEntity.isAlive() || _targetEntity.isDying())
		{
			return;
		}

		_targetEntity.getSkills().add(this.new("scripts/skills/effects/cr_fragile_effect"));
		this.m.IsSpent = true;		
	}	

	o.onTurnStart <- function()
	{
		this.m.IsSpent = false;
	}

	o.onCombatStarted <- function()
	{
		this.m.IsSpent = false;
	}
});	