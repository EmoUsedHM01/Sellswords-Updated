::mods_hookExactClass("skills/perks/perk_legend_specialist_ninetails_damage", function ( o )
{
	o.onUpdate = function ( _properties )
	{
		local dc = 0;
		local actor = this.getContainer().getActor();
		if (actor.isPlayerControlled())
		{
			dc = this.getContainer().getActor().getDaysWithCompany();
		}
	
		dc = this.Math.floor(dc / 7);
		dc = 0.01 * this.Math.min(5 * dc + 35, 100);
		local actor = this.getContainer().getActor();
		local item = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		local resolve = actor.getCurrentProperties().Bravery;

		if (item != null && item.isItemType(this.Const.Items.ItemType.Cultist))
		{
		  if (item.getID() == "weapon.legend_cat_o_nine_tails")
		  {
			_properties.DamageRegularMin += this.Math.floor(resolve * 0.05);
			_properties.DamageRegularMax += this.Math.floor(resolve * 0.1);
		  }
		  else
		  {
			_properties.DamageRegularMin += this.Math.floor(resolve * 0.05 * dc);
			_properties.DamageRegularMax += this.Math.floor(resolve * 0.1 *dc);
		  }
		}
	}
});