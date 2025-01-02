::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/recover_skill", function ( q ) {

	q.getTooltip = @( __original ) function ()
	{
		local actor = this.getContainer().getActor();
		local fatReduc = actor.getActionPoints() * 5.5;
		local ret = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 3,
				type = "text",
				text = this.getCostString()
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Current Fatigue is reduced by [color=" + this.Const.UI.Color.PositiveValue + "]" + fatReduc + "%[/color]"
			}
		];
		return ret;
	};

	q.getActionPointCost = @( __original ) function ()
	{
		local actor = this.getContainer().getActor();
		if (!this.getContainer().hasSkill("perk.crbeforethestorm"))
			return actor.getActionPoints();
		return this.Math.max(0, actor.getActionPoints() - 1);
	}

	q.use = @( __original ) function (_targetTile, _forFree = false) {
		this.m.AP = this.getActionPointCost();
		__original(_targetTile, _forFree);
	}

	q.onUse = @( __original ) function ( _user, _targetTile )
	{
		local actor = this.getContainer().getActor();
		local fatMult = this.m.AP * 0.055;
		_user.setFatigue(_user.getFatigue() - fatMult * _user.getFatigue());
		//added by bigmap
		if(this.m.AP == 0)
		{
			this.m.CanRecover = false;
		}
		if (!_user.isHiddenToPlayer())
		{
			_user.playSound(this.Const.Sound.ActorEvent.Fatigue, this.Const.Sound.Volume.Actor * _user.getSoundVolume(this.Const.Sound.ActorEvent.Fatigue));
		}

		return true;
	};
});
