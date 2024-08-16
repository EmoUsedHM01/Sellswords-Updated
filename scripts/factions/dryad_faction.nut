this.dryad_faction <- this.inherit("scripts/factions/faction", {
	m = {},
	function create()
	{
		this.faction.create();
		this.m.Type = this.Const.FactionType.Dryads;
		this.m.Base = "world_base_10";
		this.m.TacticalBase = "bust_base_dryad";
		this.m.CombatMusic = this.Const.Music.BeastsTracks;
		this.m.PlayerRelation = 0.0;
		this.m.IsHidden = true;
		this.m.IsRelationDecaying = false;
	}

	function addPlayerRelation( _r, _reason = "" )
	{
	}

	function addPlayerRelationEx( _r, _reason = "" )
	{
	}

	function getCombatMusic()
	{
		local playerTile = this.World.State.getPlayer().getTile();

		if (this.Const.DLC.Desert && (playerTile.Type == this.Const.World.TerrainType.Desert || playerTile.Type == this.Const.World.TerrainType.Oasis || playerTile.TacticalType == this.Const.World.TerrainTacticalType.DesertHills))
		{
			return this.Const.Music.BeastsTracksSouth;
		}
		else
		{
			return this.m.CombatMusic;
		}
	}

	function onSerialize( _out )
	{
		this.faction.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		this.faction.onDeserialize(_in);
	}

});