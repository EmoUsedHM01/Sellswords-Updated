::Mod_Sellswords.HooksMod.hook("scripts/items/misc/anatomist/anatomist_potion_item", function ( q ) {

	q.create = @(__original) function()
	{
		__original();
		this.m.IsSellable = true;
	}

	q.onUse = @(__original) function( _actor, _item = null )
	{
		// Apply sickness per mutation
		this.Sound.play("sounds/combat/drink_0" + this.Math.rand(1, 3) + ".wav", this.Const.Sound.Volume.Inventory);
		if (!_actor.getSkills().hasSkill("injury.sickness"))
			_actor.getSkills().add(this.new("scripts/skills/injury/sickness_injury"));

		_actor.getSkills().getSkillByID("injury.sickness").addHealingTime(_actor.getFlags().getAsInt("ActiveMutations") * 3);

		// Play screaming sounds
		if (_actor.getGender() == 1)
		{
			this.Sound.play("sounds/humans/legends/woman_death_0" + this.Math.rand(1, 8) + ".wav", this.Const.Sound.Volume.Inventory);
			this.Sound.play("sounds/humans/legends/woman_flee_0" + this.Math.rand(1, 6) + ".wav", this.Const.Sound.Volume.Inventory);
		}
		else
		{
			this.Sound.play("sounds/humans/2/human_death_01" + ".wav", this.Const.Sound.Volume.Inventory);
			this.Sound.play("sounds/humans/2/human_flee_01" + ".wav", this.Const.Sound.Volume.Inventory);
		}
		return true;
	}

});