::mods_hookExactClass("skills/perks/perk_fast_adaption", function ( o )
{
	o.onTargetMissed = function ( _skill, _targetEntity )
	{
		if (this.Time.getFrame() != this.m.Frame && this.m.SkillCount != this.Const.SkillCounter)
		{
			++this.m.Stacks;

			if (this.getContainer().getActor().isPlayerControlled())
			{
				++this.m.Stacks;
			}

			this.m.Frame = this.Time.getFrame();
			this.m.SkillCount = this.Const.SkillCounter;
			this.m.IsHidden = false;

			if (this.m.Stacks == 1)
			{
				this.getContainer().getActor().setDirty(true);
			}
		}
	};
});