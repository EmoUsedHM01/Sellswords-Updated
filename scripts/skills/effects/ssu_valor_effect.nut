this.ssu_valor_effect <- this.inherit("scripts/skills/skill", {
	m = {
		IsApplied = false
	},
	function create()
	{
		this.m.ID = "effects.ssu_inspired";
		this.m.Name = ::Mod_Sellswords.Strings.ssu_valor_effect.Name;
		this.m.Description = ::Mod_Sellswords.Strings.ssu_valor_effect.Description;
		this.m.Icon = "ui/perks/perk_28.png";
		this.m.IconMini = "perk_28_mini";
		this.m.Overlay = "perk_28";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function onAdded()
	{
	}

	function onUpdate( _properties )
	{
		_properties.ActionPoints += 1;
	}

	function onTurnStart()
	{
		if (!this.m.IsApplied)
		{
			local actor = this.getContainer().getActor();
			actor.setActionPoints(this.Math.min(actor.getActionPointsMax(), actor.getActionPoints() + 1));
			this.m.IsApplied = true;
		}
	}

	function onResumeTurn()
	{
		if (!this.m.IsApplied)
		{
			local actor = this.getContainer().getActor();
			actor.setActionPoints(this.Math.min(actor.getActionPointsMax(), actor.getActionPoints() + 1));
			this.m.IsApplied = true;
		}
	}

	function onTurnEnd()
	{
		this.removeSelf();
	}

});

