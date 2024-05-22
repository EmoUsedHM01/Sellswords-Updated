::mods_hookExactClass("skills/effects/ptr_formidable_approach_debuff_effect", function ( o )
{
	o.onBeforeDamageReceived <- function ( _attacker, _skill, _hitInfo, _properties )
	{
		if (_skill == null || !_skill.isAttack() || _attacker == null || _attacker.getID() == this.getContainer().getActor().getID())
		{
			return;
		}		
		local enemyPerk = _attacker.getSkills().getSkillByID("perk.ptr_formidable_approach");

		if (enemyPerk != null && enemyPerk.isEnabled() && _attacker.getTile().getDistanceTo(this.getContainer().getActor().getTile()) == 1)
		{
			this.addEnemy(_attacker.getID());				
			if(this.m.CurrentMalus < this.Math.floor(this.getCurrentMalusWeak()))
			{			
				this.updateMalusWeak();
			}
		}
	};
	o.getCurrentMalusWeak <- function ()
	{
		this.pruneEnemies();

		if (this.m.CurrentEnemies.len() == 0 || !this.isEnabled())
		{
			return 0;
		}

		local meleeSkill = 0;

		foreach( id in this.m.CurrentEnemies )
		{
			local enemy = this.Tactical.getEntityByID(id);

			if (enemy != null)
			{
				meleeSkill = this.Math.max(meleeSkill, enemy.getCurrentProperties().getMeleeSkill());
			}
		}

		local malusfactor = this.m.MalusFactor / 2;
		return meleeSkill * malusfactor;
	};
	o.updateMalusWeak <- function ()
	{
		this.m.CurrentMalus = this.Math.floor(this.getCurrentMalusWeak());
	};
});