::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/raise_undead", function( q ) {

	q.m.SpawnedUndead <- [];

	q.create = @(__original) function()
	{
		__original();

		this.m.Description = ::Mod_Sellswords.Strings.raise_undead.Description;
		this.m.IconDisabled = "skills/active_26_sw.png";
		this.m.MaxRange = 9;
	}

	q.getTooltip = @(__original) function()
	{
		return [
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
				icon = "ui/icons/vision.png",
				text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.raise_undead.Tooltip1, this.getMaxRange())
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Mod_Sellswords.Strings.raise_undead.Tooltip2
			}
		];
	}

	q.spawnUndead = @(__original) function(_user, _tile)
	{
		__original(_user, _tile);

		local zombie = _tile.getEntity();
		this.m.SpawnedUndead.push([zombie, _user]);
	}

	q.onCombatFinished = @(__original) function()
	{
		while(this.m.SpawnedUndead.len() != 0)
		{
			local pair = this.m.SpawnedUndead.pop();
			pair[0].kill(pair[1], this, this.Const.FatalityType.None, true);
		}
	}

});