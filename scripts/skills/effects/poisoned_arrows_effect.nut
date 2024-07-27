this.poisoned_arrows_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.poisoned_arrows";
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

		if (this.isGarbage())
			return;

		if (::Mod_Sellswords.doArrowChecks( _skill, _targetEntity, actor))
			return;
		
		if (!(ammo.m.Name == "Quiver of Poisoned Bolts" || ammo.m.Name == "Quiver of Poisoned Arrows"))
			return;

		if (_targetEntity.getFlags().has("undead"))
			return;

		if (_targetEntity.getCurrentProperties().IsImmuneToPoison || _targetEntity.getHitpoints() <= 0)
			return;

		if (!_targetEntity.isHiddenToPlayer())
		{
			local poisonSound = [
				"sounds/combat/poison_applied_01.wav",
				"sounds/combat/poison_applied_02.wav"
			];
			this.Sound.play(poisonSound[this.Math.rand(0, poisonSound.len() - 1)], this.Const.Sound.Volume.Actor, _targetEntity.getPos());
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_targetEntity) + " is poisoned");
		}

		local gobboPoison = _targetEntity.getSkills().getSkillByID("effects.goblin_poison");
		if (gobboPoison == null)
			_targetEntity.getSkills().add(this.new("scripts/skills/effects/goblin_poison_effect"));
		else
			gobboPoison.resetTime();
	}
});
