this.perk_crReachadvantage <- this.inherit("scripts/skills/skill", {
	m = {
		Opponents = [],		
		tempOpponents = [] ,
	},
	function create()
	{
		this.m.ID = "perk.crReachadvantage";
		this.m.Name = this.Const.Strings.PerkName.crReachadvantage;
		this.m.Description = "This character is using the superior reach of their melee weapon to keep opponents at bay.";
		this.m.Icon = "ui/perks/perk_19.png";
		//this.m.IconMini = "perk_19_mini";
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk | this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function isHidden()
	{
		local weapon = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);	
		return this.m.Opponents.len() == 0 || !(weapon != null && weapon.isItemType(this.Const.Items.ItemType.MeleeWeapon) && weapon.isItemType(this.Const.Items.ItemType.TwoHanded));
	}

	function getOpponentEntry(_entityID)
	{
		foreach (opponentEntry in this.m.tempOpponents)
		{
			if (opponentEntry == _entityID)
			{
				return opponentEntry;
			}
		}

		return null;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();
		local mk = this.getContainer().getActor().getCurrentProperties().getMeleeSkill();

		tooltip.push(
			{
				id = 10,
				type = "text",
				icon = "ui/icons/plus.png",
				text = "Have reach advantages over them"
			}
		);		

		foreach (opponentEntry in this.m.Opponents)
		{
			local opponent = this.Tactical.getEntityByID(opponentEntry);
			if (opponent == null || !opponent.isPlacedOnMap() || !opponent.isAlive() || opponent.isDying())
			{
				continue;
			}

			tooltip.push(
				{
					id = 10,
					type = "text",
					icon = "ui/orientation/" + opponent.getOverlayImage() + ".png",
					text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + mk + "[/color] melee defense against " + opponent.getName()
				}
			);
		}

		return tooltip;
	}
	
	//function procIfApplicable(_entity, _skill)
	//{
	//	local actor = this.getContainer().getActor();
	//	if (!actor.isPlacedOnMap() || actor.getMoraleState() == this.Const.MoraleState.Fleeing)
	//	{
	//		return;
	//	}
	//	if (_skill == null || !_skill.isAttack() || _skill.isRanged() || _entity == null || _entity.isAlliedWith(actor))
	//	{
	//		return;
	//	}
	//	foreach (opponentEntry in this.m.Opponents)
	//	{
	//		if (opponentEntry == _entity.getID())
	//		{
	//			return;
	//		}
	//	}
	//	this.m.Opponents.push(_entity.getID());
	//	foreach (opponentEntry in this.m.tempOpponents)
	//	{
	//		if (opponentEntry == _entity.getID())
	//		{
	//			return;
	//		}
	//	}
	//	this.m.tempOpponents.push(_entity.getID());		
	//}
	function procIfApplicable(_entity)
	{
		local actor = this.getContainer().getActor();
		if (!actor.isPlacedOnMap() || actor.getMoraleState() == this.Const.MoraleState.Fleeing)
		{
			return;
		}
		foreach (opponentEntry in this.m.Opponents)
		{
			if (opponentEntry == _entity.getID())
			{
				return;
			}
		}
		this.m.Opponents.push(_entity.getID());
		foreach (opponentEntry in this.m.tempOpponents)
		{
			if (opponentEntry == _entity.getID())
			{
				return;
			}
		}
		this.m.tempOpponents.push(_entity.getID());		
	}	

	function onUpdate( _properties )
	{
		for (local i = this.m.Opponents.len() - 1; i >= 0; i--)
		{			
			local e = this.Tactical.getEntityByID(this.m.Opponents[i]);      //Opponents.push(_entity.getID())  entity id is inputed
			if (e == null || !e.isAlive())
			{
				this.m.Opponents.remove(i);
			}
		}
		for (local i = this.m.tempOpponents.len() - 1; i >= 0; i--)
		{
			local e = this.Tactical.getEntityByID(this.m.tempOpponents[i]);
			if (e == null || !e.isAlive())
			{
				this.m.tempOpponents.remove(i);
			}
		}				
	}

	//function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	//{	
	//	if (!_targetEntity.isAlive() || _targetEntity.isDying())
	//	{
	//		return;
	///	}
	//	local weapon = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
	//	if (weapon != null && weapon.isItemType(this.Const.Items.ItemType.MeleeWeapon) && weapon.isItemType(this.Const.Items.ItemType.TwoHanded))
	//	{
	//		this.procIfApplicable(_targetEntity, _skill);
	//	}
	//}

	//function onTargetMissed( _skill, _targetEntity )
	//{	
	//	local weapon = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
	//	if (weapon != null && weapon.isItemType(this.Const.Items.ItemType.MeleeWeapon) && weapon.isItemType(this.Const.Items.ItemType.TwoHanded))
	//	{
	//		this.procIfApplicable(_targetEntity, _skill);
	//	}		
	//}
	
	//function onDamageReceived( _attacker, _damageHitpoints, _damageArmor )
	//{
	//	if (_attacker != null && (_attacker.getID() in this.m.Opponents))
	//	{
	//		delete this.m.Opponents[_attacker.getID()];
	//		delete this.m.tempOpponents[_attacker.getID()];			
	//	}
	//}	

	function onBeingAttacked( _attacker, _skill, _properties )
	{
		if (_attacker != null && _skill != null && !_skill.isRanged() && _skill.isAttack())
		{
			local opponentEntry = this.getOpponentEntry(_attacker.getID());
			if (opponentEntry != null)
			{
				_properties.MeleeDefense += _properties.MeleeSkill;
			}
		}
	}
	
	function onWaitTurn()
	{
		this.m.tempOpponents.clear();	
		local actor = this.getContainer().getActor();
		local weapon = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);		
		if (!this.getContainer().getSkillByID("effects.crReachadvantage") && actor.hasZoneOfControl() && weapon != null && weapon.isItemType(this.Const.Items.ItemType.MeleeWeapon) && weapon.isItemType(this.Const.Items.ItemType.TwoHanded) && this.m.Opponents.len() > 0)
		{
			this.getContainer().add(this.new("scripts/skills/effects/crReachadvantage_effect"));			
		}			
	}
	
	function onTurnEnd()
	{	
		this.m.tempOpponents.clear();	
		local actor = this.getContainer().getActor();
		local weapon = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);		
		if (!this.getContainer().getSkillByID("effects.crReachadvantage") && !this.getContainer().getSkillByID("effects.spearwall") && actor.hasZoneOfControl() && weapon != null && weapon.isItemType(this.Const.Items.ItemType.MeleeWeapon) && weapon.isItemType(this.Const.Items.ItemType.TwoHanded))
		{
			this.getContainer().add(this.new("scripts/skills/effects/crReachadvantage_effect"));			
		}		
	}	
	
	function onTurnStart()
	{
		this.m.Opponents.clear();
		if (!this.getContainer().getActor().isPlayerControlled())
		{
			this.m.Container.removeByID("perk.crReachadvantage")		
			this.getContainer().add(this.new("scripts/skills/perks/perk_reach_advantage"));				
		}
		local weapon = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		if (weapon != null && weapon.isItemType(this.Const.Items.ItemType.MeleeWeapon) && weapon.isItemType(this.Const.Items.ItemType.TwoHanded) && !this.getContainer().getSkillByID("perk.ptr_en_garde"))
		{
			local myTile = this.getContainer().getActor().getTile();
			for (local i = 0; i < 6; i++)
			{
				if (myTile.hasNextTile(i))
				{
					local nextTile = myTile.getNextTile(i);
					if (nextTile.IsOccupiedByActor)
					{
						if (nextTile.getEntity().getFaction() != this.getContainer().getActor().getFaction())
						{
							this.procIfApplicable(nextTile.getEntity());												
						}
					}
				}
			}		
		}						
	}	
	
	function onResumeTurn()
	{
		local weapon = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		if (weapon != null && weapon.isItemType(this.Const.Items.ItemType.MeleeWeapon) && weapon.isItemType(this.Const.Items.ItemType.TwoHanded) && !this.getContainer().getSkillByID("perk.ptr_en_garde"))
		{
			local myTile = this.getContainer().getActor().getTile();
			for (local i = 0; i < 6; i++)
			{
				if (myTile.hasNextTile(i))
				{
					local nextTile = myTile.getNextTile(i);
					if (nextTile.IsOccupiedByActor)
					{
						if (nextTile.getEntity().getFaction() != this.getContainer().getActor().getFaction())
						{
							this.procIfApplicable(nextTile.getEntity());												
						}
					}
				}
			}		
		}						
	}	

	function onCombatFinished()
	{
		this.skill.onCombatFinished();			
		this.m.Opponents.clear();
	}
});
