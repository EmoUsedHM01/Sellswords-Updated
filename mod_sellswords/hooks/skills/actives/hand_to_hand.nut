::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/hand_to_hand", function ( q ) {

	q.getTooltip = @( __original ) function ()
	{
		local ret = this.getDefaultTooltip();
		local actor = this.getContainer().getActor();
		local fatigueMultiplier = 1;

		if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInFists)
		{
			fatigueMultiplier = 2;
		}

		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Inflicts [color=" + this.Const.UI.Color.DamageValue + "]" + this.Const.Combat.FatigueReceivedPerHit * fatigueMultiplier + "[/color] extra fatigue on hit"
		});

		foreach( bg in this.m.Backgrounds )
		{
			if (actor.getSkills().hasSkill(bg))
			{
				ret.push({
					id = 7,
					type = "text",
					icon = "ui/icons/regular_damage.png",
					text = "[color=" + this.Const.UI.Color.PositiveValue + "]+15%[/color] damage from background"
				});
				break;
			}
		}
		if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInFists)
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Has a [color=" + this.Const.UI.Color.PositiveValue + "]10%[/color] additional chance to hit"
			});
		}

		return ret;
	};
	
	q.onAnySkillUsed = @( __original) function ( _skill, _targetEntity, _properties )
	{
		__original( _skill, _targetEntity, _properties );
		if (_skill == this && this.getContainer().getActor().getCurrentProperties().IsSpecializedInFists)
		{
			_properties.MeleeSkill += 10;
			this.m.HitChanceBonus += 10;
		}
	};
});
