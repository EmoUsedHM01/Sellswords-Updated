this.ssu_bolstered_effect <- this.inherit("scripts/skills/skill", {
	m = {
		crFactor = 0.08,
		crBonus = 0,
		IsCombatStarted = false
	},
	
	function create()
	{
		this.m.ID = "effects.ssu_bolstered";
		this.m.Name = ::Mod_Sellswords.Strings.ssu_bolstered_effect.Name;
		this.m.Description = ::Mod_Sellswords.Strings.ssu_bolstered_effect.Description;
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
				text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.ssu_bolstered_effect.Tooltip1, this.m.crBonus)
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.ssu_bolstered_effect.Tooltip2, this.m.crBonus)
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.ssu_bolstered_effect.Tooltip3, this.m.crBonus)
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

				local crallyPerk = ally.getSkills().getSkillByID("perk.ssu_guardian");
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
