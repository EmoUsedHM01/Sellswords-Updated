this.ssu_dryad_thorns_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.ssu_dryad_thorns";
		this.m.Name = ::Mod_Sellswords.Strings.ssu_dryad_thorns_trait.Name;
		this.m.Description = "";
		this.m.Icon = "";
		this.m.Type = this.Const.SkillType.Special | this.Const.SkillType.Trait;
		this.m.IsHidden = true;
	}

	function onDamageReceived( _attacker, _damageHitpoints, _damageArmor )
	{
		if (_attacker == null || !_attacker.isAlive() || _attacker.getTile().getDistanceTo(this.getContainer().getActor().getTile()) != 1 || _attacker.getCurrentProperties().IsImmuneToDamageReflection)
			return;

		if (_damageArmor > 0)
		{
			local reflectedDamage = this.Math.floor(0.3 * _damageArmor);

			// Create a new hit info object to apply the damage
			local hitInfo = clone this.Const.Tactical.HitInfo;
			hitInfo.DamageRegular = reflectedDamage;
			hitInfo.DamageDirect = 0.3;
			hitInfo.BodyPart = this.Const.BodyPart.Body;
			hitInfo.BodyDamageMult = 1.0;
			hitInfo.FatalityChanceMult = 0.0;

			if (!this.getContainer().getActor().isHiddenToPlayer())
				this.Tactical.EventLog.log(::Mod_Sellswords.text(::Mod_Sellswords.Strings.ssu_dryad_thorns_trait.Log, this.Const.UI.getColorizedEntityName(this.getContainer().getActor()), reflectedDamage, this.Const.UI.getColorizedEntityName(_attacker)));

			_attacker.onDamageReceived(this.getContainer().getActor(), null, hitInfo);
		}
	}

});