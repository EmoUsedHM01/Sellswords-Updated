::Mod_Sellswords.HooksMod.hook("scripts/skills/perks/perk_duelist", function ( q ) {
	//mostly copypasted old duelist from legends, thb all this shit should be moved to grandslam or double grip scripts, todo later
	q.create = @(__original) function ()
	{
		__original();
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
	}

	q.getTooltip <- function ()
	{
		local tooltip = this.skill.getTooltip();
		local bonus = this.getBonus() * 100;
		local unarmedBonus = this.getUnarmedBonus() * 100;
		if ((bonus == 0 && unarmedBonus == 0) || (unarmedBonus != 0 && !::Legends.Perks.has(this, ::Legends.Perk.crGrandslam)))
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=%negative%]You do not have the right equipment to receive Duelist's effect[/color]"
			});
			return tooltip;
		}
		if (bonus != 0)
		{
			tooltip.push({
 				id = 6,
 				type = "text",
 				icon = "ui/icons/direct_damage.png",
 				text = "[color=%positive%]"+ bonus + "%[/color] of any damage ignores armor"
 			});
		}
		if (unarmedBonus >= 50 && ::Legends.Perks.has(this, ::Legends.Perk.crGrandslam))
		{
			tooltip.push({
				id = 11,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "+[color=%positive%]" + unarmedBonus + "%[/color] Damage due to unarmed Grandslam"
			});
		}
		return tooltip;
	}

	q.getBonus = @(__original) function()	//armor pen, actual property change handled on legends side
	{
		local bonus = __original();
		local weapon = this.getContainer().getActor().getMainhandItem();
		if (::Legends.Perks.has(this, ::Legends.Perk.crGrandslam))
		{
			if (weapon == null)	//unarmed check, i dont like it, parrying dagger + empty main is mostly useless anyway so no point imo, remove/rework later
			{
				bonus += 0.5;
				return bonus;
			}
			if (weapon.isItemType(this.Const.Items.ItemType.RangedWeapon) && !weapon.isWeaponType(this.Const.Items.WeaponType.Throwing))
			{
				return bonus;
			}
			else if (weapon.isItemType(this.Const.Items.ItemType.OneHanded))
			{
				bonus += 0.1;
				return bonus;
			}
			bonus += 0.2;
		}
		return bonus;
	}

	//moving some "unarmed" stuff here
	q.isValidUnarmed <- function ( _mainhand, _offhand )
	{
		if (_mainhand == null && _offhand == null)
			return true;

		return false;
	}

	q.getUnarmedBonus <- function()
	{
		local main = getContainer().getActor().getMainhandItem()
		local off = getContainer().getActor().getOffhandItem()
		if (isValidUnarmed(main,off))
			return 0.5	//should be 75-100 to reach some breakpoints
		return 0
	}

	q.onUpdate = @(__original) function ( _properties )
	{
		local bonus = this.getUnarmedBonus();

		if (bonus >= 0.5 && ::Legends.Perks.has(this, ::Legends.Perk.crGrandslam))
		{
			local c = 1.0
			c = c + bonus
			_properties.MeleeDamageMult *= c
		}
	};
});
