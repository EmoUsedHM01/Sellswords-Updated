::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/disarm_skill", function ( q ) {

	q.onAnySkillUsed = @( __original ) function( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_skill.resetField("HitChanceBonus");
			this.m.HitChanceBonus += this.getContainer().getActor().getCurrentProperties().IsSpecializedInCleavers ? 10 : 0;

			if (_targetEntity != null && _targetEntity.getType() == this.Const.EntityType.OrcWarlord)
			{
				this.m.HitChanceBonus -= 40;
			}
			_properties.MeleeSkill += this.m.HitChanceBonus;		
			_properties.DamageTotalMult = 0.0;
			_properties.HitChanceMult[this.Const.BodyPart.Head] = 0.0;
		}
	}

	q.onGetHitFactors <- function ( _skill, _targetTile, _tooltip )
	{
		if (_skill.getID() != "actives.disarm")
		{
			return;
		}		
		if (_targetTile.getEntity().getType() == this.Const.EntityType.OrcWarlord)
		{
			_tooltip.push({
				icon = "ui/tooltips/negative.png",
				text = "[color=%negative%]40%[/color] A formidable Orc Warlord"
			});				
		}	
	}		
});
