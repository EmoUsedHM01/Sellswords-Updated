this.ssu_freezing_arrows_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.ssu_freezing_arrows";
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
				text = ::Mod_Sellswords.Strings.ssu_freezing_arrows_effect.Tooltip
			}
		]);
		return ret;
	}
	
	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		local actor = this.getContainer().getActor();
		local ammo = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Ammo);
		local weapon = actor.getMainhandItem();

		switch (true)
		{
			case this.isGarbage():
			case _targetEntity.getType() == this.Const.EntityType.TricksterGod:
			case !_skill.isAttack():
			case !_skill.isRanged():
			case !actor.isAlive():
			case actor.isDying():
			case _targetEntity == null:
			case !_targetEntity.isAlive():
			case _targetEntity.isDying():
			case weapon == null:
			case !(weapon.isWeaponType(::Const.Items.WeaponType.Bow) || weapon.isWeaponType(::Const.Items.WeaponType.Crossbow)):
				return;
		}

		if (!_targetEntity.isHiddenToPlayer())
			this.Tactical.EventLog.log(::Mod_Sellswords.text(::Mod_Sellswords.Strings.ssu_freezing_arrows_effect.Log, this.Const.UI.getColorizedEntityName(_targetEntity)));

		local chilled = _targetEntity.getSkills().getSkillByID("effects.chilled");

		if (chilled == null)
			_targetEntity.getSkills().add(this.new("scripts/skills/effects/chilled_effect"));
		else
			chilled.resetTime();
	}

});