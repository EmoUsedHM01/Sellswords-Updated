::Mod_Sellswords.HooksMod.hook("scripts/states/world_state", function ( q ) 
{
	q.onDeserialize = @( __original ) function( _in )
	{
		this.World.State.m.AppropriateTimeToRecalc = 0;
		this.Sound.stopAmbience();
		this.m.Player = this.World.getPlayerEntity();

		if (_in.getMetaData().getVersion() >= 34)
		{
			local numRegions = _in.readU16();

			for( local i = 0; i < numRegions; i = i )
			{
				local region = {};
				region.Name <- _in.readString();
				region.Type <- _in.readU8();
				region.Size <- _in.readU16();
				local x = _in.readI16();
				local y = _in.readI16();
				region.Center <- this.World.getTile(x, y);

				if (_in.getMetaData().getVersion() >= 59)
				{
					region.Discovered <- _in.readF32();
				}
				else
				{
					region.Discovered <- 0.0;
				}

				region.Tiles <- [];
				this.m.Regions.push(region);
				i = ++i;
			}
		}

		this.World.Flags.onDeserialize(_in);
		this.World.FactionManager.onDeserialize(_in);
		this.World.EntityManager.onDeserialize(_in);
		this.World.Assets.onDeserialize(_in);
		this.m.Combat = this.new("scripts/entity/world/combat_manager");
		this.World.Combat <- this.WeakTableRef(this.m.Combat);
		this.World.Combat.onDeserialize(_in);
		this.World.Contracts.onDeserialize(_in);
		this.World.Events.onDeserialize(_in);
		this.World.Ambitions.onDeserialize(_in);

		if (_in.getMetaData().getVersion() >= 36)
		{
			this.World.Crafting.onDeserialize(_in);
		}

		if (_in.getMetaData().getVersion() >= 51)
		{
			this.World.Retinue.onDeserialize(_in);
		}

		this.World.Statistics.onDeserialize(_in);
		this.m.LastIsDaytime = !this.World.getTime().IsDaytime;
		this.setCampingAllowed(_in.readBool());

		if (_in.getMetaData().getVersion() >= 38)
		{
			this.m.CombatSeed = _in.readI32();
		}

		if (this.Const.DLC.Unhold && !this.World.Flags.get("IsUnholdCampaign"))
		{
			this.World.Statistics.getFlags().set("ItemsCrafted", 0);
			this.World.Flags.set("IsUnholdCampaign", true);
			this.Time.scheduleEvent(this.TimeUnit.Real, 6000, function ( _tag )
			{
				this.showDialogPopup("Old Campaign Loaded", "This campaign was created before you activated the \'Beasts & Exploration\' DLC. Please be aware that even though you can continue to play this campaign, you won\'t have access to all of the new content unless you start a new campaign.", null, null, true);
			}.bindenv(this), null);
		}
		else if (this.Const.DLC.Wildmen && !this.World.Flags.get("IsWildmenCampaign"))
		{
			this.World.Flags.set("IsWildmenCampaign", true);
			this.Time.scheduleEvent(this.TimeUnit.Real, 6000, function ( _tag )
			{
				this.showDialogPopup("Old Campaign Loaded", "This campaign was created before you activated the \'Warriors of the North\' DLC. Please be aware that even though you can continue to play this campaign, you won\'t have access to all of the new content unless you start a new campaign.", null, null, true);
			}.bindenv(this), null);
		}
		else if (this.Const.DLC.Desert && !this.World.Flags.get("IsDesertCampaign"))
		{
			this.World.Flags.set("IsDesertCampaign", true);
			this.Time.scheduleEvent(this.TimeUnit.Real, 6000, function ( _tag )
			{
				this.showDialogPopup("Old Campaign Loaded", "This campaign was created before you activated the \'Blazing Deserts\' DLC. Please be aware that even though you can continue to play this campaign, you won\'t have access to all of the new content unless you start a new campaign.", null, null, true);
			}.bindenv(this), null);
		}

		this.m.CharacterScreen.resetInventoryFilter();
		this.World.Ambitions.updateUI();
		this.updateDayTime();
		this.updateTopbarAssets();
		this.m.IsUpdatedOnce = false;

		if (this.m.EscortedEntity == null)
		{
			this.World.State.setCampingAllowed(true);
			this.World.State.setEscortedEntity(null);
			this.World.State.getPlayer().setVisible(true);
			this.World.Assets.setUseProvisions(true);
		}

		if (_in.getMetaData().getVersion() >= 52)
		{
			this.World.Camp.clear();
			this.World.Camp.onDeserialize(_in);
		}

		this.World.State.m.AppropriateTimeToRecalc = 1;
		this.World.State.getPlayer().calculateModifiers();
	}
});
