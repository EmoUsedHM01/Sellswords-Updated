::Const.Strings.PerkDescription.LegendTwirl = "Practice in physical movement with a partner has given the ability to take the lead and move someone\'s body in a twirling movement. The \'Rotation\' skill can now target enemies as well as allies. If you don't have the \'Rotation\' skill, taking this perk will grant you it for as long as you have this perk.";
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendTwirl].Tooltip = ::Const.Strings.PerkDescription.LegendTwirl;

::mods_hookExactClass("skills/perks/perk_legend_twirl", function (o)
{
    o.onAdded <- function()
	{
        if (!this.m.Container.hasSkill("actives.rotation"))
		{
			this.m.Container.add(::new("scripts/skills/actives/rotation"));
		}
	}

    o.onRemoved <- function()
	{
		this.m.Container.removeByID("actives.rotation");
	}
});