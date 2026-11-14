this.ssu_missing_head_injury <- this.inherit("scripts/skills/injury_permanent/permanent_injury", {
	m = {},
	function create()
	{
		this.permanent_injury.create();
		this.m.ID = "injury.ssu_missing_head";
		this.m.Name = ::Mod_Sellswords.Strings.ssu_missing_head_injury.Name;
		this.m.Icon = "ui/injury/ssu_injury_permanent_icon_headless.png";
		this.m.Description = ::Mod_Sellswords.Strings.ssu_missing_head_injury.Description;
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

		if (this.isKindOf(actor.get(), "ssu_necro_undead_player"))
			actor.setHeadLess(true);
	}

	function onRemoved()
	{
		local actor = this.getContainer().getActor();
		actor.getItems().getData()[this.Const.ItemSlot.Head][0] = null;

		if (this.isKindOf(actor.get(), "ssu_necro_undead_player"))
			actor.setHeadLess(false);
	}

});