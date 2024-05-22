::mods_hookExactClass("skills/backgrounds/brawler_background", function(o) {
	o.onChangeAttributes = function()
	{
		return {
			Hitpoints = [
				5,
				10
			],
			Bravery = [
				7,
				5
			],
			Stamina = [
				10,
				5
			],
			MeleeSkill = [
				5,
				0
			],
			RangedSkill = [
				0,
				0
			],
			MeleeDefense = [
				0,
				0
			],
			RangedDefense = [
				0,
				0
			],
			Initiative = [
				15,
				5
			]
		};
	}
	
	o.getTooltip = function()
	{
		local ret = this.character_background.getTooltip();
		ret.push({
			id = 12,
			type = "text",
			icon = "ui/icons/regular_damage.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+15%[/color] Damage when unarmed"
		});
		return ret;
	}
})