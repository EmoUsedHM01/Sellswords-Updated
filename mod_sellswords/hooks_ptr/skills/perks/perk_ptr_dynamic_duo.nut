::mods_hookExactClass("skills/perks/perk_ptr_dynamic_duo", function ( o )
{
	local ws_create = o.create;
	o.create = function()
	{
		ws_create();

		this.m.Icon = "ui/perks/ptr_dynamic_duo.png";		
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
	}

	o.getDescription = function()
	{
		return this.skill.getDescription();
	}

	o.getTooltip = function() {}

	o.onGetHitFactors = function(_skill, _targetTile, _tooltip) {}

	o.onUpdate = function(_properties) {}

	o.onMovementFinished = function(_tile) {}
	
	o.onAfterUpdate = function(_properties) {}

	o.onBeforeDamageReceived = function(_attacker, _skill, _hitInfo, _properties) {}

	o.onMissed = function(_attacker, _skill) {}

	o.onTargetHit = function(_skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor) {}

	o.onTargetMissed = function(_skill, _targetEntity) {}

	o.onTurnStart = function() {}

	o.onAdded <- function()
	{
		if (!this.m.Container.hasSkill("actives.cr_delay"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/cr_delay"));
		}
		local addPerk = function ( _perk, _row = 0 )
		{
			local actor = this.getContainer().getActor();

			if (typeof actor == "instance")
			{
				actor = actor.get();
			}

			if (!this.isKindOf(actor, "player"))
			{
				return;
			}

			local bg = this.getContainer().getActor().getBackground();

			if (bg == null)
			{
				return;
			}

			bg.addPerk(_perk, _row);
		};

		if (!this.getContainer().hasSkill("perk.crFurinkazan"))
		{
			addPerk(this.Const.Perks.PerkDefs.crFurinkazan, 5);
		}		
	}

	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
	{
		if (_skill.isAttack() && _targetEntity != null && _targetEntity.getID() != this.getContainer().getActor().getID() && _targetEntity.getFaction() == this.getContainer().getActor().getFaction())
		{
			_properties.MeleeSkillMult *= 0.05;
			_properties.RangedSkillMult *= 0.05;
		}
	}	

	o.onRemoved <- function()
	{
		this.m.Container.removeByID("actives.cr_delay");
	}
});	