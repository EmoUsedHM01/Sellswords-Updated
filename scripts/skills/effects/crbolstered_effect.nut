this.crbolstered_effect <- this.inherit("scripts/skills/skill", {
	m = {
		crFactor = 0.08,
		crBonus = 0,
		IsCombatStarted = false
	},
	
	function create()
	{
		this.m.ID = "effects.crbolstered";
		this.m.Name = "Bolstered";
		this.m.Description = "This character is feeling bolstered thanks to an adjacent Guardian's support.";
		this.m.Icon = "ui/perks/perk_28.png";
		this.m.IconMini = "perk_28_mini";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsHidden = false;
		this.m.IsStacking = false;
	}

	function getTooltip()
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
				id = 10,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.crBonus + "[/color] Initiative"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.crBonus + "[/color] Melee Defense"
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.crBonus + "[/color] Ranged Defense"
			}
		];
	}

	function isHidden()
	{
		return this.m.crBonus == 0 || this.getContainer().getActor().getMoraleState() == this.Const.MoraleState.Ignore || this.getContainer().getActor().getMoraleState() == this.Const.MoraleState.Fleeing;
	}

	function onUpdate( _properties )
	{
		this.m.crBonus = 0;

		if (this.m.IsCombatStarted == false)
		{
			return;
		}

		local actor = this.getContainer().getActor();

		if (!actor.isPlacedOnMap() || actor.getMoraleState() == this.Const.MoraleState.Ignore || actor.getMoraleState() == this.Const.MoraleState.Fleeing)
		{
			return;
		}

		local allyDefense = 0;				
		if (::Tactical.isActive())
		{
			local adjacentAllies = ::Tactical.Entities.getFactionActors(actor.getFaction(), actor.getTile(), 1);
			foreach (ally in adjacentAllies)
			{
				if (!ally.hasZoneOfControl() || ally.getID() == actor.getID())
				{
					continue;
				}

				local crallyPerk = ally.getSkills().getSkillByID("perk.crGuardian");
				if (crallyPerk != null && crallyPerk.isInEffect())
				{
					allyDefense += this.Math.max(0, ally.getCurrentProperties().getMeleeDefense());
					allyDefense += this.Math.max(0, ally.getCurrentProperties().getRangedDefense());
				}			
			}
		}		

		if (allyDefense > 0)
		{
			this.m.crBonus = this.Math.floor(allyDefense * this.m.crFactor);
			_properties.Initiative += this.m.crBonus;
			_properties.MeleeDefense += this.m.crBonus;
			_properties.RangedDefense += this.m.crBonus;			
		}
	}

	function onCombatStarted()
	{
		this.m.IsCombatStarted = true;
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.IsCombatStarted = false;
	}
});
