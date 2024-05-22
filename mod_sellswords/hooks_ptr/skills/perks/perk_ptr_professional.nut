::mods_hookExactClass("skills/perks/perk_ptr_professional", function ( o )
{
	o.onAdded = function()
	{
		if (this.m.IsSpent)
		{
			return;
		}

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
			local hasRow = false;
			local direction = -1;
			local row = _row;
			while (row >= 0 && row <= 6)
			{
				if (bg.m.CustomPerkTree[row].len() < 13)
				{
					hasRow = true;
					break;
				}

				row += direction;

				if (row == -1)
				{
					row = _row;
					direction = 1;
				}
			}

			row = hasRow ? this.Math.max(0, this.Math.min(row, 6)) : _row;
			bg.addPerk(_perk, row);
			this.m.PerksAdded.push(_perk);
		}

		if (!this.getContainer().hasSkill("perk.shield_expert"))
		{
			this.getContainer().add(this.new("scripts/skills/perks/perk_shield_expert"));
			addPerk(this.Const.Perks.PerkDefs.ShieldExpert, 2);
		}

		if (!this.getContainer().hasSkill("perk.quick_hands"))
		{
			this.getContainer().add(this.new("scripts/skills/perks/perk_quick_hands"));
			addPerk(this.Const.Perks.PerkDefs.QuickHands, 1);
		}

		if (!this.getContainer().hasSkill("perk.duelist"))
		{
			this.getContainer().add(this.new("scripts/skills/perks/perk_duelist"));
			addPerk(this.Const.Perks.PerkDefs.Duelist, 5);
		}

		if (!this.getContainer().hasSkill("perk.bags_and_belts"))
		{
			this.getContainer().add(this.new("scripts/skills/perks/perk_bags_and_belts"));
			addPerk(this.Const.Perks.PerkDefs.BagsAndBelts, 0);	
		}

		if (!this.getContainer().hasSkill("perk.ptr_bloody_harvest"))
		{
			this.getContainer().add(this.new("scripts/skills/perks/perk_ptr_bloody_harvest"));
			addPerk(this.Const.Perks.PerkDefs.PTRBloodyHarvest, 1);
		}

		this.m.IsSpent = true;
	}
});	