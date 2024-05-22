::mods_hookExactClass("skills/perks/perk_ptr_unstoppable", function ( o )
{
	o.m.BonusPerStack <- 1;
	o.m.isKillValid <- true;

	local ws_create = o.create;
	o.create = function()
	{
		ws_create()
		this.m.MaxStacks = 30;
	}

	o.getTooltip = function()
	{
		local tooltip = this.skill.getTooltip();

		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/hitchance.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.getBonus() + "[/color] Melee Skill"
		});

		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/damage_dealt.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.getBonus() + "%[/color] Melee Damage"
		});

		return tooltip;
	}

	o.onBeforeTargetHit = function( _skill, _targetEntity, _hitInfo ) {};
	
	o.onTargetHit = function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor ) {}

	o.onTargetMissed = function( _skill, _targetEntity ) {}

	o.onTargetKilled <- function( _targetEntity, _skill )
	{
		local actor = this.getContainer().getActor();
		if (actor.isAlliedWith(_targetEntity))
		{
			return;
		}
		if (_skill == null || !_skill.isAttack())
		{
			return;
		}
		if (!this.m.isKillValid)
		{
			return;
		}						
		this.m.Stacks = this.Math.minf(this.m.MaxStacks, this.m.Stacks + 10);
		this.m.isKillValid = false;			
	}	

	function onDamageReceived( _attacker, _damageHitpoints, _damageArmor )
	{
		if (_attacker == null || _attacker == this.getContainer().getActor())
		{
			return;
		}		
		if (_damageHitpoints <= 20)
		{
			return;
		}		
		this.m.Stacks = this.Math.floor(this.m.Stacks / 2);
		//this.logInfo("HPdmg: " + _damageHitpoints);
	}

	o.getBonus <- function()
	{
		return this.Math.floor(this.m.Stacks) * this.m.BonusPerStack;
	}

	o.onUpdate = function( _properties )
	{
		local bonus = this.getBonus();
		_properties.MeleeSkill += bonus;
		_properties.MeleeDamageMult *= 1.0 + (bonus * 0.01);
	}

	o.onTurnStart <- function()
	{
		this.m.isKillValid = true;
	}
});	