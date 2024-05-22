::mods_hookExactClass("skills/actives/legend_prepare_knockback_skill", function ( o )
{
	o.onAfterUpdate <- function ( _properties )
	{
		this.m.FatigueCost = 10;
		local weapon = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		if (weapon != null && weapon.isItemType(this.Const.Items.ItemType.MeleeWeapon) && weapon.isItemType(this.Const.Items.ItemType.TwoHanded))
		{
			this.m.ActionPointCost = 1;
		}
		else
		{
			this.m.ActionPointCost = 2;
		}			
	};	
	o.getTooltip = function ()
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
			},
			{
				id = 3,
				type = "text",
				text = this.getCostString()
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "The next attack will delay the opponent's turn order to the end if it connects"
			}
		];
		return ret;
	}		
});	