this.ssu_ai_equip_offhand <- this.inherit("scripts/ai/tactical/behavior", {
	m = {
		WeaponToEquip = null
	},
	function create()
	{
		this.m.ID = this.Const.AI.Behavior.ID.SsuEquipOffhand;
		this.m.Order = this.Const.AI.Behavior.Order.SsuEquipOffhand;
		this.behavior.create();
	}

	function onEvaluate( _entity )
	{
		this.m.WeaponToEquip = null;

		if (_entity.getMoraleState() == this.Const.MoraleState.Fleeing || _entity.getCurrentProperties().IsStunned || !this.getAgent().hasVisibleOpponent())
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		local items = _entity.getItems();
		local mainhand = items.getItemAtSlot(this.Const.ItemSlot.Mainhand);

		if (mainhand == null || !mainhand.isItemType(this.Const.Items.ItemType.MeleeWeapon) || !items.hasEmptySlot(this.Const.ItemSlot.Offhand) || items.hasBlockedSlot(this.Const.ItemSlot.Offhand) || !items.canDualWield(_entity, mainhand))
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		local quickHands = _entity.getSkills().getSkillByID("perk.quick_hands");

		if ((quickHands == null || quickHands.isSpent()) && _entity.getActionPoints() < this.Const.Tactical.Settings.SwitchItemAPCost)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		foreach (item in items.getAllItemsAtSlot(this.Const.ItemSlot.Bag))
		{
			if (item.isItemType(this.Const.Items.ItemType.MeleeWeapon) && item.getSlotType() == this.Const.ItemSlot.Mainhand && item.getBlockedSlotType() == null && items.canDualWield(_entity, item))
			{
				this.m.WeaponToEquip = item;
				break;
			}
		}

		if (this.m.WeaponToEquip == null)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		return this.Const.AI.Behavior.Score.SsuEquipOffhand * this.getProperties().BehaviorMult[this.m.ID];
	}

	function onExecute( _entity )
	{
		local items = _entity.getItems();
		items.removeFromBag(this.m.WeaponToEquip);
		items.equip(this.m.WeaponToEquip);
		items.payForAction([
			this.m.WeaponToEquip
		]);
		this.m.WeaponToEquip = null;
		return true;
	}

});
