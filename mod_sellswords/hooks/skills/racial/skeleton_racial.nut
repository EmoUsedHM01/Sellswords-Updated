::Mod_Sellswords.HooksMod.hook("scripts/skills/racial/skeleton_racial", function( q ) {

	q.create = @(__original) function()
	{
		__original();
		this.m.Name = "Resistant to Ranged Attacks";
		this.m.Description = "Ranged, Slashing and Piercing attacks are not very effective against this character.";
		this.m.Icon = "ui/perks/perk_32.png";
		this.m.IconMini = "perk_32_mini";
		this.m.IsHidden = true;
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
			}
		];
	}

});