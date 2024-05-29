WorldBreditorScreen.prototype.FirstPerkButton = function (_moveforward)
{
	var pt_classnames = ['Weapons', 'Armor', 'Traits', 'Class', 'Enemy', 'Magic', 'Styles', 'Profession', 'Special', 'Leftovers'];
	if (_moveforward)
	{
		this.mPerkButtons[0].Counter +=1;

		if (this.mPerkButtons[0].Counter == pt_classnames.length)
			this.mPerkButtons[0].Counter = 0;
	}
	else
	{
		this.mPerkButtons[0].Counter -=1;

		if (this.mPerkButtons[0].Counter == -1)
			this.mPerkButtons[0].Counter = pt_classnames.length - 1;
	}

	this.mPerkButtons[0].Button.changeButtonText(pt_classnames[this.mPerkButtons[0].Counter]);
	this.mPerkButtons[1].Counter = 0;
	var tempo = this.mPTree[pt_classnames[this.mPerkButtons[0].Counter]][this.mPerkButtons[1].Counter].ID;
	this.mPerkButtons[1].Button.changeButtonText(tempo.replace('Tree','').replace('Class',''));
	this.CorrectDisplayedPerks();
};

WorldBreditorScreen.prototype.SecondPerkButton = function (_moveforward)
{
	var pt_classnames = ['Weapons', 'Armor', 'Traits', 'Class', 'Enemy', 'Magic', 'Styles', 'Profession', 'Special', 'Leftovers'];
	var pt_subclasses = this.mPTree[pt_classnames[this.mPerkButtons[0].Counter]].length;
	if (_moveforward)
	{
		this.mPerkButtons[1].Counter +=1;

		if (this.mPerkButtons[1].Counter == pt_subclasses)
			this.mPerkButtons[1].Counter = 0;
	}
	else
	{
		this.mPerkButtons[1].Counter -=1;

		if (this.mPerkButtons[1].Counter == -1)
			this.mPerkButtons[1].Counter = pt_subclasses - 1;
	}
	
	var tempo = this.mPTree[pt_classnames[this.mPerkButtons[0].Counter]][this.mPerkButtons[1].Counter].ID;
	this.mPerkButtons[1].Button.changeButtonText(tempo.replace('Tree','').replace('Class',''));
	this.CorrectDisplayedPerks();
};

WorldBreditorScreen.prototype.CorrectDisplayedPerks = function ()
{
	var self = this;
	var pt_classnames = ['Weapons', 'Armor', 'Traits', 'Class', 'Enemy', 'Magic', 'Styles', 'Profession', 'Special', 'Leftovers'];
	var perkcounter = 0;
	
	var plzsendhelp = {
		BroId: this.mData.ID,
		ButOne: pt_classnames[this.mPerkButtons[0].Counter],
		ButTwo: this.mPerkButtons[1].Counter,
	}
	this.notifyBackendOnBadBadPerks(plzsendhelp, function(_result)
		{		   
			var perkcounter = 0;
			for (var p = 2; p < self.mPerkButtons.length; p++) 
			{
				var perk = self.mPerkButtons[p];
				if (perkcounter < _result.length)
				{
					perk.Image.attr('src', Path.GFX + _result[perkcounter].Icon); 
					perk.Image.bindTooltip({ contentType: 'ui-perk', entityId: self.mRoster[self.mRoster.length-1].ID, perkId: _result[perkcounter].ID });
				}
				else
				{
					perk.Image.attr('src', Path.GFX+'ui/icons/talent_0.png');
					perk.Image.unbindTooltip();
				}
				perkcounter +=1;
			} 
		}); 
};

WorldBreditorScreen.prototype.AddPG = function ()
{
	var pt_classnames = ['Weapons', 'Armor', 'Traits', 'Class', 'Enemy', 'Magic', 'Hex', 'Charm', 'Special', 'Leftovers'];
	
	var sendingdhelp = {
		BroId: this.mData.ID,
		ButOne: pt_classnames[this.mPerkButtons[0].Counter],
		ButTwo: this.mPerkButtons[1].Counter,
	}
	this.notifyBackendOnAcceptingPG(sendingdhelp);
	this.CorrectDisplayedPerks();
};

WorldBreditorScreen.prototype.RemovePG = function ()
{
	var pt_classnames = ['Weapons', 'Armor', 'Traits', 'Class', 'Enemy', 'Magic', 'Styles', 'Profession', 'Special', 'Leftovers'];
	var self = this;
	var data = this.mData;
	var sendingdhelp = {
		BroId: this.mData.ID,
		ButOne: pt_classnames[this.mPerkButtons[0].Counter],
	}
	this.notifyBackendOnRemovingPG(sendingdhelp, function(_result)
		{		   
			data.PerkPoints = _result.PerkPoints;
			self.mStatsOptions.PerkPoints.SVal.html(data.PerkPoints);
		}); 
	
	this.CorrectDisplayedPerks();
};

WorldBreditorScreen.prototype.AddPerk = function (_counter)
{
	var pt_classnames = ['Weapons', 'Armor', 'Traits', 'Class', 'Enemy', 'Magic', 'Styles', 'Profession', 'Special', 'Leftovers'];
	var sendingdhelp = {
		BroId: this.mData.ID,
		ButOne: pt_classnames[this.mPerkButtons[0].Counter],
		ButTwo: this.mPerkButtons[1].Counter,
		PerkId: _counter,
	}
	var self = this;
	var data = this.mData;
	this.notifyBackendOnAddingPerk(sendingdhelp, function(_result)
		{		   
			data.PerkPoints = _result.PerkPoints;
			self.mStatsOptions.PerkPoints.SVal.html(data.PerkPoints);
		}); 
	this.CorrectDisplayedPerks();
};

WorldBreditorScreen.prototype.loadFromData = function (_data)
{
	if (_data === undefined || _data === null)
		return;

	if ('Title' in _data && _data.Title !== null)
		 this.mDialogContainer.findDialogTitle().html(_data.Title);

	this.mMode = 1;
	this.mRoster = _data.Roster;
	this.mTraits = _data.Traits;
	this.mBackgrounds = _data.Backgrounds;
	this.mNItems = _data.NamedItems;
	this.mPTree = _data.PTree;
	var pt_classnames = ['Weapons', 'Armor', 'Traits', 'Class', 'Enemy', 'Magic', 'Styles', 'Profession', 'Special', 'Leftovers'];
	this.mPerkButtons[0].Button.changeButtonText(pt_classnames[this.mPerkButtons[0].Counter]);
	var tempo = this.mPTree[pt_classnames[this.mPerkButtons[0].Counter]][this.mPerkButtons[1].Counter].ID;
	this.mPerkButtons[1].Button.changeButtonText(tempo.replace('Tree','').replace('Class',''));
	
	var traitcounter = 0;
	var traitslength = this.mTraits.length;
	for (var r = 0; r < this.mTraitOptions.length; r++) 
	{
		for (var trid = 1; trid < this.mTraitOptions[r].length; trid++) 
		{
 			var trait = this.mTraitOptions[r][trid];
			trait.Image.attr('src', Path.GFX+'ui/icons/talent_0.png');
			if (traitcounter < traitslength)
			{
				trait.Image.attr('src', Path.GFX+this.mTraits[traitcounter][2]);
				trait.Image.bindTooltip({ contentType: 'status-effect', entityId: _data.Roster[_data.Roster.length-1].ID, statusEffectId: this.mTraits[traitcounter][0] });
				trait.Container.css({ opacity: 0.33 });
				traitcounter +=1;
			}
		}
	}
	this.setupSkillEventHandlers();
	
	this.mNamedItemsPanel.Rows[0][1].TBValue = 0;
	this.mNamedItemsPanel.Rows[0][1].TypeButton.changeButtonText("Weapons");
	this.mNamedItemsPanel.Rows[1][1].TBValue = 0;
	this.RerollNIData();
	this.mNamedItemsPanel.Rows[0][4].BroExpImpInput.setInputTextBP("");
	
	this.mListScrollContainer.empty();

	for (var i = 0; i < _data.Roster.length - 1; ++i)
	{
		var entry = _data.Roster[i];
		this.addListEntry(entry);
	}

	this.selectListEntry(this.mListContainer.findListEntryByIndex(0), true);
};

WorldBreditorScreen.prototype.attachPerkEventHandler = function(_perk)
{
	var self = this;
	var pt_classnames = ['Weapons', 'Armor', 'Traits', 'Class', 'Enemy', 'Magic', 'Styles', 'Profession', 'Special', 'Leftovers'];
	_perk.Container.click(this, function (_event)
	{
		var perkcounter = 0;
		for (var p = 2; p < self.mPerkButtons.length; p++) 
		{
			var perk = self.mPerkButtons[p];
			var secondcounter = 0;
			var tempo = self.mPTree[pt_classnames[self.mPerkButtons[0].Counter]][self.mPerkButtons[1].Counter].Tree;
			for (var r = 0; r < tempo.length; r++) 
			{
				for (var c = 0; c < tempo.length; c++) 
				{
					if (perkcounter == secondcounter && perk == _perk)
						self.AddPerk(secondcounter);

					secondcounter +=1;
				}
			}
			perkcounter +=1;
		}
	});
};