this.perk_ssu_totalcover <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.ssu_totalcover";
		this.m.Name = this.Const.Strings.PerkName.SsuTotalcover;
		this.m.Description = this.Const.Strings.PerkDescription.SsuTotalcover;
		this.m.Icon = "ui/perks/ssu_totalcover.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function isInEffect()
	{
		return this.getContainer().getActor().isArmedWithShield();
	}

	function onUpdate( _properties )
	{
		if (this.isInEffect())
			_properties.Block += this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Offhand).getBlock();
	}

	function getSharedBlock()
	{
		local actor = this.getContainer().getActor();
		local properties = actor.getCurrentProperties();
		local bolstered = actor.getSkills().getSkillByID("effects.ssu_bolstered");
		local received = bolstered != null ? bolstered.m.BlockBonus : 0;
		return this.Math.floor(this.Math.max(0, properties.Block - received) * properties.BlockMult * 0.5);
	}

});
