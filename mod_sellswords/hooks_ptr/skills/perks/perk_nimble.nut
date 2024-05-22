::mods_hookExactClass("skills/perks/perk_nimble", function(o) {
	o.getReductionChance <- function( _reduction )
	{
		local fat = 0;
		local body = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Body);
		local head = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Head);

		if (body != null)
		{
			fat = fat + body.getStaminaModifier();
		}

		if (head != null)
		{
			fat = fat + head.getStaminaModifier();
		}

		fat = this.Math.min(0, fat + 15);
		if (!this.getContainer().getActor().isPlayerControlled())
		{
			return this.Math.minf(1.0, 1.0 - _reduction + this.Math.pow(this.Math.abs(fat), 1.3) * 0.01);
		}
		else
		{
			return this.Math.minf(1.0, 1.0 - _reduction + this.Math.pow(this.Math.abs(fat), 1.4) * 0.01);
		}						
	}
});	