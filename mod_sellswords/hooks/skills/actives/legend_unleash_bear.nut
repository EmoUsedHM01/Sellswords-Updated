::mods_hookExactClass("skills/actives/legend_unleash_bear", function ( o )
{
	o.onUse = function ( _user, _targetTile )
	{
		_user.getSkills().add(this.new("scripts/skills/effects/legend_summoned_bear_effect"));
		local entity = this.Tactical.spawnEntity(this.m.Script, _targetTile.Coords.X, _targetTile.Coords.Y);
		entity.setFaction(this.Const.Faction.PlayerAnimals);
		entity.setName(this.m.EntityName);
		local houndeffect = this.new("scripts/skills/effects/cr_houndmaster_effect");
		if (this.getContainer().getActor().getSkills().hasSkill("perk.legend_dogwhisperer"))
		{
			entity.getSkills().add(this.new("scripts/skills/perks/perk_fortified_mind"));
			entity.getSkills().add(this.new("scripts/skills/perks/perk_colossus"));
			entity.getSkills().add(this.new("scripts/skills/perks/perk_underdog"));
		}
		if (this.getContainer().getActor().getSkills().hasSkill("perk.legend_dogbreeder"))
		{
			entity.getSkills().add(this.new("scripts/skills/perks/perk_fast_adaption"));			
			entity.getSkills().add(this.new("scripts/skills/perks/perk_crBackswing"));
			houndeffect.m.dogbreeder = true;
		}
		if (this.getContainer().getActor().getSkills().hasSkill("perk.legend_doghandling"))
		{
			entity.getSkills().add(this.new("scripts/skills/perks/perk_overwhelm"));
			houndeffect.m.doghandling = true;				
		}			
		if (this.getContainer().getActor().getSkills().hasSkill("perk.legend_packleader"))
		{
			entity.getSkills().add(this.new("scripts/skills/perks/perk_legend_assured_conquest"));
			houndeffect.m.packleader = true;				
		}	
		entity.getSkills().add(houndeffect);			
		return true;
	}
});	