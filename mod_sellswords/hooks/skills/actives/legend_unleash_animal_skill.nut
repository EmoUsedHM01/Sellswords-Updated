::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/legend_unleash_animal_skill", function ( q ) {
	q.addAnimalSkills = @( __original ) function ( entity )
	{
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
		if (!this.getContainer().hasSkill("perk.legend_doghandling"))
		{
			return;
		}
		if (!this.getContainer().hasSkill("actives.legend_attack_target"))
		{
			this.getContainer().add(this.new("scripts/skills/actives/legend_attack_target_skill"));
		}
		local skill = this.getContainer().getSkillByID("actives.legend_attack_target");
		skill.addPet(entity.getID());
		if (!this.getContainer().hasSkill("actives.legend_protect_target"))
		{
			this.getContainer().add(this.new("scripts/skills/actives/legend_protect_target_skill"));
		}
		skill = this.getContainer().getSkillByID("actives.legend_protect_target");
		skill.addPet(entity.getID());
		local ai = entity.getAIAgent();
		ai.m.Properties.TargetPriorityHitchanceMult = 2.0;
		ai.m.Properties.EngageAgainstSpearwallMult = 0.5;
		ai.m.Properties.EngageAgainstSpearwallWithShieldwallMult = 0.25;
	}
});
