this.crbear_potion_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.crbear_potion";
		this.m.Name = "the Relentless Storm";
		this.m.Icon = "skills/status_effect_145.png";
		this.m.IconMini = "";
		this.m.Overlay = "status_effect_145";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = false;
		this.m.IsStacking = false;
	}

	function getDescription()
	{
		return "This character\'s body has mutated to grow at an unnatural pace. In battle, this causes their wounds to close and heal within moments. Outside of battle, it causes unseemly growths, an unquenchable thirst, and disgustingly long finger nails. You once saw them lacerate both arms with a meat cleaver, screeching maniacally that it was \'the only way to keep it in check\'. Odd.";
	}

	function getTooltip()
	{
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
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/armor_body.png",
				text = "Is immune to Baffled"
			},
			{
				id = 12,
				type = "hint",
				icon = "ui/tooltips/warning.png",
				text = "Further mutations will cause a longer period of sickness"
			}
		];
		return ret;
	}

	function onDeath( _fatalityType )
	{
		if (_fatalityType != this.Const.FatalityType.Unconscious)
		{
			this.World.Statistics.getFlags().set("isCrBearPotionAcquired", false);
		}
	}

	function onDismiss()
	{
		this.World.Statistics.getFlags().set("isCrBearPotionAcquired", false);
	}

});

