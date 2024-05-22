::mods_hookExactClass("skills/perks/perk_ptr_push_it", function ( o )
{
	o.isEnabled = function()
	{
		return true;
	}

	o.onBeforeAnySkillExecuted = function( _skill, _targetTile, _targetEntity, _forFree ) {}

	o.onAnySkillExecuted = function( _skill, _targetTile, _targetEntity, _forFree ) {}

	o.onTargetHit = function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor ) {}
});	