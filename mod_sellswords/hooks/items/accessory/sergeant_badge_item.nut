::Mod_Sellswords.HooksMod.hook("scripts/items/accessory/sergeant_badge_item", function ( q ) {

	q.m.ResolveBonus <- 0;

	q.getTooltip = @( __original ) function()
	{
		local ret = __original();

		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/bravery.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+1[/color] Resolve per ally wearing a militia armband or sergeant\'s sash."
		});
		ret.push({
			id = 11,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Current bonus: [color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.ResolveBonus + "[/color]"
		});

		return ret;
	}

	q.updateResolveBonus <- function()
	{
		this.m.ResolveBonus = 0;
		local roster = ::World.getPlayerRoster().getAll();

		foreach( bro in roster )
		{
			local itemAtSlot = bro.getItems().getItemAtSlot(this.Const.ItemSlot.Accessory);

			if (itemAtSlot != null && (itemAtSlot.m.ID == "accessory.militia_armband" || itemAtSlot.m.ID == "accessory.sergeant_badge"))
				this.m.ResolveBonus += 1;
		}
	}

	q.onTurnStart <- function()
	{
		this.updateResolveBonus();
	}

	q.onCombatStarted <- function()
	{
		this.updateResolveBonus();
	}

	q.onUpdateProperties = @( __original ) function( _properties )
	{
		__original( _properties );
		this.updateResolveBonus();
		_properties.Bravery += this.m.ResolveBonus;
	}

});