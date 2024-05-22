::mods_hookExactClass("skills/perks/perk_ptr_a_better_grip", function(o) 
{
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()

		this.m.BonusPerStack = 4;
		this.m.MaxStacks = 5;
	}

	o.onAnySkillUsed = function ( _skill, _targetEntity, _properties )
	{
		if (!this.isEnabled() || !_skill.isAttack() || _targetEntity == null) return;			
		if (_skill.getID() == "actives.thrust" || _skill.getID() == "actives.repel")
		{
			if (_targetEntity != null && this.getContainer().getActor().isDoubleGrippingWeapon())
			{
				local targetTile = _targetEntity.getTile();
				local myTile = this.getContainer().getActor().getTile();
				if (myTile.getDistanceTo(targetTile) == 2)
				{
					_properties.DamageTotalMult *= this.m.DamageMultAtTwoTiles;
					local betweenTiles = [];
					local malus = _skill.m.HitChanceBonus;						
					for (local i = 0; i < 6; i++)
					{
						if (targetTile.hasNextTile(i))
						{
							local nextTile = targetTile.getNextTile(i);
							if (nextTile.getDistanceTo(myTile) == 1)
							{
								betweenTiles.push(nextTile);
								if (betweenTiles.len() == 2)
								{
									break;
								}
							}
						}
					}
					foreach (tile in betweenTiles)
					{
						if (tile.IsOccupiedByActor)
						{
							malus += 20;
						}
					}
					_skill.m.HitChanceBonus -= malus;
					_properties.MeleeSkill -= malus;
				}
			}
			else if (_targetEntity != null && this.getContainer().getActor().getMainhandItem().isItemType(this.Const.Items.ItemType.TwoHanded))
			{
				local targetTile = _targetEntity.getTile();
				local myTile = this.getContainer().getActor().getTile();
				if (myTile.getDistanceTo(targetTile) == 1)
				{
					_skill.m.HitChanceBonus += 15;
					_properties.MeleeSkill += 15;
				}
			}				
		}
		if (_targetEntity.getID() in this.m.Opponents)
		{
			_properties.MeleeSkill += this.getBonus(_targetEntity.getID());
		}
	}		
});	