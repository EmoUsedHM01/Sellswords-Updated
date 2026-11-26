var SsuAutoLevel = {
	DefaultCount: Constants.Game.MAX_STATS_INCREASE_COUNT,
	createSubHeader: CharacterScreenLeftPanelHeaderModule.prototype.createLevelUpDialogSubHeader,
	createContent: CharacterScreenLeftPanelHeaderModule.prototype.createLevelUpDialogContent
};

CharacterScreenLeftPanelHeaderModule.prototype.createLevelUpDialogSubHeader = function ()
{
	var data = this.mDataSource.getSelectedBrother();
	var brother = data !== null && CharacterScreenIdentifier.Entity.Character.Key in data ? data[CharacterScreenIdentifier.Entity.Character.Key] : null;
	var levelUp = brother !== null && CharacterScreenIdentifier.Entity.Character.LevelUp.Key in brother ? brother[CharacterScreenIdentifier.Entity.Character.LevelUp.Key] : null;

	this.mSsuAutoLevel = levelUp !== null && levelUp.ssuAutoLevel === true;

	if (this.mSsuAutoLevel)
	{
		Constants.Game.MAX_STATS_INCREASE_COUNT = Object.keys(this.mLevelUpLeftStatsRows).length + Object.keys(this.mLevelUpRightStatsRows).length;
	}
	else
	{
		Constants.Game.MAX_STATS_INCREASE_COUNT = SsuAutoLevel.DefaultCount;
	}

	return SsuAutoLevel.createSubHeader.call(this);
};

CharacterScreenLeftPanelHeaderModule.prototype.createLevelUpDialogContent = function ()
{
	var self = this;
	var result = SsuAutoLevel.createContent.call(this);

	if (result !== null && this.mSsuAutoLevel)
	{
		$.each([this.mLevelUpLeftStatsRows, this.mLevelUpRightStatsRows], function (_index, _rows)
		{
			$.each(_rows, function (_key, _row)
			{
				self.increaseLevelUpStatValue(_row.Button);
			});
		});

		this.mDataSource.notifyBackendDiceThrow();
	}

	return result;
};
