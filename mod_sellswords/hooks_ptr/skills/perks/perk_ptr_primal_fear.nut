::mods_hookExactClass("skills/perks/perk_ptr_primal_fear", function ( o )
{
	o.m.Hittime <- 0;
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()

		this.m.BaseChance = 40;
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
	}
	
	o.getTooltip <- function ()
	{
		local tooltip = this.skill.getTooltip();

		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.Math.min(40, 5 * this.m.Hittime) + "%[/color] chance to hit the head"
		});
		return tooltip;
	}		
	o.onTargetHit = function ( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (_bodyPart != this.Const.BodyPart.Head || !_targetEntity.isAlive() || _targetEntity.isDying() || _targetEntity.getMoraleState() == this.Const.MoraleState.Ignore || (_targetEntity.getMoraleState() == this.Const.MoraleState.Fleeing + 1))
		{
			return;
		}

		if (this.Math.rand(1, 100) > this.getChance(_targetEntity))
		{
			return;
		}

		local user = this.getContainer().getActor();
		local targetTile = _targetEntity.getTile();
		if (!user.isHiddenToPlayer() && targetTile.IsVisibleForPlayer)
		{
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_targetEntity) + "\'s loses morale due to Primal Fear");
		}
		
		this.spawnIcon("perk_ptr_primal_fear", targetTile);
		_targetEntity.setMoraleState(this.Math.max(0, _targetEntity.getMoraleState() - 1));

		this.addTargetHit(_targetEntity);
		this.m.Hittime += 1;
	}		
	o.onUpdate <- function ( _properties )
	{
		_properties.HitChance[this.Const.BodyPart.Head] += this.Math.min(40, 5 * this.m.Hittime);
	}
	o.onCombatStarted <- function ()
	{
		this.m.Hittime = 0;
	}

	o.onCombatFinished <- function ()
	{
		this.m.Hittime = 0;
	}		
});