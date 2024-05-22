::mods_hookExactClass("skills/perks/perk_sprint", function ( o )
{
	o.onAdded = function ()
	{
		if (!this.m.Container.hasSkill("actives.sprint"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/sprint_skill_5"));
		}
		if (!this.m.Container.hasSkill("actives.sprint_3"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/sprint_skill_3"));
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
	o.onRemoved <- function ()
	{
		this.m.Container.removeByID("actives.sprint");
		this.m.Container.removeByID("actives.sprint_3");		
	}
	o.onSerialize <- function ( _out )
	{
		this.skill.onSerialize(_out);
	};
	o.onDeserialize <- function ( _in )
	{
		this.skill.onDeserialize(_in);
	};		
});	