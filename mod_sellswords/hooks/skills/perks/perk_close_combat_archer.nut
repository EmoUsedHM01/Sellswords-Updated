::Mod_Sellswords.HooksMod.hook("scripts/skills/perks/perk_close_combat_archer", function( q )
{
	q.onAnySkillUsed = @( __original ) function( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null)
		{
			return;
		}

		local bonus = getBonus() / 100;
		local negbonus = 0

		if (_skill.isRanged())
		{
			if (_skill.getID() == "actives.legend_sling_heavy_stone" || _skill.getID() == "actives.aimed_shot") return;
			_properties.DamageRegularMult *= 1 + bonus;
			_properties.DamageArmorMult *= 1 + bonus;
		}
	}

	q.getBonus <- function()
	{
		local actor = this.getContainer().getActor()
		local actorProperties = actor.getCurrentProperties();
		local mskillBonus = 0;
		local rdefBonus = 0;

		if (actor.getMainhandItem().isWeaponType(this.Const.Items.WeaponType.Throwing))
		{
			mskillBonus = this.Math.floor(0.3 * actorProperties.getMeleeSkill());
			rdefBonus = this.Math.floor(0.5 * actorProperties.getRangedDefense());
		}
		else
		{
			mskillBonus = this.Math.floor(0.15 * actorProperties.getMeleeSkill());
			rdefBonus = this.Math.floor(0.25 * actorProperties.getRangedDefense());
		}


		return this.Math.max(mskillBonus, rdefBonus)
	}

	q.onUpdate = @( __original ) function ( _properties )
	{
		_properties.isCloseCombatArcher = true;
	}

	q.getTooltip = @( __original ) function ()
	{
		local tooltip = this.skill.getTooltip();
		local actor = this.getContainer().getActor();
		local bonus = getBonus();
		
		tooltip.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Increases your damage done by [color=" + this.Const.UI.Color.PositiveValue + "]" + bonus + "%[/color]."
		});

		if (actor.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) != null)
		{
			if (actor.getMainhandItem().isWeaponType(this.Const.Items.WeaponType.Throwing))
			{
				tooltip.push({
					id = 6,
					type = "text",
					icon = "ui/tooltips/warning.png",
					text = "Reduces your maximum range to [color=" + this.Const.UI.Color.NegativeValue + "]3[/color]."
				});
				tooltip.push({
					id = 6,
					type = "text",
					icon = "ui/icons/special.png",
					text = "Allows you to use throwing weapons in melee."
				});
			}
			else
			{
				tooltip.push({
					id = 6,
					type = "text",
					icon = "ui/tooltips/warning.png",
					text = "Reduces your maximum range to [color=" + this.Const.UI.Color.NegativeValue + "]4[/color]."
				});
			}
		}

		return tooltip;
	}

	q.onAdded <- function ()
	{
		local addPerk = function ( _perk, _row = 0 )
		{
			local actor = this.getContainer().getActor();

			if (typeof actor == "instance")
			{
				actor = actor.get();
			}

			if (!this.isKindOf(actor, "player"))
			{
				return;
			}

			local bg = this.getContainer().getActor().getBackground();

			if (bg == null)
			{
				return;
			}

			bg.addPerk(_perk, _row);
		};

		if (!this.getContainer().hasSkill("perk.legend_heightened_reflexes"))
		{
			addPerk(this.Const.Perks.PerkDefs.LegendHeightenedReflexes, 5);
		}
	};
});
