::Mod_Sellswords.HooksMod.hook("scripts/skills/special/double_grip", function ( q ) {

	q.getTooltip = @(__original) function ()
	{
		local cof = 0;
		if (::Legends.Perks.has(this, ::Legends.Perk.crGrandslam)) {
			cof += 25;
		}

		local ret = __original();
		if (cof > 0) {
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "+[color=%positive%]" + cof + "%[/color] Damage due to Grand Slam"
			});
		}
		return ret;
	};

	q.onUpdate = @(__original) function ( _properties )
	{
		__original(_properties); //??

		if (this.canDoubleGrip())
		{
			local cof = 1.0;

			if (::Legends.Perks.has(this, ::Legends.Perk.crGrandslam))
			{
				cof = cof + 0.25;
			}

			_properties.MeleeDamageMult *= cof;
		}
	};
});
