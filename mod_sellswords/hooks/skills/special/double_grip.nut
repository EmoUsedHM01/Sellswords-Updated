::Mod_Sellswords.HooksMod.hook("scripts/skills/special/double_grip", function ( q ) {

	q.getTooltip = @(__original) function ()
	{
		local cof = 25;

		if (this.getContainer().hasSkill("perk.crGrandslam"))
		{
			cof = cof + 25;
		}

		local ret = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			}
		];
		ret.push({
			id = 11,
			type = "text",
			icon = "ui/icons/regular_damage.png",
			text = "+[color=%positive%]" + cof + "%[/color] Damage"
		});
		return ret;
	};

	q.onUpdate = @(__original) function ( _properties )
	{
		if (this.canDoubleGrip())
		{
			local cof = 1.25;

			if (this.getContainer().hasSkill("perk.crGrandslam"))
			{
				cof = cof + 0.25;
			}

			_properties.MeleeDamageMult *= cof;
		}
	};
});
