::Mod_Sellswords.HooksMod.hook("scripts/skills/perks/perk_legend_athlete", function ( q ) {
	q.onAdded = @( __original ) function ()
	{
		if (!this.m.Container.hasSkill("actives.legend_climb"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/legend_climb"));
		}
		if (!this.m.Container.hasSkill("actives.sprint"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/sprint_skill_5"));
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
	q.onRemoved = @( __original ) function()
	{
		this.m.Container.removeByID("actives.legend_climb");
		this.m.Container.removeByID("actives.sprint");
	}
	q.onSerialize <- function ( _out )
	{
		this.skill.onSerialize(_out);
	};
	q.onDeserialize <- function ( _in )
	{
		this.skill.onDeserialize(_in);
	};		
});	

