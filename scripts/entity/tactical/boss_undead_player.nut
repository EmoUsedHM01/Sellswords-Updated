this.boss_undead_player <- this.inherit("scripts/entity/tactical/undead_player", {
	m = {
		UndeadType = this.Const.Necro.UndeadType.Skeleton
	},

	function setStartValuesEx( _backgrounds, _addTraits = true, _gender = -1, _addEquipment = true )
	{
		_backgrounds = this.Const.Necro.BossUndeadBackgrounds;

		local background = this.new("scripts/skills/backgrounds/" + _backgrounds[this.Math.rand(0, _backgrounds.len() - 1)]);
		this.m.Skills.add(background);
		background.buildDescription();
		
		this.m.StarWeights = background.buildAttributes(null, null);
		background.buildDescription();
		
		local inTraining = this.new("scripts/skills/traits/intensive_training_trait");
		local maxTraits = 0;

		if (!this.getSkills().hasSkill("trait.intensive_training_trait"))
			this.m.Skills.add(inTraining);

		if (_addTraits)
		{
			local maxTraits = 2;
			local traits = [
				background
			];

			if (background.m.IsGuaranteed.len() > 0)
			{
				maxTraits = maxTraits - background.m.IsGuaranteed.len();
				foreach(trait in background.m.IsGuaranteed)
					traits.push(this.new("scripts/skills/traits/" + trait));
			}

			pickTraits( traits, maxTraits );
			
			for( local i = 1; i < traits.len(); i = ++i )
			{
				this.m.Skills.add(traits[i]);

				if (traits[i].getContainer() != null)
					traits[i].addTitle();
			}
		}

		if (_addEquipment)
			background.addEquipment();
		
		this.setUndeadAppearance();
		this.setUndeadAttributes();		
		
		if (_addTraits)
		{
			this.fillTalentValues(3);
			this.fillAttributeLevelUpValues(this.Const.XP.MaxLevelWithPerkpoints - 1);
		}
		
		local attributes = background.buildPerkTree();

		this.m.Skills.update();
	}
	
});