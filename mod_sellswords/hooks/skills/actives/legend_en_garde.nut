::mods_hookExactClass("skills/actives/legend_en_garde", function ( o )
{
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()

		this.m.FatigueCost = 20;
	}

	o.onGetHitFactors <- function ( _skill, _targetTile, _tooltip )
	{
		if (_skill.getID() != "actives.legend_en_garde")
		{
			return;
		}
		_tooltip.push({
			icon = "ui/tooltips/positive.png",				
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]" + 20 + "%[/color] Counter attack"
		});				
	}
	
	o.getTooltip = function ()
	{
		local ret = this.skill.getDefaultTooltip();
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Inflicts [color=" + this.Const.UI.Color.DamageValue + "] -10 [/color] melee and ranged defense"
		});
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/hitchance.png",
			text = "Using [color=" + this.Const.UI.Color.DamageValue + "] 120% [/color] melee skill"
		});			
		if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInDaggers)
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Has a [color=" + this.Const.UI.Color.PositiveValue + "]100%[/color] chance to parry on a hit thanks to Dagger Mastery"
			});
		}
		else
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Has a [color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.StunChance + "%[/color] chance to parry on a hit due to not having Dagger Mastery"
			});
		}

		return ret;
	}		
	
	o.onAnySkillUsed <- function ( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.DamageRegularMin = 20;
			_properties.DamageRegularMax = 40;
			_properties.DamageArmorMult = 0.7;
			_properties.DamageDirectMult = 0.2;
			_properties.MeleeSkill *= 1.2;				
		}
	}		
});	