this.bleeding_arrows_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.bleeding_arrows";
		this.m.Name = " ";
		this.m.Description = " ";
		this.m.Icon = "";
		this.m.Type = this.Const.SkillType.Special | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.VeryLast;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = true;
	}
	
	function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		ret.extend([
			{
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Inflicts a bleed on the target that does 10 damage per turn, for 2 turns"
			}
		]);
		return ret;
	}
	
	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		local actor = this.getContainer().getActor();
		local ammo = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Ammo);

		if (_targetEntity.getCurrentProperties().IsImmuneToBleeding)
			return;

		if (!(ammo.m.Name == "Quiver of Serrated Bolts" || ammo.m.Name == "Quiver of Serrated Arrows"))
			return;

		if (::Mod_Sellswords.doArrowChecks( _skill, _targetEntity, actor))
			return;

		local effect = this.new("scripts/skills/effects/bleeding_effect");
		effect.setDamage(10);
		if (actor.getFaction() == this.Const.Faction.Player )
		{
			effect.setActor(actor);
		}
		_targetEntity.getSkills().add(effect);

		if (!_targetEntity.isHiddenToPlayer())
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_targetEntity) + " is bleeding");
	}
});
