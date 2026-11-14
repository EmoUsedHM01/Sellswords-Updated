::Mod_Sellswords.HooksMod.hook("scripts/items/accessory/sergeant_badge_item", function ( q ) {

	q.m.ResolveBonus <- 0;

	q.getTooltip = @( __original ) function()
	{
		local ret = __original();

		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/bravery.png",
			text = ::Mod_Sellswords.Strings.sergeant_badge_item.Tooltip1
		});
		ret.push({
			id = 11,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.sergeant_badge_item.Tooltip2, this.m.ResolveBonus)
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

			if (itemAtSlot != null && (itemAtSlot.m.ID == "accessory.ssu_militia_armband" || itemAtSlot.m.ID == "accessory.sergeant_badge"))
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