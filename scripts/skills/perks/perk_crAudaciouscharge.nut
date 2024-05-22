this.perk_crAudaciouscharge <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.crAudaciouscharge";
		this.m.Name = this.Const.Strings.PerkName.crAudaciouscharge;
		this.m.Description = this.Const.Strings.PerkDescription.crAudaciouscharge;
		this.m.Icon = "ui/perks/perk_crAudaciouscharge.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.zcr_charge"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/zcr_charge"));
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

			if (bg == null)
			{
				return;
			}

			bg.addPerk(_perk, _row);
		};

		if (!this.getContainer().hasSkill("perk.crFurinkazan"))
		{
			addPerk(this.Const.Perks.PerkDefs.crFurinkazan, 5);
		}		
	}

	function onRemoved()
	{
		this.m.Container.removeByID("actives.zcr_charge");	
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


