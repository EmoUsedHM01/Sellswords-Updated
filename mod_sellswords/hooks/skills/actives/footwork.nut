::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/footwork", function ( q ) {

	q.onAfterUpdate = @( __original ) function ( _properties )
	{
		local fat = this.getContainer().getActor().getItems().getStaminaModifier([::Const.ItemSlot.Body, ::Const.ItemSlot.Head]) * -1;
		this.m.FatigueCost = ::Math.min(20, 10 + fat);

		// Legends lowers the cost when used to step to a tile, and handles Fleet-footed and the goblin grunt potion
		__original(_properties);

		if (this.getContainer().hasSkill("perk.ssu_furinkazan") && !_properties.IsFleetfooted)
			this.m.FatigueCostMult = 0.5;

		if ((this.getContainer().hasSkill("perk.ssu_furinkazan") || this.getContainer().hasSkill("effects.ssu_goblin_sequence")) && !this.getContainer().hasSkill("effects.goblin_grunt_potion"))
			this.m.ActionPointCost = ::Math.min(this.m.ActionPointCost, 2);
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
