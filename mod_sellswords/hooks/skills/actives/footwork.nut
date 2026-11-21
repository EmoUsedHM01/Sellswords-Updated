::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/footwork", function ( q ) {

	q.onAfterUpdate = @( __original ) function ( _properties )
	{
		this.m.FatigueCost = 10;
		local fat = this.getContainer().getActor().getItems().getStaminaModifier([::Const.ItemSlot.Body, ::Const.ItemSlot.Head]) * -1;
		this.m.FatigueCost = ::Math.min(20, this.m.FatigueCost + fat);
		
		local frkz = this.getContainer().hasSkill("perk.ssu_furinkazan");
		this.m.FatigueCostMult = _properties.IsFleetfooted || frkz ? 0.5 : 1.0;

		if (this.getContainer().hasSkill("effects.goblin_grunt_potion") || this.getContainer().hasSkill("effects.ssu_goblin_sequence") || frkz)
		{
			this.m.ActionPointCost = 2;
		}			
	};		
	q.onAdded <- function ()
	{
		local addPerk = function ( _perk, _row = 0 )
		{
			local actor = this.getContainer().getActor();

			if (typeof actor == "instance")
			{
				actor = actor.get();
			}

			if (!this.isKindOf(actor, "player"))
			{
				return;
			}

			local bg = this.getContainer().getActor().getBackground();

			if (bg == null)
			{
				return;
			}

			bg.addPerk(_perk, _row);
		};

		if (!this.getContainer().hasSkill("perk.ssu_furinkazan"))
		{
			addPerk(this.Const.Perks.PerkDefs.SsuFurinkazan, 5);
		}
	};
});
