::mods_hookExactClass("skills/backgrounds/legend_donkey_background", function(o) {
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()

		this.m.ID = "background.legend_donkey_background";
		this.m.DailyCost = 1;
		this.m.BackgroundType = this.Const.BackgroundType.Lowborn | this.Const.BackgroundType.Untalented | this.Const.BackgroundType.Stabled;
		this.m.Modifiers.Terrain = [
			0.0,
			0.0,
			0.1,
			0.04,
			0.04,
			0.04,
			0.04,
			0.04,
			0.04,
			0.04,
			0.0,
			0.1,
			0.04,
			0.06,
			0.06,
			0.1,
			0.0,
			0.04,
			0.1
		];
		this.m.CustomPerkTree = [
			[
				this.Const.Perks.PerkDefs.Colossus,
				this.Const.Perks.PerkDefs.NineLives,
				this.Const.Perks.PerkDefs.Pathfinder,
				this.Const.Perks.PerkDefs.Steadfast,
				this.Const.Perks.PerkDefs.BagsAndBelts,
				this.Const.Perks.PerkDefs.Recover
			],
			[
				this.Const.Perks.PerkDefs.Dodge,
				this.Const.Perks.PerkDefs.HoldOut,
				this.Const.Perks.PerkDefs.LegendComposure,
				this.Const.Perks.PerkDefs.LegendAlert,
				this.Const.Perks.PerkDefs.Relentless,
				this.Const.Perks.PerkDefs.SteelBrow
			],
			[
				this.Const.Perks.PerkDefs.Anticipation,
				this.Const.Perks.PerkDefs.Rotation,
				this.Const.Perks.PerkDefs.LegendPacifist,				
				this.Const.Perks.PerkDefs.Taunt,
				this.Const.Perks.PerkDefs.Sprint
			],
			[
				this.Const.Perks.PerkDefs.LegendEfficientPacking,
				this.Const.Perks.PerkDefs.LegendAmmoBinding,
				this.Const.Perks.PerkDefs.LegendMedPackages,
				this.Const.Perks.PerkDefs.LegendToolsDrawers
			],
			[
				this.Const.Perks.PerkDefs.LoneWolf,
				this.Const.Perks.PerkDefs.Footwork,
				this.Const.Perks.PerkDefs.LastStand,
				this.Const.Perks.PerkDefs.LegendBlendIn,
				this.Const.Perks.PerkDefs.Underdog
			],
			[
				this.Const.Perks.PerkDefs.Nimble,
				this.Const.Perks.PerkDefs.Rebound,
				this.Const.Perks.PerkDefs.LegendPacifist,
				this.Const.Perks.PerkDefs.LegendSkillfulStacking,
				this.Const.Perks.PerkDefs.LegendMuscularity
			],
			[
				this.Const.Perks.PerkDefs.Fearsome,
				this.Const.Perks.PerkDefs.Stalwart,
				this.Const.Perks.PerkDefs.LegendAmmoBundles,
				this.Const.Perks.PerkDefs.LegendMedIngredients,
				this.Const.Perks.PerkDefs.LegendToolsSpares
			],
			[],
			[],
			[],
			[]
		];
	}

	local ws_onAdded = o.onAdded;
	o.onAdded = function()
	{
		ws_onAdded();

		this.m.Container.add(this.new("scripts/skills/actives/knock_back"));
	}

	o.onUpdate <- function( _properties )
	{
		this.character_background.onUpdate(_properties);
		_properties.XPGainMult *= 1.5;
	}
});