this.weakened_post_resurrected <- this.inherit("scripts/skills/injury_permanent/permanent_injury", {
	m = {
		ResurrectedTimes = 0,
		DayCount = 30,
		MaxStack = 14,
		MinStack = 2,	
		Stacks = {
			Hitpoints = 0,
			Bravery = 0,
			Stamina = 0,
			Initiative = 0,
			MeleeSkill = 0,
			MeleeDefense = 0,
			RangedSkill = 0,
			RangedDefense = 0
		}
	},
	function onApplyAppearance()
	{
	}

	function resetDayCount()
	{
		this.m.DayCount = 30;
	}

	function anotherResurrectionOwO()
	{
		++this.m.ResurrectedTimes;
	}

	function create()
	{
		this.permanent_injury.create();
		this.m.ID = "injury.weakened_post_resurrected";
		this.m.Name = "Resurrected";
		this.m.Description = "Resurrection has weaken this character. The more this character is brought back to life the worsen the effect.";
		this.m.Icon = "skills/status_effect_07.png";
	}
	
	function getDescription()
	{
		return this.m.Description + ". Have been resurrected [color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.ResurrectedTimes + "[/color] time" + (this.m.ResurrectedTimes > 1 ? "s." : "."); 
	}

	function getTooltip()
	{
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
		];

		local i = 0;
		foreach (key, value in this.m.Stacks )
		{
			if (value > 0)
			{
				local data = this.getStackTooltipInfo(i);

				ret.push({
					id = 7 + i,
					type = "text",
					icon = "ui/icons/" + data.Icon + ".png",
					text = "[color=" + this.Const.UI.Color.NegativeValue + "]-" + (value * 5) + "%[/color] " + data.Name
				});
			}

			++i;
		}

		this.addTooltipHint(ret);
		return ret;
	}

	function getStackTooltipInfo( _index )
	{
		local names = [
			"Hitpoints",
			"Resolve",
			"Fatigue",
			"Initiative",
			"Melee Skill",
			"Melee Defense",
			"Ranged Skill",
			"Ranged Defense"
		];
		local icons = [
			"health",
			"bravery",
			"fatigue",
			"initiative",
			"melee_skill",
			"melee_defense",
			"ranged_skill",
			"ranged_defense"
		];

		return {
			Name = names[_index],
			Icon = icons[_index]
		};
	}

	function onUpdate( _properties )
	{
		_properties.HitpointsMult *= 1.0 - this.m.Stacks.Hitpoints * 0.05;
		_properties.BraveryMult *= 1.0 - this.m.Stacks.Bravery * 0.05;
		_properties.StaminaMult *= 1.0 - this.m.Stacks.Stamina * 0.05;
		_properties.InitiativeMult *= 1.0 - this.m.Stacks.Initiative * 0.05;
		_properties.MeleeSkillMult *= 1.0 - this.m.Stacks.MeleeSkill * 0.05;
		_properties.RangedSkillMult *= 1.0 - this.m.Stacks.RangedSkill * 0.05;
		_properties.MeleeDefenseMult *= 1.0 - this.m.Stacks.MeleeDefense * 0.05;
		_properties.RangedSkillMult *= 1.0 - this.m.Stacks.RangedDefense * 0.05;
	}

	function onNewDay()
	{
		if (this.canRecover() && --this.m.DayCount <= 0)
		{
			local keys = [];

			foreach (key, value in this.m.Stacks )
				if (value > this.m.MinStack)
					keys.push(key);

			local roll = this.MSU.Array.getRandom(keys);
			this.m.Stacks[roll] = this.Math.max(this.m.MinStack, this.m.Stacks[roll] - 1);
			this.resetDayCount();
		}
	}

	function addRandomStacks( _num = 2 )
	{
		local keys = [];

		foreach (key, value in this.m.Stacks)
			if (value < this.m.MaxStack)
				keys.push(key);

		while (_num > 0 && keys.len() > 0)
		{
			local roll = this.MSU.Array.getRandom(keys);
			this.m.Stacks[roll] = this.Math.min(this.m.MaxStack, this.m.Stacks[roll] + 1);

			if (this.m.Stacks[roll] == 7)
				keys.remove(keys.find(roll));

			--_num;
		}
	}

	function canRecover()
	{
		foreach (key, value in this.m.Stacks)
			if (value > this.m.MinStack)
				return true;

		return false;
	}

	function onSerialize( _out )
	{
		this.permanent_injury.onSerialize(_out);
		_out.writeU16(this.m.ResurrectedTimes);
		_out.writeU16(this.m.DayCount);

		foreach (key, value in this.m.Stacks)
			_out.writeU16(value);
	}

	function onDeserialize( _in )
	{
		this.permanent_injury.onDeserialize(_in);
		this.m.ResurrectedTimes = _in.readU16();
		this.m.DayCount = _in.readU16();
		
		foreach (key, value in this.m.Stacks)
			this.m.Stacks[key] = _in.readU16();
	}

});