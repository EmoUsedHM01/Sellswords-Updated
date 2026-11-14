::Mod_Sellswords.HooksMod.hook("scripts/skills/racial/legend_mummy_racial", function( q ) {

	q.create = @(__original) function()
	{
		__original();
		this.m.Name = ::Mod_Sellswords.Strings.legend_mummy_racial.Name;
		this.m.Description = ::Mod_Sellswords.Strings.legend_mummy_racial.Description;
		this.m.Icon = "skills/legend_curse_of_the_mummy_effect.png";
		this.m.IconMini = "mini_icon_mummy_curse";
		this.m.Overlay = "mummy_curse";
	}
	
	q.onAdded = @(__original) function()
	{
		if (!this.getContainer().getActor().isPlayerControlled())
		{
			return;
		}
		
		this.m.Type = this.Const.SkillType.Racial | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.First + 1;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}
	
	q.getTooltip = @(__original) function()
	{
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 3
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Mod_Sellswords.Strings.legend_mummy_racial.Tooltip
			}
		];
	}

});