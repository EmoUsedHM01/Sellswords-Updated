::Mod_Sellswords.AutoLevelUp <- {
	Attributes = [
		{ Min = 2, Max = 3 }, // Hitpoints
		{ Min = 1, Max = 2 }, // Bravery
		{ Min = 2, Max = 3 }, // Fatigue
		{ Min = 2, Max = 3 }, // Initiative
		{ Min = 2, Max = 2 }, // MeleeSkill
		{ Min = 2, Max = 3 }, // RangedSkill
		{ Min = 1, Max = 2 }, // MeleeDefense
		{ Min = 1, Max = 2 }  // RangedDefense
	],

	Properties = ["Hitpoints", "Bravery", "Stamina", "Initiative", "MeleeSkill", "RangedSkill", "MeleeDefense", "RangedDefense"],

	Flag = "SsuAutoLevel"
};

::Mod_Sellswords.AutoLevelUp.isActive <- function( _bro )
{
	if (typeof _bro == "instance")
		_bro = _bro.get();

	return ::Mod_Sellswords.AutoLevel && !::isKindOf(_bro, "ssu_necro_ghost_player");
}

::Mod_Sellswords.AutoLevelUp.roll <- function( _bro, _attribute, _amount )
{
	local range = this.Attributes[_attribute];
	local talent = _bro.m.Talents[_attribute];
	local bonus = talent * _amount / 2;

	while (true)
	{
		local values = [];
		local total = 0;

		for (local i = 0; i < _amount; ++i)
		{
			local value = ::Math.rand(range.Min, range.Max);

			for (local star = 0; star < talent; ++star)
				value += ::Math.rand(0, 1);

			values.push(value);
			total += value;
		}

		if (total >= range.Min * _amount + bonus && total <= range.Max * _amount + bonus || ::Hooks.hasMod("mod_clever_recruiter"))
			return values;
	}
}

::Mod_Sellswords.AutoLevelUp.fill <- function( _bro, _amount, _maxOnly )
{
	if (_bro.m.Attributes.len() == 0)
	{
		_bro.m.Attributes.resize(::Const.Attributes.COUNT);

		for (local i = 0; i != ::Const.Attributes.COUNT; ++i)
			_bro.m.Attributes[i] = [];
	}

	for (local i = 0; i != ::Const.Attributes.COUNT; ++i)
	{
		local values = _maxOnly ? [] : this.roll(_bro, i, _amount);

		while (values.len() < _amount)
			values.push(this.Attributes[i].Max);

		foreach (value in values)
			_bro.m.Attributes[i].insert(0, value);
	}
}

::Mod_Sellswords.AutoLevelUp.sync <- function( _bro )
{
	local flags = _bro.getFlags();
	local isActive = this.isActive(_bro);

	if (flags.has(this.Flag) == isActive)
		return;

	if (isActive)
		flags.add(this.Flag);
	else
		flags.remove(this.Flag);

	local stored = _bro.m.Attributes;

	if (stored.len() == 0)
		return;

	// a level up that gives 1 to every attribute is a veteran level and stays one
	local normal = 0;
	local veteran = 0;

	for (local level = 0; level < stored[0].len(); ++level)
	{
		local isVeteran = true;

		foreach (values in stored)
		{
			if (values[level] != 1)
				isVeteran = false;
		}

		if (isVeteran)
			++veteran;
		else
			++normal;
	}

	_bro.m.Attributes = [];
	_bro.fillAttributeLevelUpValues(normal);
	_bro.fillAttributeLevelUpValues(veteran, false, true);
}

local getStatPotential = ::Legends.Player.getStatPotential;
::Legends.Player.getStatPotential = function( _bro, _attribute )
{
	local auto = ::Mod_Sellswords.AutoLevelUp;

	if (!auto.isActive(_bro))
		return getStatPotential(_bro, _attribute);

	local levelUps = ::Math.max(12 - _bro.getLevel() + _bro.getLevelUps(), 0);
	local current = _bro.getBaseProperties()[auto.Properties[_attribute]] + _bro.m.Talents[_attribute] * levelUps / 2;
	local min = current + auto.Attributes[_attribute].Min * levelUps;
	local max = current + auto.Attributes[_attribute].Max * levelUps;

	return {
		min = min,
		max = max,
		avg = (min + max) / 2
	};
}
