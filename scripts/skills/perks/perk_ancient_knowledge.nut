this.perk_ancient_knowledge <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.ancient_knowledge";
		this.m.Name = this.Const.Strings.PerkName.AncientKnowledge;
		this.m.Description = this.Const.Strings.PerkDescription.AncientKnowledge;
		this.m.Icon = "ui/perks/perk_ancient_knowledge.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		local item = this.getContainer().getActor().getMainhandItem();

		if (item != null && item.isItemType(this.Const.Items.ItemType.Ancient))
		{
			if (item.getBlockedSlotType() == null)
			{
				_properties.DamageRegularMin += 6;
				_properties.DamageRegularMax += 12;
			}
			else
			{
				_properties.DamageRegularMin += 8;
				_properties.DamageRegularMax += 24;
				_properties.DamageDirectAdd += 0.1;
			}

			if (item.isNamed())
				_properties.HitChance[this.Const.BodyPart.Head] += 10;
		}
	}

});