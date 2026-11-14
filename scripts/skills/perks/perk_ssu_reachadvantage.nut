this.perk_ssu_reachadvantage <- this.inherit("scripts/skills/skill", {
	m = {
		Opponents = [],
		tempOpponents = []
	},
	function create()
	{
		this.m.ID = "perk.ssu_reachadvantage";
		this.m.Name = this.Const.Strings.PerkName.SsuReachadvantage;
		this.m.Description = ::Mod_Sellswords.Strings.perk_ssu_reachadvantage.Description;
		this.m.Icon = "ui/perks/perk_19.png";
		this.m.IconMini = "perk_19_mini";
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
			if (opponentEntry == _entityID)
				return opponentEntry;

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
				text = ::Mod_Sellswords.Strings.perk_ssu_reachadvantage.Tooltip1
			}
		);

		foreach (opponentEntry in this.m.Opponents)
		{
			local opponent = this.Tactical.getEntityByID(opponentEntry);
			if (opponent == null || !opponent.isPlacedOnMap() || !opponent.isAlive() || opponent.isDying())
				continue;

			tooltip.push(
				{
					id = 10,
					type = "text",
					icon = "ui/orientation/" + opponent.getOverlayImage() + ".png",
					text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.perk_ssu_reachadvantage.Tooltip2, mk, opponent.getName())
				}
			);
		}

		return tooltip;
	}

	function procIfApplicable(_entity)
	{
		local actor = this.getContainer().getActor();
		if (!actor.isPlacedOnMap() || actor.getMoraleState() == this.Const.MoraleState.Fleeing)
			return;

		foreach (opponentEntry in this.m.Opponents)
			if (opponentEntry == _entity.getID())
				return;

		this.m.Opponents.push(_entity.getID());
		foreach (opponentEntry in this.m.tempOpponents)
			if (opponentEntry == _entity.getID())
				return;

		this.m.tempOpponents.push(_entity.getID());
	}

	function onUpdate( _properties )
	{
		for (local i = this.m.Opponents.len() - 1; i >= 0; i--)
		{			
			local e = this.Tactical.getEntityByID(this.m.Opponents[i]);	  //Opponents.push(_entity.getID())  entity id is inputed
			if (e == null || !e.isAlive())
				this.m.Opponents.remove(i);
		}

		for (local i = this.m.tempOpponents.len() - 1; i >= 0; i--)
		{
			local e = this.Tactical.getEntityByID(this.m.tempOpponents[i]);
			if (e == null || !e.isAlive())
				this.m.tempOpponents.remove(i);
		}
	}

	function onBeingAttacked( _attacker, _skill, _properties )
	{
		if (_attacker != null && _skill != null && !_skill.isRanged() && _skill.isAttack())
		{
			local opponentEntry = this.getOpponentEntry(_attacker.getID());
			if (opponentEntry != null)
				_properties.MeleeDefense += _properties.MeleeSkill;
		}
	}

	function onTurnEnd()
	{	
		this.m.tempOpponents.clear();
		local actor = this.getContainer().getActor();
		local weapon = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		if (!this.getContainer().getSkillByID("effects.ssu_reachadvantage") && !this.getContainer().getSkillByID("effects.spearwall") && actor.hasZoneOfControl() && weapon != null && weapon.isItemType(this.Const.Items.ItemType.MeleeWeapon) && weapon.isItemType(this.Const.Items.ItemType.TwoHanded) && this.m.Opponents.len() != 0)
			this.getContainer().add(this.new("scripts/skills/effects/ssu_reachadvantage_effect"));
	}

	function onWaitTurn()
	{	
		this.m.tempOpponents.clear();
		local actor = this.getContainer().getActor();
		local weapon = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		if (!this.getContainer().getSkillByID("effects.ssu_reachadvantage") && !this.getContainer().getSkillByID("effects.spearwall") && actor.hasZoneOfControl() && weapon != null && weapon.isItemType(this.Const.Items.ItemType.MeleeWeapon) && weapon.isItemType(this.Const.Items.ItemType.TwoHanded) && this.m.Opponents.len() != 0)
			this.getContainer().add(this.new("scripts/skills/effects/ssu_reachadvantage_effect"));
	}

	function onTurnStart()
	{
		this.m.Opponents.clear();
		local actor = this.getContainer().getActor().get();

		if (!::MSU.isKindOf(actor, "player"))
			this.m.Container.removeByID("perk.ssu_reachadvantage");

		local weapon = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);

		if (weapon != null && weapon.isItemType(this.Const.Items.ItemType.MeleeWeapon) && weapon.isItemType(this.Const.Items.ItemType.TwoHanded))
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
							this.procIfApplicable(nextTile.getEntity());
					}
				}
			}
		}
	}

	function onResumeTurn()
	{
		local weapon = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		if (weapon != null && weapon.isItemType(this.Const.Items.ItemType.MeleeWeapon) && weapon.isItemType(this.Const.Items.ItemType.TwoHanded))
		{
			local myTile = this.getContainer().getActor().getTile();
			for (local i = 0; i < 6; i++)
			{
				if (myTile.hasNextTile(i))
				{
					local nextTile = myTile.getNextTile(i);
					if (nextTile.IsOccupiedByActor)
						if (nextTile.getEntity().getFaction() != this.getContainer().getActor().getFaction())
							this.procIfApplicable(nextTile.getEntity());
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