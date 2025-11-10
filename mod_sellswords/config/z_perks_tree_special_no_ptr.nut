if (!(::Is_PTR_Exist))
{
	::Const.Perks.SpecialTrees <- {
	Tree = [],
	Perks = [],

	function addSpecialPerk( _chance, _perk, _tier, _desc, _func = null )
	{
		this.Perks.push({
			Perk = _perk,
			Chance = _chance,
			Desc = "[color=%negative%]" + _desc + "[/color]"
			Func = _func != null ? _func : @(a, b) _chance,
			Row = _tier - 1
		});
		
		local i = 0;			
		while (true)
		{
			local name = "Special" + i;
			if (!(name in ::Const.Perks))
			{
				::Const.Perks[name] <- {
					ID = name,
					Descriptions = [""],
					Name = "Special Perks",
					Tree = [
						[], [], [], [], [], [], []
					]
				};
		
				::Const.Perks.SpecialTrees.Tree.push(::Const.Perks[name]);
			}
		
			if (::Const.Perks[name].Tree[_tier-1].len() > 1)
			{
				local totalPerksInTree = 0;					
				foreach (row in ::Const.Perks[name].Tree)
				{
					totalPerksInTree += row.len();
				}
				if (totalPerksInTree >= 5)
				{
					i++;
					continue;					
				}
			}
		
			::Const.Perks[name].Tree[_tier-1].push(_perk);
			break;
		}
	}

	function getRandom( _exclude )
	{
		local L = [];

		foreach( i, t in this.Tree )
		{
			if (_exclude != null && _exclude.find(t.ID))
			{
				continue;
			}

			L.push(i);
		}

		local r = this.Math.rand(0, L.len() - 1);
		return this.Tree[L[r]];
	}

	function getRandomPerk()
	{
		local tree = this.getRandom(null);
		local L = [];

		foreach( row in tree.Tree )
		{
			foreach( p in row )
			{
				L.push(p);
			}
		}

		local r = this.Math.rand(0, L.len() - 1);
		return L[r];
	}
};
	
	::Const.Perks.SpecialTrees.addSpecialPerk(1, ::Const.Perks.PerkDefs.crbravery, 7, "Once More Unto the Breach", function( _player, _chance ) {
	
		local talents = _player.getTalents();
		local tl = talents.len() == 0 ? 0 : talents[::Const.Attributes.Bravery];
		if (tl == 0)
		{
			return 0;
		}
		_chance *= ::Math.pow(2, tl);
	
		return _chance;
	});	
	
	::Const.Perks.SpecialTrees.addSpecialPerk(1, ::Const.Perks.PerkDefs.crinitiative, 7, "In Delay There Lies No Plenty", function( _player, _chance ) {
	
		local talents = _player.getTalents();
		local tl = talents.len() == 0 ? 0 : talents[::Const.Attributes.Initiative];
		if (tl == 0)
		{
			return 0;
		}		
		_chance *= ::Math.pow(2, tl);		
	
		return _chance;
	});	
	
	::Const.Perks.SpecialTrees.addSpecialPerk(1, ::Const.Perks.PerkDefs.crhitpoints, 7, "Too Stubborn to Die", function( _player, _chance ) {
	
		local talents = _player.getTalents();
		local tl = talents.len() == 0 ? 0 : talents[::Const.Attributes.Hitpoints];
		if (tl == 0)
		{
			return 0;
		}		
		_chance *= ::Math.pow(2, tl);			
	
		return _chance;
	});
	
	::Const.Perks.SpecialTrees.addSpecialPerk(1, ::Const.Perks.PerkDefs.crstamina, 7, "A Waking Chant", function( _player, _chance ) {
	
		local talents = _player.getTalents();
		local tl = talents.len() == 0 ? 0 : talents[::Const.Attributes.Fatigue];
		if (tl == 0)
		{
			return 0;
		}		
		_chance *= ::Math.pow(2, tl);			
	
		return _chance;
	});
	
	::Const.Perks.SpecialTrees.addSpecialPerk(1, ::Const.Perks.PerkDefs.crmeleeskill, 7, "Strive for Perfection", function( _player, _chance ) {
	
		local talents = _player.getTalents();
		local tl = talents.len() == 0 ? 0 : talents[::Const.Attributes.MeleeSkill];
		if (tl == 0)
		{
			return 0;
		}		
		_chance *= ::Math.pow(2, tl);			
	
		return _chance;
	});
	
	::Const.Perks.SpecialTrees.addSpecialPerk(1, ::Const.Perks.PerkDefs.crrangedskill, 7, "Ace of Aces", function( _player, _chance ) {
	
		local talents = _player.getTalents();
		local tl = talents.len() == 0 ? 0 : talents[::Const.Attributes.RangedSkill];
		if (tl == 0)
		{
			return 0;
		}		
		_chance *= ::Math.pow(2, tl);			
	
		return _chance;
	});
	
	::Const.Perks.SpecialTrees.addSpecialPerk(1, ::Const.Perks.PerkDefs.crrangeddefense, 7, "Wrong Door", function( _player, _chance ) {
	
		local talents = _player.getTalents();
		local tl = talents.len() == 0 ? 0 : talents[::Const.Attributes.RangedDefense];
		if (tl == 0)
		{
			return 0;
		}		
		_chance *= ::Math.pow(2, tl);			
	
		return _chance;
	});	
	
	::Const.Perks.SpecialTrees.addSpecialPerk(30, ::Const.Perks.PerkDefs.crBruiser, 2, "Experience in street fighting made him very skilled in grappling.", function( _player, _chance ) {
		if (!_player.getBackground().hasPerkGroup(::Const.Perks.MaceTree) && !_player.getBackground().hasPerkGroup(::Const.Perks.HammerTree) && !_player.getBackground().hasPerkGroup(::Const.Perks.FlailTree) && !_player.getBackground().hasPerkGroup(::Const.Perks.AxeTree))
		{
			return 0;
		}
		
		if (_player.getBaseProperties().Hitpoints < 60)
		{
			return 0;
		}
		
		local talents = _player.getTalents();
		if (talents.len() == 0 || talents[::Const.Attributes.Hitpoints] < 1)
		{
			return 0;
		}
		
		return _chance;
	});	
}