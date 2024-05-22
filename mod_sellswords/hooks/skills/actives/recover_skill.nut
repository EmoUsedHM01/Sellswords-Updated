::mods_hookExactClass("skills/actives/recover_skill", function ( o )
{
	local getTooltip = o.getTooltip;
	o.getTooltip = function ()
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
	o.getActionPointCost = function ()
	{
		local actor = this.getContainer().getActor();
		if (!this.getContainer().hasSkill("perk.crbeforethestorm"))
		{
			return actor.getActionPoints();
		}	
		else
		{
			return this.Math.max(0, actor.getActionPoints() - 1);
		}
	}

	o.onBeforeUse = function ( _user, _targetTile )
	{
		if (!this.getContainer().hasSkill("perk.crbeforethestorm"))
		{
			this.m.AP = _user.getActionPoints();
		}	
		else
		{
			this.m.AP = this.Math.max(0, _user.getActionPoints() - 1);
		}			
	}		
	local onUse = o.onUse;
	o.onUse = function ( _user, _targetTile )
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