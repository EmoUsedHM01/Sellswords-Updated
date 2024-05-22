::mods_hookExactClass("skills/perks/perk_ptr_weapon_master", function ( o )
{
	o.m.IsValid <- false;
	o.m.wptype <- 0;

	o.isHidden = function()
	{
		local actor = this.getContainer().getActor();
		return !this.m.IsValid || !actor.isPlayerControlled() || !actor.isPlacedOnMap() || !this.isEnabled(actor.getCurrentProperties());
	}

	o.getItemActionCost = function(_items)
	{
		if (this.m.IsSpent)
		{
			return null;
		}

		local oneHandedCount = 0;

		foreach (item in _items)
		{
			if (item == null)
			{
				continue;
			}

			if (item.getSlotType() != this.Const.ItemSlot.Mainhand || (!item.isItemType(this.Const.Items.ItemType.MeleeWeapon) && !item.isWeaponType(this.Const.Items.WeaponType.Throwing)) || item.isItemType(this.Const.Items.ItemType.TwoHanded))
			{
				return null;
			}

			if (item.isItemType(this.Const.Items.ItemType.OneHanded))
			{
				oneHandedCount++;
			}
		}

		if (this.getWeaponType() != this.m.wptype)
		{
			this.m.IsValid = true;
		}
		
		if (oneHandedCount > 0)
		{
			return 0;
		}
				
		return null;
	}

	o.getWeaponType <- function()	
	{
		local weapon = this.getContainer().getActor().getMainhandItem();
		local weaponlist = [this.Const.Items.WeaponType.Axe,
							this.Const.Items.WeaponType.Dagger,
							this.Const.Items.WeaponType.Flail,
							this.Const.Items.WeaponType.Hammer,
							this.Const.Items.WeaponType.Mace,
							this.Const.Items.WeaponType.Spear,
							this.Const.Items.WeaponType.Sword,
							this.Const.Items.WeaponType.Throwing];
		foreach (weapontype in weaponlist)
		{
			if (weapon != null && weapon.isWeaponType(weapontype))		
			{
				return weapontype;
			}
		} 		
	}

	local ws_onUpdate = o.onUpdate;
	o.onUpdate = function(_properties)
	{
		ws_onUpdate( _properties );
		
		if (this.m.IsValid)
		{
			foreach (skill in this.getContainer().getSkillsByFunction(@(skill) skill.isAttack()))
			{
				if (skill.m.ActionPointCost >= 2)
				{
					skill.m.ActionPointCost = this.Math.max(1, skill.m.ActionPointCost - 2);
				}
			}
		}		
	}

	o.onAnySkillExecuted <- function( _skill, _targetTile, _targetEntity, _forFree )
	{
		if (_skill != null && _skill.getID() != null && _skill.getID().find("throw_") )
		{
		//	this.logDebug("------perk_ptr_weapon_master onAnySkillExecuted throw skill");
			this.m.IsValid = false;
			return;
		}
		
		if (_skill != null && _skill.getID() != null && (_skill.getID().find("legend_eat_") || _skill.getID().find("legend_drink_")))
		{
			this.logDebug("------perk_ptr_weapon_master onAnySkillExecuted throw skill");
			this.m.IsValid = false;
			return;
		}		
	
		if (!_forFree && _skill != null && (_skill.getActionPointCost() > 0 || _skill.getFatigueCost() > 0))
		{	
			this.m.IsValid = false;
		}
		//	this.logInfo("valid: " + this.m.IsValid);
		//	this.logInfo("wptype: " + this.m.wptype);
	}

	o.onTurnStart = function()
	{
		this.m.IsSpent = false;
		this.m.wptype = this.getWeaponType();
	}

	o.onCombatFinished = function()
	{
		this.skill.onCombatFinished();
		this.m.IsSpent = false;
		this.m.IsValid = false;
		this.m.wptype = 0;		
	}

});	