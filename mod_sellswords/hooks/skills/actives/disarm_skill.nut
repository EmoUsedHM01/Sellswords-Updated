::mods_hookExactClass("skills/actives/disarm_skill", function ( o )
{
	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_skill.resetField("HitChanceBonus");
			if (!this.getContainer().getActor().getCurrentProperties().IsSpecializedInCleavers)
			{
				_properties.MeleeSkill -= 20;
			}
			else
			{
				_properties.MeleeSkill -= 10;
			}
			if (_targetEntity.getType() == this.Const.EntityType.OrcWarlord)
			{
				_properties.MeleeSkill -= 40;
			}				
			_properties.DamageTotalMult = 0.0;
			_properties.HitChanceMult[this.Const.BodyPart.Head] = 0.0;
		}
	}
	o.onGetHitFactors <- function ( _skill, _targetTile, _tooltip )
	{
		if (_skill.getID() != "actives.disarm")
		{
			return;
		}		
		if (_targetTile.getEntity().getType() == this.Const.EntityType.OrcWarlord)
		{
			_tooltip.push({
				icon = "ui/tooltips/negative.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]40%[/color] A formidable Orc Warlord"
			});				
		}	
	}		
});