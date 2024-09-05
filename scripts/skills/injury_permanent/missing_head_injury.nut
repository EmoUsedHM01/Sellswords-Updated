this.missing_head_injury <- this.inherit("scripts/skills/injury_permanent/permanent_injury", {
	m = {},
	function create()
	{
		this.permanent_injury.create();
		this.m.ID = "injury.missing_head";
		this.m.Name = "Missing Head";
		this.m.Icon = "ui/injury/injury_permanent_icon_headless.png";
		this.m.Description = "Uh-oh! Looks like someone wasn't listening when we told the men of the company to 'keep their heads'. Missing a head will prevent this character from wearing helmets, biting... or speaking.";
	}

	function getTooltip()
	{
		local ret = [
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
		this.addTooltipHint(ret);
		return ret;
	}

	function onAdded()
	{
		local items = this.getContainer().getActor().getItems();

		if (items.getItemAtSlot(this.Const.ItemSlot.Head))
		{
			local item = items.getItemAtSlot(this.Const.ItemSlot.Head);
			item.drop();
		}

		items.getData()[this.Const.ItemSlot.Head][0] = -1;

		if (this.isKindOf(actor.get(), "undead_player"))
			actor.setHeadLess(true);
	}

	function onRemoved()
	{
		local actor = this.getContainer().getActor();
		actor.getItems().getData()[this.Const.ItemSlot.Head][0] = null;

		if (this.isKindOf(actor.get(), "undead_player"))
			actor.setHeadLess(false);
	}

});