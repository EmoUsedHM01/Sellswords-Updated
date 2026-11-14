this.perk_ssu_audaciouscharge <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.ssu_audaciouscharge";
		this.m.Name = this.Const.Strings.PerkName.SsuAudaciouscharge;
		this.m.Description = this.Const.Strings.PerkDescription.SsuAudaciouscharge;
		this.m.Icon = "ui/perks/ssu_audaciouscharge.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.ssu_charge"))
			this.m.Container.add(this.new("scripts/skills/actives/ssu_charge"));

		if (!this.m.IsNew)
			return;

		local addPerk = function ( _perk, _row = 0 )
		{
			local actor = this.getContainer().getActor();
			if (!actor.isPlayerControlled())
				return;

			local bg = actor.getBackground();
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
		}

		if (!this.getContainer().hasSkill("perk.ssu_furinkazan"))
			addPerk(this.Const.Perks.PerkDefs.SsuFurinkazan, 5);
	}

	function onRemoved()
	{
		this.m.Container.removeByID("actives.ssu_charge");
	}

	function onSerialize( _out )
	{
		this.skill.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		this.skill.onDeserialize(_in);
	}	

});