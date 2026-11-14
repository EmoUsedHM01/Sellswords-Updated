this.ssu_bandage_effect <- this.inherit("scripts/skills/skill", {
	m = {
	TurnsLeft = 1
	},
	function create()
	{
		this.m.ID = "effects.ssu_bandage";
		this.m.Name = ::Mod_Sellswords.Strings.ssu_bandage_effect.Name;
		this.m.Icon = "ui/perks/perk_55.png";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = false;		
	}	

	function onTurnEnd()
	{
		local actor = this.getContainer().getActor();
		actor.setHitpoints(this.Math.min(actor.getHitpointsMax(), actor.getHitpoints() + 5));
		if (--this.m.TurnsLeft <= 0)
		{
			this.removeSelf();
		}
	}
});

