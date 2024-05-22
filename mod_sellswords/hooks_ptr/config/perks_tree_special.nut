::Const.Perks.SpecialTrees.removeSpecialPerk <- function( _perk )
{
	local find;
	foreach (i, t in this.Perks)
	{
		if (t.Perk == _perk)
		{
			find = i;
			break;
		}
	}

	local treeIndex, rowIndex, perkIndex;

	foreach(i, tree in this.Tree)
	{
		treeIndex = i;

		foreach(j, row in tree.Tree)
		{
			rowIndex = j;
			perkIndex = row.find(_perk);

			if (perkIndex != null)
				break;
		}
	}

	// remove that perk from the tree
	if (perkIndex != null)
	{
		this.Tree[treeIndex].Tree[rowIndex].remove(perkIndex);
	}
	return this.Perks.remove(find);
}

::Const.Perks.SpecialTrees.addSpecialPerk = function( _chance, _perk, _tier, _desc, _func = null )
{
	this.Perks.push({
		Perk = _perk,
		Chance = _chance,
		Desc = "[color=" + ::Const.UI.Color.NegativeValue + "]" + _desc + "[/color]"
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
			if (totalPerksInTree >= 4)
			{
				i++;
				continue;					
			}
		}

		::Const.Perks[name].Tree[_tier-1].push(_perk);
		break;
	}
};

::Const.Perks.SpecialTrees.removeSpecialPerk(::Const.Perks.PerkDefs.PTRMarksmanship); // Moved it to the Ranged Weapons tree
::Const.Perks.SpecialTrees.removeSpecialPerk(::Const.Perks.PerkDefs.PTRManOfSteel);
::Const.Perks.SpecialTrees.removeSpecialPerk(::Const.Perks.PerkDefs.LegendBigGameHunter);
::Const.Perks.SpecialTrees.removeSpecialPerk(::Const.Perks.PerkDefs.PTRRisingStar); // Moving it to row 4 

::Const.Perks.SpecialTrees.addSpecialPerk(2, ::Const.Perks.PerkDefs.PTRRisingStar, 5, "Has the talent to rise and shine above all others!");

::Const.Perks.SpecialTrees.addSpecialPerk(10, ::Const.Perks.PerkDefs.LegendBigGameHunter, 7, "Has a penchant for hunting big game.", function( _player, _chance ) {
	if (!_player.getBackground().hasPerkGroup(::Const.Perks.RangedTree) || !_player.getBackground().hasPerkGroup(::Const.Perks.BowTree) && !_player.getBackground().hasPerkGroup(::Const.Perks.CrossbowTree))
	{
		return 0;
	}

	local talents = _player.getTalents();
	if (talents.len() == 0 || talents[::Const.Attributes.RangedSkill] < 2)
	{
		return 0;
	}
	else
	{
		_chance *= talents[::Const.Attributes.RangedSkill];
	}

	return _chance;
});

::Const.Perks.SpecialTrees.addSpecialPerk(15, ::Const.Perks.PerkDefs.PTRManOfSteel, 7, "Is tough as if made of steel!", function( _player, _chance ) {
	if (!_player.getBackground().hasPerkGroup(::Const.Perks.HeavyArmorTree))
	{
		return 0;
	}

	local talents = _player.getTalents();
	if (talents.len() == 0 || (talents[::Const.Attributes.Hitpoints] < 1 && talents[::Const.Attributes.Fatigue] < 1))
	{
		return 0;
	}
	else
	{
		_chance *= (talents[::Const.Attributes.Hitpoints] + talents[::Const.Attributes.Fatigue] - 1);
	}
	
	return _chance;
});

::Const.Perks.SpecialTrees.addSpecialPerk(10, ::Const.Perks.PerkDefs.Slaughterer, 7, "Enjoys frightful slaugter for pleasure.", function( _player, _chance ) {
	if (!_player.getBackground().hasPerkGroup(::Const.Perks.ViciousTree) && !_player.getBackground().hasPerkGroup(::Const.Perks.UnstoppableTree))
	{
		return 0;
	}

	local talents = _player.getTalents();
	if (talents.len() == 0 || talents[::Const.Attributes.MeleeSkill] < 2)
	{
		return 0;
	}
	else
	{
		_chance *= talents[::Const.Attributes.MeleeSkill];
	}

	return _chance;
});

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
	
::Const.Perks.SpecialTrees.addSpecialPerk(15, ::Const.Perks.PerkDefs.PTRBolster, 2, "Could always inspire battle brothers to fight beyond role obligation for the common good of the group.", function( _player, _chance ) {
	if (!_player.getBackground().hasPerkGroup(::Const.Perks.CalmTree) && !_player.getBackground().hasPerkGroup(::Const.Perks.OrganisedTree) && !_player.getBackground().hasPerkGroup(::Const.Perks.TrainedTree))
	{
		return 0;
	}
	
	return _chance;
});	

::Const.Perks.SpecialTrees.addSpecialPerk(15, ::Const.Perks.PerkDefs.LegendWindReader, 5, "Have learned to read the wind, estimating the path of arrows in uncertain conditions.", function( _player, _chance ) {
	if (!_player.getBackground().hasPerkGroup(::Const.Perks.BowTree) && !_player.getBackground().hasPerkGroup(::Const.Perks.CrossbowTree) && !_player.getBackground().hasPerkGroup(::Const.Perks.SlingTree))
	{
		return 0;
	}
	
	if (_player.getBaseProperties().RangedSkill < 47)
	{
		return 0;
	}
	
	local talents = _player.getTalents();
	if (talents.len() == 0 || talents[::Const.Attributes.RangedDefense] < 1)
	{
		return 0;
	}
	
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