this.crReachadvantage_effect <- this.inherit("scripts/skills/skill", {
	m = {
		Opponents = []	
	},
	function create()
	{
		this.m.ID = "effects.crReachadvantage";
		this.m.Name = "Reach Advantage";
		this.m.Icon = "ui/perks/perk_19.png";
		this.m.IconMini = "perk_19_mini";
		this.m.Overlay = "status_effect_04";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "This character is using the superior reach of their melee weapon to keep opponents at bay.";
	}

	function onAdded()
	{
		local item = this.m.Container.getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		local sourceperk = this.getContainer().getSkillByID("perk.crReachadvantage");
		if (sourceperk != null)
		{
			this.m.Opponents = sourceperk.m.Opponents;
		}
		if (item != null && item.isItemType(this.Const.Items.ItemType.MeleeWeapon) && this.m.Opponents.len() > 0)
		{
			item.onLowerWeapon();
		}
	}

	function onTurnStart()
	{
		this.removeSelf();
	}

	function onRemoved()
	{
		local item = this.m.Container.getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);

		if (item != null && item.isItemType(this.Const.Items.ItemType.MeleeWeapon))
		{
			item.onRaiseWeapon();
		}
		else
		{
			local app = this.getContainer().getActor().getItems().getAppearance();
			app.LowerWeapon = false;
			this.getContainer().getActor().getItems().updateAppearance();
		}
	}
	
	//function onUpdate( _properties )
	//{
	//	local sourceperk = this.getContainer().getSkillByID("perk.crReachadvantage");
	//	//this.logInfo("checkperk: " + sourceperk);
	//	if (sourceperk != null)
	//	{
	//		this.m.Opponents = sourceperk.m.Opponents;
	//	}
	//}	

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{	
		if ((this.Tactical.TurnSequenceBar.getActiveEntity() == null || this.Tactical.TurnSequenceBar.getActiveEntity().getID() != this.getContainer().getActor().getID()) && (_targetEntity != null && this.m.Opponents.find(_targetEntity.getID()) != null))
		{			
			_properties.DamageTotalMult *= 0.2;
		}
	}

});

