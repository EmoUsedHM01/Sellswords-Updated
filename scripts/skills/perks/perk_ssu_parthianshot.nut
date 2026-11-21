this.perk_ssu_parthianshot <- this.inherit("scripts/skills/skill", {
	m = {
		HasMoved = false,		
	},
	function create()
	{
		this.m.ID = "perk.ssu_parthianshot";
		this.m.Name = this.Const.Strings.PerkName.SsuParthianshot;
		this.m.Description = this.Const.Strings.PerkDescription.SsuParthianshot;
		this.m.Icon = "ui/perks/legend_horse_parthian_shot.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate ( _properties )
	{
		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon == null || !weapon.isItemType(this.Const.Items.ItemType.RangedWeapon))
		{
			return;
		}
				
		local actor = this.getContainer().getActor();
		local ap = actor.getActionPoints();		

		_properties.DamageDirectMult *= 1.0 + 0.02 * ap;
		_properties.DamageAgainstMult[this.Const.BodyPart.Body] *= 1.0 + 0.02 * ap;			
		_properties.DamageAgainstMult[this.Const.BodyPart.Head] *= 1.0 + 0.02 * ap;
	}

	// the free tile is given by the Legends free move, see mod_sellswords/hooks/states/tactical_state.nut
	function isFreeMoveReady()
	{
		if (this.m.HasMoved)
		{
			return false;
		}

		local weapon = this.getContainer().getActor().getMainhandItem();
		return weapon != null && weapon.isItemType(this.Const.Items.ItemType.RangedWeapon);
	}

	function onTurnStart()
	{
		this.m.HasMoved = false;		
	}
	
	function onAdded()
	{
		if (("State" in this.Tactical) && this.Tactical.State != null)
		{
			this.m.HasMoved = false;
		}
	}

	function onCombatStarted()
	{
		this.m.HasMoved = false;		
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.HasMoved = false;	
	}	
});
