::Mod_Sellswords.HooksMod.hook("scripts/skills/perks/perk_legend_barter_greed", function ( q ) {

	q.getTooltip = @( __original ) function ()
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
				id = 10,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=%positive%]+" + this.Math.min(20, this.getBonus() * 0.0006) + "[/color] Melee Skill"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "[color=%positive%]+" + this.Math.min(20, this.getBonus() * 0.0006) + "[/color] Ranged Skill"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=%positive%]+" + this.Math.min(20, this.getBonus() * 0.0004) + "[/color] Melee Defense"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=%positive%]+" + this.Math.min(20, this.getBonus() * 0.0004) + "[/color] Ranged Defense"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "[color=%positive%]+" + this.Math.min(20, this.getBonus() * 0.0008) + "[/color] Resolve"
			}
		];
	}

	q.onUpdate = @( __original ) function ( _properties )
	{
		_properties.MeleeSkill += this.Math.min(20, this.getBonus() * 0.0006);
		_properties.RangedSkill += this.Math.min(20, this.getBonus() * 0.0006);
		_properties.MeleeDefense += this.Math.min(20, this.getBonus() * 0.0004);
		_properties.RangedDefense += this.Math.min(20, this.getBonus() * 0.0004);
		_properties.Bravery += this.Math.min(20, this.getBonus() * 0.0008);
	}

	q.getBonus <- function ()
	{
		local mainhand = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		local offhand = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);
		local body = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Body);
		local head = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Head);
		local mainhandvalue = 0;
		local offhandvalue = 0;
		local bodyvalue = 0;
		local headvalue = 0;

		if (mainhand != null)
			mainhandvalue = mainhandvalue + mainhand.getValue();

		if (offhand != null)
			offhandvalue = offhandvalue + offhand.getValue();

		if (body != null)
			bodyvalue = bodyvalue + body.getValue();

		if (head != null)
			headvalue = headvalue + head.getValue();

		local gearvalue = mainhandvalue + offhandvalue + bodyvalue + headvalue; 
		return gearvalue;
	}

});