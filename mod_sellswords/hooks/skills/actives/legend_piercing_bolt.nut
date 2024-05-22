::mods_hookExactClass("skills/actives/legend_piercing_bolt", function(o) {
	o.m.AdditionalAccuracy <- 0;
	o.m.AdditionalHitChance <- 0;			
	
	o.onItemSet <- function()
	{
		this.m.MaxRange = this.m.Item.getRangeMax();
	}

	local ws_create = o.create;
	o.create = function()
	{
		ws_create();

		this.m.Name = "Piercing Shot";
		this.m.Description = "A shot with so much force that it passes straight through one enemy to the enemy behind them.";
		this.m.KilledString = "Shot";
		this.m.Icon = "skills/active_17.png";
		this.m.IconDisabled = "skills/active_17_sw.png";
		this.m.Overlay = "active_17";
	}

	o.isHidden = function()
	{
		return !this.getContainer().getActor().isArmedWithRangedWeapon() || !this.getContainer().hasSkill("perk.legend_piercing_shot");
	}	

	o.getTooltip = function()
	{
		local ret = this.getDefaultTooltip();
		ret.extend([
			{
				id = 5,
				type = "text",
				icon = "ui/icons/special.png",
				text = "If the bolt hits its target, it will continue through and damage any target behind, dealing [color=" + this.Const.UI.Color.PositiveValue + "]50%[/color] damage."
			}
		]);

		if (15 + this.m.AdditionalAccuracy >= 0)
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Has [color=" + this.Const.UI.Color.PositiveValue + "]+" + (10 + this.m.AdditionalAccuracy) + "%[/color] chance to hit, and [color=" + this.Const.UI.Color.NegativeValue + "]" + (-4 + this.m.AdditionalHitChance) + "%[/color] per tile of distance"
			});
		}
		else
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Has [color=" + this.Const.UI.Color.NegativeValue + "]" + (10 + this.m.AdditionalAccuracy) + "%[/color] chance to hit, and [color=" + this.Const.UI.Color.NegativeValue + "]" + (-4 + this.m.AdditionalHitChance) + "%[/color] per tile of distance"
			});
		}

		local ammo = this.getAmmo();

		if (ammo > 0)
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/icons/ammo.png",
				text = "Has [color=" + this.Const.UI.Color.PositiveValue + "]" + ammo + "[/color] bolts left"
			});
		}
		else
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Needs a non-empty quiver of bolts equipped[/color]"
			});
		}

		return ret;
	}

	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.RangedSkill += 10 + this.m.AdditionalAccuracy;
			_properties.HitChanceAdditionalWithEachTile -= 4 + this.m.AdditionalHitChance;
		}
	}

	local ws_onAfterUpdate = o.onAfterUpdate;
	o.onAfterUpdate = function( _properties )
	{
		ws_onAfterUpdate(_properties);

		this.m.DirectDamageMult = _properties.IsSpecializedInCrossbows ? 0.6 : 0.4;
		this.m.AdditionalAccuracy = this.m.Item.getAdditionalAccuracy();
	}

})