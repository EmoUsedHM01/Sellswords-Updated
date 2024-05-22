::mods_hookExactClass("skills/actives/bf_sword_thrust_skill", function ( o )
{
	o.onGetHitFactors <- function ( _skill, _targetTile, _tooltip )
	{
		if (_skill.getID() != "actives.bf_sword_thrust")
		{
			return;
		}
		local targetEntity = _targetTile.getEntity();
		local targetArmor = targetEntity.getArmor(this.Const.BodyPart.Body);		
		if (targetArmor > 125)
		{
			local modarmor = this.Math.min(35, (targetArmor - 125) / 5);
			_tooltip.push({
				icon = "ui/tooltips/negative.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]" + modarmor + "%[/color] Firm armor"
			});				
		}	
	}				
});