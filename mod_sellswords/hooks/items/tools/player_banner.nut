::Mod_Sellswords.HooksMod.hook("scripts/items/tools/player_banner", function ( q ) {

	q.getTooltip = @(__original) function()
	{
		local result = this.weapon.getTooltip();
		result.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Mod_Sellswords.Strings.player_banner.Tooltip
		});
		return result;
	};
	
	q.onEquip = @(__original) function()
	{
		__original();

		local skill = ::new("scripts/skills/actives/ssu_banner_wave");
		skill.setItem(this);
		this.addSkill(skill);	
	};
});
