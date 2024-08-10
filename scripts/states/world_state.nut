this.world_state <- this.inherit("scripts/states/state", {
	m = {
		WorldScreen = null,
		WorldTownScreen = null,
		CampScreen = null,
		WorldMenuScreen = null,
		WorldGameFinishScreen = null,
		WorldEventPopupScreen = null,
		RelationsScreen = null,
		CharacterScreen = null,
		EventScreen = null,
		CombatDialog = null,
		CampfireScreen = null,
		MenuStack = null,
		Regions = [],
		Entities = null,
		Factions = null,
		Contracts = null,
		Events = null,
		Ambitions = null,
		Retinue = null,
		Crafting = null,
		Statistics = null,
		Combat = null,
		Assets = null,
		Flags = null,
		Player = null,
		EscortedEntity = null,
		CurrentActionState = null,
		InputLocked = null,
		IsAllowingDeveloperMode = true,
		IsDeveloperModeEnabled = false,
		IsGamePaused = false,
		IsGameAutoPaused = false,
		IsGameOver = false,
		IsAIPaused = false,
		IsStartingCombat = false,
		IsCampingAllowed = true,
		IsUsingGuests = true,
		IsAutosaving = true,
		IsTriggeringContractUpdatesOnce = true,
		IsForcingAttack = false,
		IsUpdatedOnce = false,
		IsRunningUpdatesWhilePaused = false,
		LastEntityHovered = null,
		LastTileHovered = null,
		AutoEnterLocation = null,
		AutoAttack = null,
		LastAutoAttackPath = 0.0,
		MouseDownPosition = null,
		IsInCameraMovementMode = null,
		WasInCameraMovementMode = null,
		CursorBeforeCameraMovement = null,
		UseDragStyleScrolling = null,
		ScrollDirectionX = null,
		ScrollDirectionY = null,
		WorldPosToZoomTo = null,
		CustomZoom = 1.0,
		OnCameraMovementStartCallback = null,
		OnCameraMovementEndCallback = null,
		LastWorldSpeedMult = null,
		AutoUnpauseFrame = 0,
		AIEngageCallback = null,
		EngageCombatPos = null,
		EngageByPlayer = false,
		CombatProperties = null,
		PartiesInCombat = [],
		CombatStartTime = 0,
		CombatSeed = 0,
		LastEnteredTown = null,
		LastEnteredLocation = null,
		LastPlayerTile = null,
		LastIsDaytime = false,
		LastEnemyDiscoveredSoundTime = 0.0,
		LastMusicUpdate = 0.0,
		ExitGame = null,
		GameWon = null,
		CampaignToLoadFileName = null,
		CampaignLoadTime = 0,
		CampaignSettings = null,
		Campaign = "",
		CommanderDied = null,
		Camp = null,
		IDToRef = array(27, -1),
		DistantVisionBonus = false,
		AppropriateTimeToRecalc = 1 //Leonion's fix
	},

	function getPlayer()
	{
		return this.m.Player;
	}

	function getBrothersInReserves()
	{
		local count = 0;
		foreach (bro in this.World.getPlayerRoster().getAll())
		{
			if (bro.isInReserves())
			{
				count++;
			}
		}
		return count;
	}

	function getBrothersInFrontline()
	{
		return this.World.getPlayerRoster().getSize() - this.getBrothersInReserves();
	}

	function getCurrentTown()
	{
		return this.m.LastEnteredTown == null ? null : this.m.LastEnteredTown.get();
	}

	function getLastLocation()
	{
		return this.m.LastEnteredLocation == null ? null : this.m.LastEnteredLocation.get();
	}

	function setLastEnteredTown( _t )
	{
		this.m.LastEnteredTown = this.WeakTableRef(_t);
	}

	function getRegions()
	{
		return this.m.Regions;
	}

	function getRegion( _r )
	{
		if (_r > 0 && _r - 1 < this.m.Regions.len())
		{
			return this.m.Regions[_r - 1];
		}
		else
		{
			return null;
		}
	}

	function getTileRegion( _t )
	{
		return this.getRegion(_t.Region);
	}

	function isInputLocked()
	{
		return this.m.InputLocked != null && this.m.InputLocked == true;
	}

	function setInputLocked( _value )
	{
		this.m.InputLocked = _value;
	}

	function isPaused()
	{
		return this.m.IsGamePaused || this.m.IsGameAutoPaused;
	}

	function isUsingGuests()
	{
		return this.m.IsUsingGuests;
	}

	function setUseGuests( _f )
	{
		this.m.IsUsingGuests = _f;
	}

	function getCombatSeed()
	{
		return this.m.CombatSeed;
	}

	function setAIEngageCallback( _c )
	{
		this.m.AIEngageCallback = _c;
	}

	function getMenuStack()
	{
		return this.m.MenuStack;
	}

	function getEventScreen()
	{
		return this.m.EventScreen;
	}

	function getTownScreen()
	{
		return this.m.WorldTownScreen;
	}

	function getCampScreen()
	{
		return this.m.CampScreen;
	}

	function getWorldScreen()
	{
		return this.m.WorldScreen;
	}

	function getLastEntityHovered()
	{
		return this.m.LastEntityHovered;
	}

	function getLastTileHovered()
	{
		return this.m.LastTileHovered;
	}

	function getCurrentActionState()
	{
		return this.m.CurrentActionState;
	}

	function getCombatStartTime()
	{
		return this.m.CombatStartTime;
	}

	function getEscortedEntity()
	{
		return this.m.EscortedEntity;
	}

	function updateRegionDiscovery( _r )
	{
		if (_r.Tiles.len() == 0)
		{
			_r.Tiles <- this.World.getAllTilesOfRegion(_r.Center.Region);
		}

		local d = 0;

		foreach( t in _r.Tiles )
		{
			if (t.IsDiscovered)
			{
				d = ++d;
			}
		}

		_r.Discovered = d / (_r.Tiles.len() * 1.0);
	}

	function setCampingAllowed( _f )
	{
		if (this.m.IsCampingAllowed == _f)
		{
			return;
		}

		this.m.IsCampingAllowed = _f;
		this.m.WorldScreen.getTopbarOptionsModule().enableCampButton(_f);
	}

	function isCampingAllowed()
	{
		return this.m.IsCampingAllowed;
	}

	function setEscortedEntity( _e )
	{
		if (_e == null)
		{
			this.m.EscortedEntity = null;
		}
		else if (typeof _e == "instance")
		{
			this.m.EscortedEntity = _e;
		}
		else
		{
			this.m.EscortedEntity = this.WeakTableRef(_e);
		}

		if (this.m.EscortedEntity != null && !this.m.EscortedEntity.isNull() && this.m.EscortedEntity.isAlive())
		{
			this.World.TopbarDayTimeModule.enableNormalTimeButton(false);

			if (!this.isPaused())
			{
				this.World.TopbarDayTimeModule.updateTimeButtons(2);
			}
			else
			{
				this.World.TopbarDayTimeModule.updateTimeButtons(0);
			}
		}
		else
		{
			this.World.TopbarDayTimeModule.enableNormalTimeButton(true);

			if (!this.isPaused())
			{
				this.World.TopbarDayTimeModule.updateTimeButtons(1);
			}
			else
			{
				this.World.TopbarDayTimeModule.updateTimeButtons(0);
			}
		}
	}

	function autosave()
	{
		if (!this.m.IsAutosaving)
		{
			return;
		}

		local pause = !this.m.IsGameAutoPaused;

		if (pause)
		{
			this.setAutoPause(true);
		}

		if (this.World.Assets.isIronman())
		{
			this.saveCampaign(this.World.Assets.getName() + "_" + this.World.Assets.getCampaignID(), this.World.Assets.getName());
		}
		else
		{
			this.saveCampaign("autosave");
		}

		if (pause)
		{
			this.setAutoPause(false);
		}
	}

	function isInCameraMovementMode()
	{
		return this.m.IsInCameraMovementMode != null && this.m.IsInCameraMovementMode == true;
	}

	function wasInCameraMovementMode()
	{
		return this.m.WasInCameraMovementMode != null && this.m.WasInCameraMovementMode == true;
	}

	function disableCameraMode()
	{
		this.m.IsInCameraMovementMode = null;
		this.m.WasInCameraMovementMode = null;
		this.m.MouseDownPosition = null;
	}

	function setAutoPause( _f )
	{
		this.m.IsGameAutoPaused = _f;
		this.setPause(this.m.IsGamePaused);
	}

	function setPause( _f )
	{
		if (_f != this.m.IsGamePaused)
		{
			this.m.IsGamePaused = _f;

			if (!_f)
			{
				if (this.World.Camp.isCamping())
				{
					this.World.TopbarDayTimeModule.showMessage("ENCAMPED", []);
				}
				else
				{
					this.World.TopbarDayTimeModule.hideMessage();
				}
			}
			else
			{
				if (this.World.Camp.isCamping())
				{
					local updates = ["(Press Spacebar)"];
					updates.extend(this.World.Camp.getLastCampingUpdateText());
					this.World.TopbarDayTimeModule.showMessage("ENCAMPED\n(PAUSED)", updates);		
				}
				else
				{
					this.World.TopbarDayTimeModule.showMessage("PAUSED", ["(Press Spacebar)"]);	
				}
			}
		}

		if (_f || this.m.IsGameAutoPaused)
		{
			this.m.LastWorldSpeedMult = this.World.getSpeedMult() != 0 ? this.World.getSpeedMult() : this.m.LastWorldSpeedMult;
			this.World.setSpeedMult(0.0);
			this.m.IsAIPaused = true;
		}
		else
		{
			this.World.setSpeedMult(this.m.LastWorldSpeedMult != 0 ? this.m.LastWorldSpeedMult : 1.0);
			this.m.IsAIPaused = false;
		}

		if (("TopbarDayTimeModule" in this.World) && this.World.TopbarDayTimeModule != null)
		{
			if (this.m.IsGamePaused)
			{
				this.World.TopbarDayTimeModule.updateTimeButtons(0);
			}
			else if (this.World.getSpeedMult() == 1.0)
			{
				this.World.TopbarDayTimeModule.updateTimeButtons(1);
			}
			else if (this.World.getSpeedMult() == 4.0)
			{
				this.World.TopbarDayTimeModule.updateTimeButtons(3);
			}
			else if (this.World.getSpeedMult() == 8.0)
			{
				this.World.TopbarDayTimeModule.updateTimeButtons(4);
			}
			else
			{
				this.World.TopbarDayTimeModule.updateTimeButtons(2);
			}
		}
	}

	function setWorldmapMusic( _keepPlaying )
	{
		if (this.Const.DLC.Desert && this.getPlayer().getTile().SquareCoords.Y < this.World.getMapSize().Y * 0.2)
		{
			this.Music.setTrackList(this.World.FactionManager.isGreaterEvil() ? this.Const.Music.WorldmapTracksGreaterEvilSouth : this.Const.Music.WorldmapTracksSouth, this.Const.Music.CrossFadeTime, _keepPlaying);
		}
		else
		{
			this.Music.setTrackList(this.World.FactionManager.isGreaterEvil() ? this.Const.Music.WorldmapTracksGreaterEvil : this.Const.Music.WorldmapTracks, this.Const.Music.CrossFadeTime, _keepPlaying);
		}

		this.m.LastMusicUpdate = this.Time.getRealTimeF();
	}

	function showEventScreen( _event, _isContract = false, _playSound = true )
	{
		if (this.m.EventScreen.isVisible() || this.m.EventScreen.isAnimating() || this.m.MenuStack.hasBacksteps())
		{
			return false;
		}

		if (_playSound && this.Const.Events.GlobalSound != "")
		{
			this.Sound.play(this.Const.Events.GlobalSound, 1.0);
		}

		if (!this.isPaused())
		{
			this.setNormalTime();
		}

		this.setAutoPause(true);
		this.m.EventScreen.setIsContract(_isContract);
		this.m.EventScreen.show(_event);
		this.m.WorldScreen.hide();
		this.Cursor.setCursor(this.Const.UI.Cursor.Hand);
		this.m.MenuStack.push(function ()
		{
			this.m.EventScreen.hide();
			this.m.WorldScreen.show();
			this.updateTopbarAssets();
			this.setAutoPause(false);
		}, function ()
		{
			return false;
		});
		return true;
	}

	function showEventScreenFromTown( _event, _isContract = false, _playSound = true )
	{
		if (!this.m.EventScreen.isVisible() && !this.m.EventScreen.isAnimating())
		{
			if (_playSound && this.Const.Events.GlobalSound != "")
			{
				this.Sound.play(this.Const.Events.GlobalSound, 1.0);
			}

			this.m.WorldTownScreen.hideAllDialogs();
			this.m.EventScreen.setIsContract(_isContract);
			this.m.EventScreen.show(_event);
			this.m.MenuStack.push(function ()
			{
				this.m.EventScreen.hide();
				this.m.WorldTownScreen.showLastActiveDialog();
			}, function ()
			{
				return false;
			});
		}
	}

	function commanderDied()
	{
		return this.m.CommanderDied;
	}

	function setCommanderDied( _v )
	{
		this.m.CommanderDied = _v
	}

	function onInit()
	{
		this.m.IsDeveloperModeEnabled = this.isDevmode() || !this.isReleaseBuild();
		this.m.IsAllowingDeveloperMode = false;
		this.m.IsGamePaused = false;
		this.m.IsAIPaused = false;
		this.m.UseDragStyleScrolling = true;
		this.m.LastWorldSpeedMult = 1.0;
		this.m.ExitGame = false;
		this.m.GameWon = false;
		this.m.CommanderDied = false;
		this.Settings.getTempGameplaySettings().CameraLocked = false;
		this.Settings.getTempGameplaySettings().ShowTracking = true;
		this.Tactical.setActive(false);
		this.World.State <- this.WeakTableRef(this);
		this.World.setOnLoadCallback(this.onDeserialize.bindenv(this));
		this.World.setOnBeforeLoadCallback(this.onBeforeDeserialize.bindenv(this));
		this.World.setOnSaveCallback(this.onSerialize.bindenv(this));
		this.World.setOnBeforeSaveCallback(this.onBeforeSerialize.bindenv(this));
		this.m.Entities = this.new("scripts/entity/world/entity_manager");
		this.World.EntityManager <- this.WeakTableRef(this.m.Entities);
		this.m.Factions = this.new("scripts/factions/faction_manager");
		this.World.FactionManager <- this.WeakTableRef(this.m.Factions);
		this.m.Combat = this.new("scripts/entity/world/combat_manager");
		this.World.Combat <- this.WeakTableRef(this.m.Combat);
		this.m.Contracts = this.new("scripts/contracts/contract_manager");
		this.World.Contracts <- this.WeakTableRef(this.m.Contracts);
		this.m.Events = this.new("scripts/events/event_manager");
		this.World.Events <- this.WeakTableRef(this.m.Events);
		this.m.Ambitions = this.new("scripts/ambitions/ambition_manager");
		this.World.Ambitions <- this.WeakTableRef(this.m.Ambitions);
		this.m.Retinue = this.new("scripts/retinue/retinue_manager");
		this.World.Retinue <- this.WeakTableRef(this.m.Retinue);
		this.m.Crafting = this.new("scripts/crafting/crafting_manager");
		this.World.Crafting <- this.WeakTableRef(this.m.Crafting);
		this.m.Statistics = this.new("scripts/statistics/statistics_manager");
		this.World.Statistics <- this.m.Statistics;
		this.m.Flags = this.new("scripts/tools/tag_collection");
		this.World.Flags <- this.m.Flags;
		this.m.Assets = this.new("scripts/states/world/asset_manager");
		this.World.Assets <- this.WeakTableRef(this.m.Assets);
		this.m.Camp = this.new("scripts/states/world/camp_manager");
		this.World.Camp <- this.WeakTableRef(this.m.Camp);
		this.onInitUI();
		this.init();
	}

	function onInitUI()
	{
		this.m.MenuStack <- this.new("scripts/ui/global/menu_stack");
		this.m.MenuStack.setEnviroment(this);
		this.m.WorldScreen <- this.new("scripts/ui/screens/world/world_screen");
		local topbarOptionsModule = this.m.WorldScreen.getTopbarOptionsModule();
		topbarOptionsModule.setOnBrothersPressedListener(this.topbar_options_module_onBrothersButtonClicked.bindenv(this));
		topbarOptionsModule.setOnRelationsPressedListener(this.topbar_options_module_onRelationsButtonClicked.bindenv(this));
		topbarOptionsModule.setOnPerksPressedListener(this.topbar_options_module_onPerksButtonClicked.bindenv(this));
		topbarOptionsModule.setOnObituaryPressedListener(this.topbar_options_module_onObituaryButtonClicked.bindenv(this));
		topbarOptionsModule.setOnQuitPressedListener(this.topbar_options_module_onQuitButtonClicked.bindenv(this));
		topbarOptionsModule.enablePerksButton(this.Const.DLC.Desert);
		local dayTimeModule = this.m.WorldScreen.getTopbarDayTimeModule();
		dayTimeModule.setOnPausePressedListener(this.topbar_daytime_module_onPauseButtonClicked.bindenv(this));
		dayTimeModule.setOnTimePausePressedListener(this.setPausedTime.bindenv(this));
		dayTimeModule.setOnTimeNormalPressedListener(this.setNormalTime.bindenv(this));
		dayTimeModule.setOnTimeFastPressedListener(this.setFastTime.bindenv(this));
		this.m.CombatDialog <- this.new("scripts/ui/screens/world/world_combat_dialog");
		this.m.CombatDialog.setOnEngageButtonPressedListener(this.combat_dialog_module_onEngagePressed.bindenv(this));
		this.m.CombatDialog.setOnCancelButtonPressedListener(this.combat_dialog_module_onCancelPressed.bindenv(this));
		this.m.EventScreen = this.new("scripts/ui/screens/world/world_event_screen");
		this.m.WorldTownScreen <- this.new("scripts/ui/screens/world/world_town_screen");
		this.m.WorldTownScreen.setOnBrothersPressedListener(this.town_screen_main_dialog_module_onBrothersButtonClicked.bindenv(this));
		this.m.WorldTownScreen.setOnModuleClosedListener(this.town_screen_main_dialog_module_onLeaveButtonClicked.bindenv(this));
		this.m.CampScreen <- this.new("scripts/ui/screens/world/camp_screen");
		this.m.CampScreen.setOnBrothersPressedListener(this.camp_screen_main_dialog_module_onBrothersButtonClicked.bindenv(this));
		this.m.CampScreen.setOnCommanderPressedListener(this.camp_screen_main_dialog_module_onCommanderButtonClicked.bindenv(this));
		this.m.CampScreen.setOnTentPressedListener(this.camp_screen_main_dialog_module_onTentButtonClicked.bindenv(this));
		this.m.CampScreen.setOnModuleClosedListener(this.town_screen_main_dialog_module_onLeaveButtonClicked.bindenv(this));
		this.m.CampScreen.setOnCampListener(this.onCamp.bindenv(this));
		this.m.WorldEventPopupScreen <- this.new("scripts/ui/screens/world/world_event_popup_screen");
		this.m.WorldEventPopupScreen.setOnLeavePressedListener(this.town_screen_main_dialog_module_onLeaveButtonClicked.bindenv(this));
		this.m.RelationsScreen <- this.new("scripts/ui/screens/world/world_relations_screen");
		this.m.RelationsScreen.setOnClosePressedListener(this.town_screen_main_dialog_module_onLeaveButtonClicked.bindenv(this));
		this.m.ObituaryScreen <- this.new("scripts/ui/screens/world/world_obituary_screen");
		this.m.ObituaryScreen.setOnClosePressedListener(this.town_screen_main_dialog_module_onLeaveButtonClicked.bindenv(this));

		if (this.Const.DLC.Desert)
		{
			this.m.CampfireScreen <- this.new("scripts/ui/screens/world/world_campfire_screen");
			this.m.CampfireScreen.setOnModuleClosedListener(this.town_screen_main_dialog_module_onLeaveButtonClicked.bindenv(this));
		}

		this.m.WorldMenuScreen <- this.new("scripts/ui/screens/menu/world_menu_screen");
		local mainMenuModule = this.m.WorldMenuScreen.getMainMenuModule();
		mainMenuModule.setOnResumePressedListener(this.main_menu_module_onResumePressed.bindenv(this));
		mainMenuModule.setOnLoadCampaignPressedListener(this.main_menu_module_onLoadCampaignPressed.bindenv(this));
		mainMenuModule.setOnSaveCampaignPressedListener(this.main_menu_module_onSaveCampaignPressed.bindenv(this));
		mainMenuModule.setOnOptionsPressedListener(this.main_menu_module_onOptionsPressed.bindenv(this));
		mainMenuModule.setOnRetirePressedListener(this.main_menu_module_onRetirePressed.bindenv(this));
		mainMenuModule.setOnQuitPressedListener(this.main_menu_module_onQuitPressed.bindenv(this));
		local loadCampaignMenuModule = this.m.WorldMenuScreen.getLoadCampaignMenuModule();
		loadCampaignMenuModule.setOnLoadButtonPressedListener(this.campaign_menu_module_onLoadPressed.bindenv(this));
		loadCampaignMenuModule.setOnCancelButtonPressedListener(this.campaign_menu_module_onCancelPressed.bindenv(this));
		local saveCampaignMenuModule = this.m.WorldMenuScreen.getSaveCampaignMenuModule();
		saveCampaignMenuModule.setOnSaveButtonPressedListener(this.campaign_menu_module_onSavePressed.bindenv(this));
		saveCampaignMenuModule.setOnCancelButtonPressedListener(this.campaign_menu_module_onCancelPressed.bindenv(this));
		local optionsMenuModule = this.m.WorldMenuScreen.getOptionsMenuModule();
		optionsMenuModule.setOnOkButtonPressedListener(this.options_menu_module_onOkPressed.bindenv(this));
		optionsMenuModule.setOnCancelButtonPressedListener(this.options_menu_module_onCancelPressed.bindenv(this));
		this.m.WorldGameFinishScreen <- this.new("scripts/ui/screens/world/world_game_finish_screen");
		this.m.WorldGameFinishScreen.setOnQuitButtonPressedListener(this.game_finish_dialog_onQuitPressed.bindenv(this));
		this.m.CharacterScreen <- this.new("scripts/ui/screens/character/character_screen");
		this.m.CharacterScreen.setOnCloseButtonClickedListener(this.character_screen_onClosePressed.bindenv(this));
		this.m.CharacterScreen.setStashMode();
		this.initLoadingScreenHandler();
	}

	function onDestroyUI()
	{
		this.m.WorldEventPopupScreen.destroy();
		this.m.WorldMenuScreen.destroy();
		this.m.WorldTownScreen.destroy();
		this.m.CampScreen.destroy();
		this.m.EventScreen.destroy();
		this.m.WorldGameFinishScreen.destroy();
		this.m.WorldScreen.destroy();
		this.m.CharacterScreen.destroy();
		this.m.RelationsScreen.destroy();
		this.m.ObituaryScreen.destroy();
		this.m.CombatDialog.destroy();

		if (this.Const.DLC.Desert)
		{
			this.m.CampfireScreen.destroy();
		}

		this.m.MenuStack.destroy();
		this.m.MenuStack = null;
		this.m.WorldEventPopupScreen = null;
		this.m.WorldMenuScreen = null;
		this.m.WorldTownScreen = null;
		this.m.CampScreen = null;
		this.m.WorldGameFinishScreen = null;
		this.m.WorldGameFinishScreen = null;
		this.m.WorldScreen = null;
		this.m.CharacterScreen = null;
		this.m.RelationsScreen = null;
		this.m.ObituaryScreen = null;
		this.m.CampfireScreen = null;
		this.m.CombatDialog = null;
	}

	function onFinish()
	{
		this.World.setSpeedMult(1.0);
		this.Music.setTrackList(this.Const.Music.MenuTracks, this.Const.Music.CrossFadeTime);
		this.Time.clearEvents();
		this.logDebug("Clearing World Scene");
		this.m.Combat.clear();
		this.m.Combat = null;
		this.m.Contracts.clear();
		this.m.Contracts = null;
		this.World.Contracts = null;
		this.m.Events.clear();
		this.m.Events = null;
		this.World.Events = null;
		this.m.Crafting.clear();
		this.m.Crafting = null;
		this.World.Crafting = null;
		this.m.Ambitions.clear();
		this.m.Ambitions = null;
		this.World.Ambitions = null;
		this.m.Retinue.clear();
		this.m.Retinue = null;
		this.World.Retinue = null;
		this.m.Statistics.clear();
		this.m.Statistics = null;
		this.World.Statistics = null;
		this.m.Flags.clear();
		this.m.Flags = null;
		this.World.Flags = null;
		this.m.Assets.destroy();
		this.m.Assets = null;
		this.World.Assets = null;
		this.World.clearScene();
		this.World.setVisible(false);
		this.m.Factions.clear();
		this.m.Factions = null;
		this.World.FactionManager = null;
		this.m.Entities.clear();
		this.m.Entities = null;
		this.World.EntityManager = null;
		this.World.State = null;
		this.Root.setBackgroundTaskCallback(null);
		this.m.Camp.destroy();
		this.m.Camp = null;
		this.World.Camp = null;
		this.onDestroyUI();
		this.Sound.stopAmbience();
	}

	function onShow()
	{
		this.Cursor.setCursor(this.Const.UI.Cursor.Hand);
		this.World.setVisible(true);
		this.m.WorldScreen.show();
		this.LoadingScreen.hide();
		this.updateTopbarAssets();
		::World.setPlayerPos(this.getPlayer().getPos())
        ::World.setPlayerVisionRadius(this.getPlayer().getVisionRadius())
	}

	function onHide()
	{
		this.logDebug("WorldState::onHide");
		this.m.MenuStack.popAll();
		this.m.WorldMenuScreen.hide();
		this.m.WorldScreen.hide();
		this.World.setVisible(false);
	}

	function onSiblingSentMessage( _stateName, _message )
	{
		this.logDebug("WorldState::onSiblingSentMessage(" + _stateName + " : " + _message + ");");

		if (_stateName == "MainMenuState" && _message == "FullyLoaded")
		{
			this.finish();
		}
		else if (_stateName == "TacticalFromWorldState" && _message == "AboutToFinish")
		{
			this.onReturnedFromTactical();
		}
		else if (_stateName == "TacticalFromWorldState" && _message == "QuitToMenu")
		{
			if (this.World.Assets.isIronman() && (this.World.getTime().Days > 1 || !this.World.getTime().IsDaytime))
			{
				this.World.getPlayerRoster().clear();
				this.autosave();
				this.showGameFinishScreen(false);
			}
			else
			{
				this.exitGame();
			}
		}
	}

	function onProcessInThread()
	{
		if (!this.isPaused() && this.m.IsUpdatedOnce || this.m.IsRunningUpdatesWhilePaused)
		{
			this.World.EntityManager.update();
			this.World.FactionManager.update(this.m.IsRunningUpdatesWhilePaused);
			this.World.Combat.update();
		}
	}

	function onUpdate()
	{
		if (!this.m.IsGameOver && (this.World.getPlayerRoster().getSize() == 0 || !this.World.Assets.getOrigin().onCombatFinished()))
		{
			this.showGameFinishScreen(false);
			return;
		}

		this.Root.setBackgroundTaskCallback(this.onProcessInThread.bindenv(this));

		if (this.Time.getFrame() == this.m.AutoUnpauseFrame)
		{
			this.m.AutoUnpauseFrame = 0;
			this.setAutoPause(false);

			if (this.Settings.getGameplaySettings().AutoPauseAfterCity)
			{
				this.setPause(true);
			}
		}

		if (this.World.Camp.isCamping())
		{
			this.m.LastWorldSpeedMult = this.Const.World.SpeedSettings.CampMult;

			if (!this.isPaused())
			{
				this.World.setSpeedMult(this.Const.World.SpeedSettings.CampMult);
				this.m.Camp.update(this);
			}
		}

		if (!this.isPaused())
		{
			this.m.IsRunningUpdatesWhilePaused = false;
			this.World.Contracts.update();
			this.m.Assets.update(this);
		}
		else if (this.m.IsTriggeringContractUpdatesOnce && !this.m.MenuStack.hasBacksteps() && !(this.LoadingScreen.isAnimating() || this.LoadingScreen.isVisible()))
		{
			this.m.IsTriggeringContractUpdatesOnce = false;
			this.World.Contracts.update(true);
			this.m.Events.update();
		}

		if (this.m.MenuStack.hasBacksteps())
		{
			this.resetCameraState();
		}
		else
		{
			this.updateCameraScrolling();
			this.updateCursorAndTooltip();

			if (this.Settings.getTempGameplaySettings().CameraLocked)
			{
				this.World.getCamera().setPos(this.World.State.getPlayer().getPos());
			}
		}

		this.World.getCamera().update();
		this.World.update();
		this.updateScene();
		this.updateDayTime();

		if (this.m.AIEngageCallback != null)
		{
			this.m.AIEngageCallback();
			this.m.AIEngageCallback = null;
		}
		else if (this.m.AutoEnterLocation != null && !this.m.AutoEnterLocation.isNull())
		{
			if (this.m.Player.getTile().isSameTileAs(this.m.AutoEnterLocation.getTile()) && this.m.Player.getDistanceTo(this.m.AutoEnterLocation.get()) <= this.Const.World.CombatSettings.CombatPlayerDistance)
			{
				this.enterLocation(this.m.AutoEnterLocation.get());
			}
		}
		else if (this.m.AutoAttack != null && !this.m.AutoAttack.isNull() && this.m.AutoAttack.isAlive() && !this.m.AutoAttack.isHiddenToPlayer())
		{
			if (this.m.Player.getDistanceTo(this.m.AutoAttack.get()) <= this.Const.World.CombatSettings.CombatPlayerDistance)
			{
				if (this.m.AutoAttack.isAlliedWithPlayer() && this.World.Contracts.getActiveContract() == null)
				{
					local f = this.World.FactionManager.getFaction(this.m.AutoAttack.getFaction());
					f.addPlayerRelation(-f.getPlayerRelation(), "Attacked them");
					this.m.AutoAttack.updatePlayerRelation();
					this.World.Assets.addMoralReputation(-2);
				}

				if (this.m.AutoAttack.onEnteringCombatWithPlayer())
				{
					this.showCombatDialog();
				}

				this.m.AutoAttack = null;
				this.m.Player.setPath(null);
				this.m.Player.setDestination(null);
			}
			else if (this.getVecDistance(this.m.AutoAttack.getPos(), this.m.Player.getPos()) <= this.Const.World.MovementSettings.PlayerDirectMoveRadius)
			{
				this.m.Player.setPath(null);
				this.m.Player.setDestination(this.m.AutoAttack.getPos());
			}
			else if (!this.m.Player.hasPath() || this.Time.getVirtualTimeF() - this.m.LastAutoAttackPath >= 0.1)
			{
				local navSettings = this.World.getNavigator().createSettings();
				navSettings.ActionPointCosts = this.Const.World.TerrainTypeNavCost;
				navSettings.RoadMult = 1.0 / this.Const.World.MovementSettings.RoadMult;
				local path = this.World.getNavigator().findPath(this.m.Player.getTile(), this.m.AutoAttack.getTile(), navSettings, 0);

				if (!path.isEmpty())
				{
					this.m.Player.setPath(path);
				}
				else
				{
					this.m.Player.setPath(null);
				}

				this.m.LastAutoAttackPath = this.Time.getVirtualTimeF();
			}
		}
		else if (!this.m.IsGamePaused && !this.m.IsGameAutoPaused)
		{
			this.m.Events.update();
			this.m.Ambitions.update();

			if (this.Time.getRealTimeF() - this.m.LastMusicUpdate > 60.0)
			{
				this.setWorldmapMusic(true);
			}
		}

		if (this.m.LastEnteredTown == null && (this.m.LastPlayerTile == null || this.m.LastIsDaytime != this.World.getTime().IsDaytime || this.m.LastPlayerTile.ID != this.m.Player.getTile().ID))
		{
			this.m.LastPlayerTile = this.m.Player.getTile();
			this.m.LastIsDaytime = this.World.getTime().IsDaytime;
			this.Sound.setAmbience(0, this.getSurroundingAmbienceSounds(), this.Const.Sound.Volume.Ambience * this.Const.Sound.Volume.AmbienceTerrain, this.World.getTime().IsDaytime ? this.Const.Sound.AmbienceMinDelay : this.Const.Sound.AmbienceMinDelayAtNight);
			this.Sound.setAmbience(1, this.getSurroundingLocationSounds(), this.Const.Sound.Volume.Ambience * this.Const.Sound.Volume.AmbienceOutsideSettlement, this.Const.Sound.AmbienceOutsideDelay);
		}

		local zoom_banner = this.m.Player.getSprite("zoom_banner");

		if (zoom_banner.IsFadingDone)
		{
			if (this.World.getCamera().Zoom >= 4.0)
			{
				if (zoom_banner.Alpha == 0)
				{
					zoom_banner.fadeIn(300);
				}
			}
			else if (this.World.getCamera().Zoom < 4.0)
			{
				if (zoom_banner.Alpha != 0)
				{
					zoom_banner.fadeOut(300);
				}
			}
		}

		this.m.IsUpdatedOnce = true;
	}

	function onRender()
	{
		this.World.prepareRender();
		this.renderScene();
		this.World.render();
	}

	function onKeyInput( _key )
	{
		return this.helper_handleContextualKeyInput(_key);
		return false;
	}

	function onMouseInput( _mouse )
	{
		if (this.isInLoadingScreen())
		{
			return true;
		}

		if (this.isInDevScreen())
		{
			return true;
		}

		local mouseMoved = _mouse.getID() == 6;

		if (mouseMoved)
		{
			this.Cursor.setPosition(_mouse.getX(), _mouse.getY());
		}

		if (this.m.MenuStack.hasBacksteps())
		{
			return false;
		}

		if (_mouse.getID() == 7)
		{
			if (_mouse.getState() == 3)
			{
				this.World.getCamera().zoomBy(-this.Time.getDelta() * this.Math.max(60, this.Time.getFPS()) * 0.3);
				return true;
			}
			else if (_mouse.getState() == 4)
			{
				this.World.getCamera().zoomBy(this.Time.getDelta() * this.Math.max(60, this.Time.getFPS()) * 0.3);
				return true;
			}
		}

		if (mouseMoved)
		{
			this.updateCursorAndTooltip();
		}

		this.updateCamera(_mouse);
		local isEscorting = this.m.EscortedEntity != null && !this.m.EscortedEntity.isNull();

		if (_mouse.getState() == 1 && !this.isInCameraMovementMode())
		{
			if (!this.m.WasInCameraMovementMode)
			{
				local dest = this.World.getCamera().screenToWorld(_mouse.getX(), _mouse.getY());
				local destTile = this.World.worldToTile(dest);
				local forceAttack = this.m.IsForcingAttack && this.World.Contracts.getActiveContract() == null;
				this.m.AutoEnterLocation = null;
				this.m.AutoAttack = null;
				this.m.LastAutoAttackPath = 0.0;

				if (!this.World.Camp.isCamping())
				{
					local entities = this.World.getAllEntitiesAndOneLocationAtPos(this.World.getCamera().screenToWorld(_mouse.getX(), _mouse.getY()), 1.0);

					foreach( entity in entities )
					{
						if (entity.getID() == this.m.Player.getID())
						{
							continue;
						}

						if (entity.isParty())
						{
							if (!isEscorting && entity.isAttackable() && entity.getVisibilityMult() != 0 && !entity.isHiddenToPlayer() && (!entity.isAlliedWith(this.m.Player) || forceAttack))
							{
								if (this.m.Player.getDistanceTo(entity) <= this.Const.World.CombatSettings.CombatPlayerDistance)
								{
									if (forceAttack && entity.isAlliedWith(this.m.Player))
									{
										local f = this.World.FactionManager.getFaction(entity.getFaction());
										f.addPlayerRelation(-f.getPlayerRelation(), "Attacked them");
										entity.updatePlayerRelation();
										this.World.Assets.addMoralReputation(-3);
									}

									if (entity.onEnteringCombatWithPlayer())
									{
										this.showCombatDialog();
									}

									return true;
								}
								else
								{
									this.m.AutoAttack = this.WeakTableRef(entity);
									return true;
								}
							}
						}
						else if (entity.isEnterable() || entity.isAttackable() || !entity.isVisited() || entity.getOnEnterCallback() != null)
						{
							if (entity.getTile().isSameTileAs(this.m.Player.getTile()) && this.m.Player.getDistanceTo(entity) <= this.Const.World.CombatSettings.CombatPlayerDistance)
							{
								if (!isEscorting || entity.isAlliedWithPlayer())
								{
									this.enterLocation(entity);
									return true;
								}
							}
							else if (!isEscorting)
							{
								this.m.AutoEnterLocation = this.WeakTableRef(entity);

								if (entity.isEnterable() && entity.isAlliedWithPlayer())
								{
									this.m.WorldTownScreen.getMainDialogModule().preload(entity);
								}
							}
						}
					}
				}

				if (this.m.EscortedEntity != null && !this.m.EscortedEntity.isNull())
				{
					return false;
				}

				if (this.getVecDistance(dest, this.m.Player.getPos()) <= this.Const.World.MovementSettings.PlayerDirectMoveRadius || this.World.isValidTile(destTile.X, destTile.Y) && !this.World.getTile(destTile).IsDiscovered)
				{
					if (this.World.Camp.isCamping())
					{
						if (this.isPaused())
						{
							return false;
						}
						this.onCamp();
						return true;
					}

					this.m.Player.setPath(null);
					this.m.Player.setDestination(dest);
				}
				else if (this.World.isValidTile(destTile.X, destTile.Y))
				{
					if (this.World.Camp.isCamping())
					{
						if (this.isPaused())
						{
							return false;
						}
						this.onCamp();
						return true;
					}

					local navSettings = this.World.getNavigator().createSettings();
					navSettings.ActionPointCosts = this.Const.World.TerrainTypeNavCost;
					navSettings.RoadMult = 1.0 / this.Const.World.MovementSettings.RoadMult;
					local path = this.World.getNavigator().findPath(this.m.Player.getTile(), this.World.getTile(destTile), navSettings, 0);

					if (!path.isEmpty())
					{
						this.m.Player.setPath(path);
					}
					else
					{
						this.m.Player.setPath(null);
					}
				}
			}
		}

		return false;
	}

	function onContextLost()
	{
	}

	function onReturnedFromTactical()
	{
		this.initLoadingScreenHandler();
		this.sendMessageToSiblings("FullyLoaded");
		this.Tactical.setActive(false);
		this.onCombatFinished();
	}

	function init()
	{
		this.initOptions();

		if (this.m.CampaignToLoadFileName != null)
		{
			this.loadCampaign(this.m.CampaignToLoadFileName);
			this.m.CampaignToLoadFileName = null;
		}
		else
		{
			this.startNewCampaign();
		}

		this.Root.setBackgroundTaskCallback(this.onProcessInThread.bindenv(this));
		this.show();
	}

	function setupWeather()
	{
		local clouds = this.World.getWeather().createCloudSettings();
		clouds.MinClouds = 70;
		clouds.MaxClouds = 70;
		clouds.MinVelocity = 35.0;
		clouds.MaxVelocity = 65.0;
		clouds.MinAlpha = 0.8;
		clouds.MaxAlpha = 0.8;
		clouds.MinScale = 1.0;
		clouds.MaxScale = 1.25;
		this.World.getWeather().buildCloudCover(clouds);
		local birds = this.World.getWeather().createBirdSettings();
		birds.MinBirds = 12;
		birds.MaxBirds = 12;
		birds.MinVelocity = 45.0;
		birds.MaxVelocity = 65.0;
		this.World.getWeather().buildBirds(birds);
	}

	function startNewCampaign()
	{
		this.setAutoPause(true);
		this.Time.setVirtualTime(0);
		this.m.IsRunningUpdatesWhilePaused = true;
		this.setPause(true);
		this.Math.seedRandomString(this.m.CampaignSettings.Seed);
		this.Const.World.settingsUpdate();
		local worldmap = this.MapGen.get("world.worldmap_generator");
		local minX = worldmap.getMinX();
		local minY = worldmap.getMinY();
		this.World.resizeScene(minX, minY);
		this.logInfo("Generating world with following settings...")
		foreach (k,v in this.Const.World.Settings)
		{
			this.logInfo(k + " : " + v);
		}
		worldmap.fill({
			X = 0,
			Y = 0,
			W = minX,
			H = minY
		}, this.m.CampaignSettings);
		this.m.Assets.init();
		this.m.Camp.init();
		//this.LoadingScreen.updateProgress("Creating Factions ...");
		this.World.FactionManager.createFactions(this.m.CampaignSettings);
		this.World.EntityManager.buildRoadAmbushSpots();
		this.Math.seedRandomString(this.m.CampaignSettings.Seed);

		if (this.m.CampaignSettings != null)
		{
			this.m.Assets.setCampaignSettings(this.m.CampaignSettings);
			this.m.CampaignSettings.StartingScenario.onSpawnPlayer();
			this.m.CampaignSettings.StartingScenario.onInit();
			this.World.uncoverFogOfWar(this.getPlayer().getTile().Pos, 900.0);
		}

		this.World.FactionManager.uncoverSettlements(this.m.CampaignSettings.ExplorationMode);
		this.World.FactionManager.runSimulation();
		this.m.CampaignSettings = null;
		this.setupWeather();
		this.Math.seedRandom(this.Time.getRealTime());

		if (this.Const.DLC.Unhold)
		{
			this.World.Flags.set("IsUnholdCampaign", true);
		}

		if (this.Const.DLC.Wildmen)
		{
			this.World.Flags.set("IsWildmenCampaign", true);
		}

		if (this.Const.DLC.Desert)
		{
			this.World.Flags.set("IsDesertCampaign", true);
		}

		this.World.setFogOfWar(!::Legends.Mod.ModSettings.getSetting("DebugMap").getValue());
		this.World.Crafting.resetAllBlueprints();
	}

	function showIntroductionScreen( _tag = null )
	{
		this.Music.setTrackList(this.Const.Music.CivilianTracks, this.Const.Music.CrossFadeTime);
		this.World.Contracts.update(true);
	}

	function initOptions()
	{
		local settings = this.Settings.getControlSettings();
		this.m.UseDragStyleScrolling = settings.UseDragStyleScrolling;
	}

	function exitGame()
	{
		if (this.World.Assets.isIronman() && this.World.getPlayerRoster().getSize() > 0)
		{
			this.autosave();
		}

		this.m.ExitGame = true;
		this.LoadingScreen.show();
	}

	function setCampaignToLoadFileName( _campaignFileName )
	{
		this.m.CampaignToLoadFileName = _campaignFileName;
	}

	function loadCampaign( _campaignFileName )
	{
		if (this.Time.getRealTimeF() - this.m.CampaignLoadTime < 4.0)
		{
			return;
		}

		this.m.CampaignLoadTime = this.Time.getRealTimeF();
		this.logDebug("Load campaign: " + _campaignFileName);
		this.World.load(_campaignFileName);
		this.setupWeather();
		this.updateDayTime();
		this.setWorldmapMusic(false);
		this.World.Crafting.resetAllBlueprints();
		this.setPause(true);
	}

	function saveCampaign( _campaignFileName, _campaignLabel = null )
	{
		if (_campaignLabel == null)
		{
			_campaignLabel = _campaignFileName;
		}

		this.logDebug("Save campaign: " + _campaignLabel);
		this.World.save(_campaignFileName, _campaignLabel);
	}

	function setNewCampaignSettings( _settings )
	{
		foreach(k,v in _settings)
		{
			this.logInfo(k + " = " + v);
		}
		this.m.CampaignSettings = _settings;
	}

	function enterLocation( _location )
	{
		if (this.m.MenuStack.hasBacksteps() || this.m.LastEnteredTown != null || this.m.CombatProperties != null)
		{
			return false;
		}

		this.logDebug("Location entered: " + _location.getName());

		if (!this.isPaused())
		{
			this.setNormalTime();
		}

		this.m.Player.setDestination(null);
		this.m.Player.setPath(null);
		this.m.AutoEnterLocation = null;
		this.m.AutoAttack = null;
		this.m.LastEnteredLocation = this.WeakTableRef(_location);
		this.m.IsRunningUpdatesWhilePaused = false;

		if (_location.isEnterable())
		{
			this.m.LastEnteredTown = this.WeakTableRef(_location);
		}

		if (_location.onEnter())
		{
			if (_location.isEnterable())
			{
				this.showTownScreen();
			}
			else if (_location.isAttackable() && !_location.isAlliedWithPlayer())
			{
				if (_location.onEnteringCombatWithPlayer())
				{
					this.showCombatDialog();
				}
			}
		}

		return true;
	}

	function getLocalCombatProperties( _pos, _ignoreNoEnemies = false )
	{
		local raw_parties = this.World.getAllEntitiesAtPos(_pos, this.Const.World.CombatSettings.CombatPlayerDistance);
		local parties = [];
		local properties = this.Const.Tactical.CombatInfo.getClone();
		local tile = this.World.getTile(this.World.worldToTile(_pos));
		local isAtUniqueLocation = false;
		properties.TerrainTemplate = this.Const.World.TerrainTacticalTemplate[tile.TacticalType];
		properties.Tile = tile;
		properties.InCombatAlready = false;
		properties.IsAttackingLocation = false;
		local factions = [];
		factions.resize(32, 0); // handled by MSU

		foreach( party in raw_parties )
		{
			if (!party.isAlive() || party.isPlayerControlled())
			{
				continue;
			}

			if (!party.isAttackable() || party.getFaction() == 0 || party.getVisibilityMult() == 0)
			{
				continue;
			}

			if (party.isLocation() && party.isLocationType(this.Const.World.LocationType.Unique))
			{
				isAtUniqueLocation = true;
				break;
			}

			if (party.isInCombat())
			{
				raw_parties = this.World.getAllEntitiesAtPos(_pos, this.Const.World.CombatSettings.CombatPlayerDistance * 2.0);
				break;
			}
		}

		foreach( party in raw_parties )
		{
			if (!party.isAlive() || party.isPlayerControlled())
			{
				continue;
			}

			if (!party.isAttackable() || party.getFaction() == 0 || party.getVisibilityMult() == 0)
			{
				continue;
			}

			if (isAtUniqueLocation && (!party.isLocation() || !party.isLocationType(this.Const.World.LocationType.Unique)))
			{
				continue;
			}

			if (!_ignoreNoEnemies)
			{
				local hasOpponent = false;

				foreach( other in raw_parties )
				{
					if (other.isAlive() && !party.isAlliedWith(other))
					{
						hasOpponent = true;
						break;
					}
				}

				if (hasOpponent)
				{
					parties.push(party);
				}
			}
			else
			{
				parties.push(party);
			}
		}

		foreach( party in parties )
		{
			if (party.isInCombat())
			{
				properties.InCombatAlready = true;
			}

			if (party.isLocation())
			{
				properties.IsAttackingLocation = true;
				properties.CombatID = "LocationBattle";
				properties.LocationTemplate = party.getCombatLocation();
				properties.LocationTemplate.OwnedByFaction = party.getFaction();
			}

			this.World.Combat.abortCombatWithParty(party);
			party.onBeforeCombatStarted();
			local troops = party.getTroops();

			foreach( t in troops )
			{
				if (t.Script != "")
				{
					t.Faction <- party.getFaction();
					t.Party <- this.WeakTableRef(party);
					properties.Entities.push(t);

					if (!this.World.FactionManager.isAlliedWithPlayer(party.getFaction()))
					{
						++factions[party.getFaction()];
					}
				}
			}

			if (troops.len() != 0)
			{
				party.onCombatStarted();
				properties.Parties.push(party);
				this.m.PartiesInCombat.push(party);

				if (party.isAlliedWithPlayer())
				{
					properties.AllyBanners.push(party.getBanner());
				}
				else
				{
					properties.EnemyBanners.push(party.getBanner());
				}
			}
		}

		local highest_faction = 0;
		local best = 0;

		foreach( i, f in factions )
		{
			if (f > best)
			{
				best = f;
				highest_faction = i;
			}
		}

		if (this.World.FactionManager.getFaction(highest_faction) != null)
		{
			properties.Music = this.World.FactionManager.getFaction(highest_faction).getCombatMusic();
		}

		return properties;
	}

	function startScriptedCombat( _properties = null, _isPlayerInitiated = true, _isCombatantsVisible = true, _allowFormationPicking = true )
	{
		if (_properties != null)
		{
			this.m.CombatProperties = _properties;
			this.m.CombatProperties.IsPlayerInitiated = _isPlayerInitiated;
			this.Tooltip.hide();
			this.Cursor.setCursor(this.Const.UI.Cursor.Hand);

			if (!_isPlayerInitiated && !_isCombatantsVisible)
			{
				this.LoadingScreen.show();
			}
			else
			{
				this.showCombatDialog(_isPlayerInitiated, _isCombatantsVisible, _allowFormationPicking, _properties);
			}

			return true;
		}
		else
		{
			if (this.m.CombatProperties == null)
			{
				return false;
			}

			if (this.m.CombatSeed == 0)
			{
				foreach( p in this.m.CombatProperties.Parties )
				{
					if (p.getCombatSeed() != 0 && !p.isAlliedWithPlayer())
					{
						this.m.CombatSeed = p.getCombatSeed();
						break;
					}
				}

				if (this.m.CombatSeed == 0)
				{
					this.m.CombatSeed = this.Math.rand();
				}
			}

			this.autosave();

			if (this.Settings.getGameplaySettings().RestoreEquipment)
			{
				this.World.Assets.saveEquipment();
			}

			this.Stash.setLocked(true);
			this.m.CombatStartTime = this.Time.getVirtualTimeF();
			this.Time.setVirtualTime(0);
			this.m.LastWorldSpeedMult = 1.0;
			this.World.setSpeedMult(1.0);

			if (this.m.CombatProperties.Ambience[0].len() != 0)
			{
				this.Sound.setAmbience(0, this.m.CombatProperties.Ambience[0], this.Const.Sound.Volume.Ambience * this.Const.Sound.Volume.AmbienceInTactical, this.m.CombatProperties.AmbienceMinDelay[0]);
			}
			else
			{
				this.Sound.setAmbience(0, this.getSurroundingAmbienceSounds(), this.Const.Sound.Volume.Ambience * this.Const.Sound.Volume.AmbienceInTactical, this.World.getTime().IsDaytime ? this.Const.Sound.AmbienceMinDelay : this.Const.Sound.AmbienceMinDelayAtNight);
			}

			if (this.m.CombatProperties.Ambience[1].len() != 0)
			{
				this.Sound.setAmbience(1, this.m.CombatProperties.Ambience[1], this.Const.Sound.Volume.Ambience * this.Const.Sound.Volume.AmbienceInTactical, this.m.CombatProperties.AmbienceMinDelay[1]);
			}
			else
			{
				this.Sound.setAmbience(1, [], 0.0, 0);
			}

			local tacticalState = this.RootState.add("TacticalFromWorldState", "scripts/states/tactical_state");
			tacticalState.setScenario(null);
			tacticalState.setStrategicProperties(this.m.CombatProperties);
			this.m.CombatProperties = null;
			return true;
		}
	}

	function startCombat( _pos )
	{
		local properties = this.getLocalCombatProperties(_pos);

		if (properties.Entities.len() == 0)
		{
			return false;
		}

		properties.IsPlayerInitiated = this.m.EngageByPlayer;

		if (this.m.CombatSeed == 0)
		{
			foreach( p in properties.Parties )
			{
				if (p.getCombatSeed() != 0 && !p.isAlliedWithPlayer())
				{
					this.m.CombatSeed = p.getCombatSeed();
					break;
				}
			}

			if (this.m.CombatSeed == 0)
			{
				this.m.CombatSeed = this.Math.rand();
			}
		}

		this.autosave();
		this.m.LastWorldSpeedMult = 1.0;
		this.World.setSpeedMult(1.0);

		if (this.Settings.getGameplaySettings().RestoreEquipment)
		{
			this.World.Assets.saveEquipment();
		}

		this.Stash.setLocked(true);
		this.m.CombatStartTime = this.Time.getVirtualTimeF();
		this.Time.setVirtualTime(0);
		this.Sound.setAmbience(0, this.getSurroundingAmbienceSounds(), this.Const.Sound.Volume.Ambience * this.Const.Sound.Volume.AmbienceInTactical, this.World.getTime().IsDaytime ? this.Const.Sound.AmbienceMinDelay : this.Const.Sound.AmbienceMinDelayAtNight);
		this.Sound.setAmbience(1, [], 0.0, 0);
		local tacticalState = this.RootState.add("TacticalFromWorldState", "scripts/states/tactical_state");
		tacticalState.setScenario(null);
		tacticalState.setStrategicProperties(properties);
		return true;
	}

	function onCombatFinished()
	{
		this.logDebug("World::onCombatFinished");
		this.World.FactionManager.onCombatFinished();
		this.World.Statistics.getFlags().increment("LastCombatID", 1);
		this.Time.setVirtualTime(this.m.CombatStartTime);
		this.Math.seedRandom(this.Time.getRealTime());
		this.m.CombatStartTime = 0;
		this.m.CombatSeed = 0;
		this.World.Statistics.getFlags().set("LastCombatSavedCaravan", false);

		if (!this.World.Statistics.getFlags().get("LastCombatWasArena"))
		{
			local nonLocationBattle = true;

			foreach( party in this.m.PartiesInCombat )
			{
				if (party.isLocation() && !party.isAlliedWithPlayer())
				{
					nonLocationBattle = false;
				}

				if (party.isAlive() && party.getTroops().len() == 0)
				{
					party.onCombatLost();
				}
				else if (party.isAlive() && party.isAlliedWithPlayer() && party.getFlags().get("IsCaravan") && this.m.EscortedEntity == null)
				{
					this.World.Statistics.getFlags().set("LastCombatSavedCaravan", true);

					if (this.World.Statistics.getFlags().has("LastCombatSavedCaravanProduce") && typeof this.World.Statistics.getFlags().get("LastCombatSavedCaravanProduce") != "string")
					{
						this.World.Statistics.getFlags().remove("LastCombatSavedCaravanProduce");
					}

					if (party.getStashInventory().getItems().len() != 0)
					{
						local prefix = "scripts/items/";
						local script = this.IO.scriptFilenameByHash(::MSU.Array.rand(party.getStashInventory().getItems()).ClassNameHash);
						this.World.Statistics.getFlags().set("LastCombatSavedCaravanProduce", script.slice(prefix.len()));
					}
					else if (party.getInventory().len() != 0)
					{
						this.World.Statistics.getFlags().set("LastCombatSavedCaravanProduce", ::MSU.Array.rand(party.getInventory()));
					}
				}
			}

			this.m.PartiesInCombat = [];

			if (nonLocationBattle)
			{
				local playerTile = this.getPlayer().getTile();
				local battlefield;

				if (!playerTile.IsOccupied)
				{
					battlefield = this.World.spawnLocation("scripts/entity/world/locations/battlefield_location", playerTile.Coords);
				}
				else
				{
					for( local i = 0; i != 6; i = ++i )
					{
						if (!playerTile.hasNextTile(i))
						{
						}
						else
						{
							local nextTile = playerTile.getNextTile(i);

							if (!nextTile.IsOccupied)
							{
								battlefield = this.World.spawnLocation("scripts/entity/world/locations/battlefield_location", nextTile.Coords);
								break;
							}
						}
					}
				}

				if (battlefield != null)
				{
					battlefield.setSize(2);
				}
			}
		}

		if (this.World.getPlayerRoster().getSize() == 0 || !this.World.Assets.getOrigin().onCombatFinished() || this.commanderDied())
		{
			if (this.World.Assets.isIronman())
			{
				this.autosave();
			}

			this.show();
			this.showGameFinishScreen(false);
			return;
		}

		local playerRoster = this.World.getPlayerRoster().getAll();

		foreach( bro in playerRoster )
		{
			bro.onCombatFinished();
		}

		this.Stash.setLocked(false);
		this.Sound.stopAmbience();
		this.Sound.setAmbience(0, this.getSurroundingAmbienceSounds(), this.Const.Sound.Volume.Ambience * this.Const.Sound.Volume.AmbienceTerrain, this.World.getTime().IsDaytime ? this.Const.Sound.AmbienceMinDelay : this.Const.Sound.AmbienceMinDelayAtNight);
		this.Sound.setAmbience(1, this.getSurroundingLocationSounds(), this.Const.Sound.Volume.Ambience * this.Const.Sound.Volume.AmbienceOutsideSettlement, this.Const.Sound.AmbienceOutsideDelay);

		if (this.Settings.getGameplaySettings().RestoreEquipment)
		{
			this.World.Assets.restoreEquipment();
		}

		this.World.Assets.consumeItems();
		this.World.Assets.refillAmmo();
		this.World.Assets.updateAchievements();
		this.World.Assets.checkAmbitionItems();
		this.updateTopbarAssets();
		this.World.State.getPlayer().updateStrength();
		this.World.Events.updateBattleTime();
		this.World.Ambitions.resetTime();
		this.stunPartiesNearPlayer();
		this.setWorldmapMusic(true);

		if (this.World.Assets.isIronman())
		{
			this.autosave();
		}

		this.show();
		this.setAutoPause(false);
		this.setPause(true);
		this.m.IsTriggeringContractUpdatesOnce = true;
	}

	function onCamp()
	{
		if (!this.isCampingAllowed())
		{
			return;
		}

		this.World.Camp.onCamp();

		if (this.World.Camp.isCamping())
		{
			this.m.Player.setDestination(null);
			this.m.Player.setPath(null);
			this.m.AutoEnterLocation = null;
			this.m.AutoAttack = null;
		}

		if (this.World.Camp.isCamping())
		{
			this.m.LastWorldSpeedMult = this.Const.World.SpeedSettings.CampMult;
			this.World.TopbarDayTimeModule.enableNormalTimeButton(false);

			if (!this.isPaused())
			{
				this.World.setSpeedMult(this.Const.World.SpeedSettings.CampMult);
				this.World.TopbarDayTimeModule.updateTimeButtons(2);
			}
			else
			{
				this.World.TopbarDayTimeModule.updateTimeButtons(0);
			}
			this.setPause(false);
		}
		else
		{
			this.m.LastWorldSpeedMult = 1.0;
			this.World.TopbarDayTimeModule.enableNormalTimeButton(true);

			if (!this.isPaused())
			{
				this.World.setSpeedMult(1.0);
				this.World.TopbarDayTimeModule.updateTimeButtons(1);
			}
			else
			{
				this.World.TopbarDayTimeModule.updateTimeButtons(0);
			}
			this.setPause(true);
		}
	}

	function showDialogPopup( _title, _text, _okCallback, _cancelCallback, _isMonologue = false )
	{
		if (!this.DialogScreen.isVisible() && !this.DialogScreen.isAnimating())
		{
			this.setAutoPause(true);
			this.DialogScreen.show(_title, _text, this.onDialogHidden.bindenv(this), _okCallback, _cancelCallback, _isMonologue);
			this.m.WorldScreen.hide();
			this.Cursor.setCursor(this.Const.UI.Cursor.Hand);
			this.m.MenuStack.push(function ()
			{
				this.DialogScreen.hide();
				this.m.WorldScreen.show();
				this.setAutoPause(false);
			}, function ()
			{
				return !this.DialogScreen.isAnimating();
			});
		}
	}

	function onDialogHidden()
	{
		this.m.MenuStack.pop();
	}

	function showEventPopup( _title, _subtitle, _text, _buttonLabel, _isLarge = false, _image = "", _initWorldMusic = false )
	{
		if (!this.m.WorldEventPopupScreen.isVisible() && !this.m.WorldEventPopupScreen.isAnimating())
		{
			this.setAutoPause(true);
			local content = this.m.WorldEventPopupScreen.createContent();
			content.Title = _title;
			content.SubTitle = _subtitle;
			content.Text = _text;
			content.ButtonLabel = _buttonLabel;
			content.Size = _isLarge ? 1 : 0;
			content.Image = _image;
			this.m.WorldEventPopupScreen.setContent(content);
			this.m.WorldEventPopupScreen.show();
			this.m.WorldScreen.hide();
			this.Cursor.setCursor(this.Const.UI.Cursor.Hand);
			this.m.MenuStack.push(function ()
			{
				this.m.WorldEventPopupScreen.hide();
				this.m.WorldScreen.show();
				this.setAutoPause(false);

				if (_initWorldMusic)
				{
					this.setWorldmapMusic(false);
				}
			}, function ()
			{
				return !this.m.WorldEventPopupScreen.isAnimating();
			});
		}
	}

	function updateDayTime()
	{
		this.m.WorldScreen.updateTimeInformation();
	}

	function toggleMenuScreen()
	{
		local hasBacksteps = this.m.MenuStack.hasBacksteps();

		if (!hasBacksteps)
		{
			if (this.cancelCurrentAction())
			{
				return true;
			}

			this.setAutoPause(true);
			this.Tooltip.hide();
			this.m.WorldScreen.hide();
			this.m.WorldMenuScreen.show(!this.World.Assets.isIronman(), this.World.Assets.getSeedString());
			this.Cursor.setCursor(this.Const.UI.Cursor.Hand);
			this.m.CustomZoom = this.World.getCamera().Zoom;
			this.World.getCamera().zoomTo(1.0, 4.0);
			this.m.MenuStack.push(function ()
			{
				this.World.getCamera().zoomTo(this.m.CustomZoom, 4.0);
				this.m.WorldMenuScreen.hide();
				this.m.WorldScreen.show();
				this.Cursor.setCursor(this.Const.UI.Cursor.Hand);
				this.setAutoPause(false);
			}, function ()
			{
				return !this.m.WorldMenuScreen.isAnimating();
			});
			return true;
		}
		else
		{
			if (this.m.MenuStack.isAllowingCancel())
			{
				this.m.MenuStack.pop();
			}

			return true;
		}
	}

	function main_menu_module_onOptionsPressed()
	{
		this.m.WorldMenuScreen.showOptionsMenu();
		this.m.MenuStack.push(function ()
		{
			this.m.WorldMenuScreen.hideOptionsMenu();
		}, function ()
		{
			return !this.m.WorldMenuScreen.isAnimating();
		});
	}

	function main_menu_module_onRetirePressed()
	{
		this.m.WorldMenuScreen.hide();
		this.showGameFinishScreen(true);
	}

	function main_menu_module_onQuitPressed()
	{
		this.exitGame();
	}

	function main_menu_module_onResumePressed()
	{
		this.m.MenuStack.pop();
	}

	function main_menu_module_onLoadCampaignPressed()
	{
		this.m.WorldMenuScreen.showLoadCampaignMenu();
		this.m.MenuStack.push(function ()
		{
			this.m.WorldMenuScreen.hideLoadCampaignMenu();
		}, function ()
		{
			return !this.m.WorldMenuScreen.isAnimating();
		});
	}

	function main_menu_module_onSaveCampaignPressed()
	{
		this.m.WorldMenuScreen.showSaveCampaignMenu();
		this.m.MenuStack.push(function ()
		{
			this.m.WorldMenuScreen.hideSaveCampaignMenu();
		}, function ()
		{
			return !this.m.WorldMenuScreen.isAnimating();
		});
	}

	function campaign_menu_module_onLoadPressed( _campaignFileName )
	{
		if (this.World.Assets.isIronman())
		{
			this.autosave();
		}

		this.m.CampaignToLoadFileName = _campaignFileName;
		this.LoadingScreen.show();
	}

	function campaign_menu_module_onSavePressed( _campaignFileName )
	{
		this.saveCampaign(_campaignFileName);
		this.m.MenuStack.pop();
	}

	function campaign_menu_module_onCancelPressed()
	{
		this.m.MenuStack.pop();
	}

	function options_menu_module_onOkPressed()
	{
		this.initOptions();
		this.m.MenuStack.pop();
	}

	function options_menu_module_onCancelPressed()
	{
		this.m.MenuStack.pop();
	}

	function showGameFinishScreen( _gameWon )
	{
		this.m.GameWon = _gameWon;

		if (!_gameWon)
		{
			this.Music.setTrackList(this.Const.Music.DefeatTracks, this.Const.Music.CrossFadeTime);
			this.updateAchievement("LessonsLearned", 1, 1);

			if (this.World.Assets.isIronman())
			{
				this.updateAchievement("NeverGiveUp", 1, 10);
			}
		}
		else
		{
		}

		this.m.IsGameOver = true;
		this.setAutoPause(true);
		this.Tooltip.hide();
		this.m.WorldScreen.hide(true);
		this.m.WorldGameFinishScreen.show(this.World.Assets.getGameFinishData(_gameWon));
		this.Cursor.setCursor(this.Const.UI.Cursor.Hand);
		this.m.MenuStack.push(function ()
		{
		}, function ()
		{
			return false;
		});
	}

	function game_finish_dialog_onQuitPressed()
	{
		this.exitGame();
	}

	function topbar_daytime_module_onPauseButtonClicked()
	{
		if (!this.m.MenuStack.hasBacksteps())
		{
			this.setPause(!this.isPaused());
		}
	}

	function setPausedTime()
	{
		if (!this.m.MenuStack.hasBacksteps())
		{
			this.setPause(true);
		}
	}

	function setNormalTime()
	{
		if (!this.m.MenuStack.hasBacksteps())
		{
			if (!this.World.Camp.isCamping() && this.m.EscortedEntity == null)
			{
				this.m.LastWorldSpeedMult = 1.0;
			}

			this.setPause(false);
		}
	}

	function setFastTime()
	{
		if (!this.m.MenuStack.hasBacksteps())
		{
			if (!this.World.Camp.isCamping() && this.m.EscortedEntity == null)
			{
				this.m.LastWorldSpeedMult = this.Const.World.SpeedSettings.FastMult;
			}

			this.setPause(false);
		}
	}

	function topbar_options_module_onBrothersButtonClicked()
	{
		if (!this.m.MenuStack.hasBacksteps() && !this.m.EventScreen.isVisible() && !this.m.EventScreen.isAnimating())
		{
			this.showCharacterScreen();
		}
	}

	function topbar_options_module_onActiveContractButtonClicked()
	{
		local activeContract = this.World.Contracts.getActiveContract();

		if (activeContract)
		{
			this.showContractScreen(activeContract);
		}
	}

	function topbar_options_module_onRelationsButtonClicked()
	{
		if (this.m.MenuStack.hasBacksteps() || this.m.EventScreen.isVisible() || this.m.EventScreen.isAnimating())
		{
			return;
		}

		this.setAutoPause(true);
		this.m.CustomZoom = this.World.getCamera().Zoom;
		this.World.getCamera().zoomTo(1.0, 4.0);
		this.Tooltip.hide();
		this.m.WorldScreen.hide();
		this.m.RelationsScreen.show();
		this.Cursor.setCursor(this.Const.UI.Cursor.Hand);
		this.m.MenuStack.push(function ()
		{
			this.World.getCamera().zoomTo(this.m.CustomZoom, 4.0);
			this.m.RelationsScreen.hide();
			this.m.WorldScreen.show();
			this.Cursor.setCursor(this.Const.UI.Cursor.Hand);
			this.setAutoPause(false);
		}, function ()
		{
			return !this.m.RelationsScreen.isAnimating();
		});
	}

	function topbar_options_module_onObituaryButtonClicked()
	{
		if (this.m.MenuStack.hasBacksteps() || this.m.EventScreen.isVisible() || this.m.EventScreen.isAnimating())
		{
			return;
		}

		this.setAutoPause(true);
		this.m.CustomZoom = this.World.getCamera().Zoom;
		this.World.getCamera().zoomTo(1.0, 4.0);
		this.Tooltip.hide();
		this.m.WorldScreen.hide();
		this.m.ObituaryScreen.show();
		this.Cursor.setCursor(this.Const.UI.Cursor.Hand);
		this.m.MenuStack.push(function ()
		{
			this.World.getCamera().zoomTo(this.m.CustomZoom, 4.0);
			this.m.ObituaryScreen.hide();
			this.m.WorldScreen.show();
			this.Cursor.setCursor(this.Const.UI.Cursor.Hand);
			this.setAutoPause(false);
		}, function ()
		{
			return !this.m.RelationsScreen.isAnimating();
		});
	}

	function topbar_options_module_onPerksButtonClicked()
	{
		if (!this.Const.DLC.Desert)
		{
			return;
		}

		if (this.m.MenuStack.hasBacksteps() || this.m.EventScreen.isVisible() || this.m.EventScreen.isAnimating())
		{
			return;
		}

		this.setAutoPause(true);
		this.m.CustomZoom = this.World.getCamera().Zoom;
		this.World.getCamera().zoomTo(1.0, 4.0);
		this.Music.setTrackList(this.Const.Music.CampfireTracks, this.Const.Music.CrossFadeTime);
		this.Tooltip.hide();
		this.m.WorldScreen.hide();
		this.m.CampfireScreen.show();
		this.Cursor.setCursor(this.Const.UI.Cursor.Hand);
		this.m.MenuStack.push(function ()
		{
			this.setWorldmapMusic(false);
			this.World.getCamera().zoomTo(this.m.CustomZoom, 4.0);
			this.m.CampfireScreen.hide();
			this.m.WorldScreen.show();
			this.Cursor.setCursor(this.Const.UI.Cursor.Hand);
			this.setAutoPause(false);
		}, function ()
		{
			return !this.m.CampfireScreen.isAnimating();
		});
	}

	function topbar_options_module_onQuitButtonClicked()
	{
		this.toggleMenuScreen();
	}

	function updateTopbarAssets()
	{
		this.m.WorldScreen.updateAssetsInformation();
	}

	function showCombatDialog( _isPlayerInitiated = true, _isCombatantsVisible = true, _allowFormationPicking = true, _properties = null, _pos = null )
	{
		local entities = [];
		local allyBanners = [];
		local enemyBanners = [];
		local hasOpponents = false;
		local listEntities = _isCombatantsVisible && (_isPlayerInitiated || this.World.Assets.getOrigin().getID() == "scenario.rangers" || this.Const.World.TerrainTypeLineBattle[this.m.Player.getTile().Type] && this.World.getTime().IsDaytime);

		if (_pos == null)
		{
			_pos = this.m.Player.getPos();
		}

		if (_properties != null)
		{
			allyBanners = _properties.AllyBanners;
			enemyBanners = _properties.EnemyBanners;
		}

		if (allyBanners.len() == 0)
		{
			allyBanners.push(this.World.Assets.getBanner());
		}

		if (!_isPlayerInitiated && this.World.Camp.isCamping())
		{
			_allowFormationPicking = false;
		}

		if (!_isPlayerInitiated && !this.Const.World.TerrainTypeLineBattle[this.m.Player.getTile().Type])
		{
			_allowFormationPicking = false;
		}

		local champions = [];
		local entityTypes = [];
		entityTypes.resize(this.Const.EntityType.len(), 0);

		if (_properties != null)
		{
			_properties.IsPlayerInitiated = _isPlayerInitiated;
		}

		if (_properties == null)
		{
			local parties = this.World.getAllEntitiesAtPos(_pos, this.Const.World.CombatSettings.CombatPlayerDistance);
			local isAtUniqueLocation = false;

			if (parties.len() <= 1)
			{
				this.m.EngageCombatPos = null;
				return;
			}

			foreach( party in parties )
			{
				if (!party.isAlive() || party.isPlayerControlled())
				{
					continue;
				}

				if (!party.isAttackable() || party.getFaction() == 0 || party.getVisibilityMult() == 0)
				{
					continue;
				}

				if (party.isLocation() && party.isShowingDefenders() && party.getCombatLocation().Template[0] != null && party.getCombatLocation().Fortification != 0 && !party.getCombatLocation().ForceLineBattle)
				{
					entities.push({
						Name = "Fortifications",
						Icon = "palisade_01_orientation",
						Overlay = null
					});
				}

				if (party.isLocation() && party.isLocationType(this.Const.World.LocationType.Unique))
				{
					isAtUniqueLocation = true;
					break;
				}

				if (party.isInCombat())
				{
					parties = this.World.getAllEntitiesAtPos(_pos, this.Const.World.CombatSettings.CombatPlayerDistance * 2.0);
					break;
				}
			}

			foreach( party in parties )
			{
				if (!party.isAlive() || party.isPlayerControlled())
				{
					continue;
				}

				if (!party.isAttackable() || party.getFaction() == 0 || party.getVisibilityMult() == 0)
				{
					continue;
				}

				if (isAtUniqueLocation && (!party.isLocation() || !party.isLocationType(this.Const.World.LocationType.Unique)))
				{
					continue;
				}

				if (party.isAlliedWithPlayer())
				{
					if (party.getTroops().len() != 0 && allyBanners.find(party.getBanner()) == null)
					{
						allyBanners.push(party.getBanner());
					}

					continue;
				}
				else
				{
					hasOpponents = true;

					if (!party.isLocation() || party.isShowingDefenders())
					{
						if (party.getTroops().len() != 0 && enemyBanners.find(party.getBanner()) == null)
						{
							enemyBanners.push(party.getBanner());
						}
					}
				}

				if (party.isLocation() && !party.isShowingDefenders())
				{
					entityTypes.resize(this.Const.EntityType.len(), 0);
					break;
				}

				party.onBeforeCombatStarted();
				local troops = party.getTroops();

				foreach( t in troops )
				{
					if (t.Script.len() != "")
					{
						if (t.Variant != 0 && this.Const.DLC.Wildmen)
						{
							champions.push(t);
						}
						else
						{
							++entityTypes[t.ID];
						}
					}
				}
			}
		}
		else
		{
			foreach( t in _properties.Entities )
			{
				if (!hasOpponents && (!this.World.FactionManager.isAlliedWithPlayer(t.Faction) || _properties.TemporaryEnemies.find(t.Faction) != null))
				{
					hasOpponents = true;
				}

				if (t.Variant != 0 && this.Const.DLC.Wildmen)
				{
					champions.push(t);
				}
				else
				{
					++entityTypes[t.ID];
				}
			}
		}

		foreach( c in champions )
		{
			entities.push({
				Name = c.Name,
				Icon = this.Const.EntityIcon[c.ID],
				Overlay = "icons/miniboss.png"
			});
		}

		for( local i = 0; i < entityTypes.len(); i = ++i )
		{
			if (entityTypes[i] > 0)
			{
				if (entityTypes[i] == 1)
				{
					local start = this.isFirstCharacter(this.Const.Strings.EntityName[i], [
						"A",
						"E",
						"I",
						"O",
						"U"
					]) ? "An " : "A ";
					entities.push({
						Name = start + this.removeFromBeginningOfText("The ", this.Const.Strings.EntityName[i]),
						Icon = this.Const.EntityIcon[i],
						Overlay = null
					});
				}
				else if (::Legends.Mod.ModSettings.getSetting("ExactEngageNumbers").getValue())
				{
					entities.push({
						Name = entityTypes[i] + " " + this.Const.Strings.EntityNamePlural[i],
						Icon = this.Const.EntityIcon[i],
						Overlay = null
					});
				}
				else
				{
					entities.push({
						Name =  getEngageNumberNames(entityTypes[i]) + " " + this.Const.Strings.EntityNamePlural[i],
						Icon = this.Const.EntityIcon[i],
						Overlay = null
					});
				}
			}
		}

		if (!hasOpponents)
		{
			this.m.EngageCombatPos = null;
			return;
		}

		local text = "";

		if (!listEntities || entities.len() == 0)
		{
			entities = [];
			allyBanners = [];
			enemyBanners = [];

			if (!_isPlayerInitiated)
			{
				text = "You can\'t make out who is attacking you in time.<br/>You have to defend yourself!";
			}
			else
			{
				text = "You can\'t make out who you\'ll be facing. Attack at your own peril and be prepared to retreat if need be!";
			}
		}

		local tile = this.World.getTile(this.World.worldToTile(_pos));
		local image = this.Const.World.TerrainTacticalImage[tile.TacticalType];

		if (!this.World.getTime().IsDaytime)
		{
			image = image + "_night";
		}

		image = image + ".png";
		this.setAutoPause(true);
		this.Cursor.setCursor(this.Const.UI.Cursor.Hand);
		this.m.EngageCombatPos = _pos;
		this.m.EngageByPlayer = _isPlayerInitiated;
		this.Tooltip.hide();
		this.m.WorldScreen.hide();
		this.m.CombatDialog.show(entities, allyBanners, enemyBanners, _isPlayerInitiated || this.m.EscortedEntity != null, _allowFormationPicking, text, image, this.m.EscortedEntity != null ? "Flee!" : "Fall back!");
		this.m.MenuStack.push(function ()
		{
			this.m.EngageCombatPos = null;
			this.m.CombatDialog.hide();
			this.m.WorldScreen.show();
			this.stunPartiesNearPlayer(_isPlayerInitiated);
			this.setAutoPause(false);
		}, function ()
		{
			return !this.m.CombatDialog.isAnimating();
		}, _isPlayerInitiated);
	}

	function getEngageNumberNames( _entityType)
	{
		foreach (key, value in this.Const.Strings.EngageEnemyNumbers)
		{
			if (_entityType >= value[0] && _entityType <= value[1])
			{
				return this.Const.Strings.EngageEnemyNumbersNames[key];
			}
		}
	}

	function combat_dialog_module_onEngagePressed()
	{
		this.LoadingScreen.show();
	}

	function combat_dialog_module_onCancelPressed()
	{
		this.m.CombatProperties = null;
		this.m.MenuStack.pop();

		if (this.m.EscortedEntity != null)
		{
			this.World.Contracts.onRetreatedFromCombat("");
		}

		this.m.Factions.onCombatFinished();
	}

	function stunPartiesNearPlayer( _isMinor = false )
	{
		local pos = this.m.Player.getPos();
		local parties = this.World.getAllEntitiesAtPos(pos, this.Const.World.CombatSettings.CombatPlayerDistance);

		foreach( party in parties )
		{
			if (!party.isPlayerControlled())
			{
				party.stun(_isMinor ? 0.75 : 5.0);
			}
		}
	}

	function getSurroundingAmbienceSounds()
	{
		local sounds = [];
		local playerTile = this.m.Player.getTile();

		if (this.World.getTime().IsDaytime)
		{
			sounds.extend(this.Const.SoundAmbience.Terrain[playerTile.Type]);
		}
		else
		{
			sounds.extend(this.Const.SoundAmbience.TerrainAtNight[playerTile.Type]);
		}

		for( local i = 0; i != 6; i = ++i )
		{
			if (!playerTile.hasNextTile(i))
			{
			}
			else if (this.World.getTime().IsDaytime)
			{
				sounds.extend(this.Const.SoundAmbience.Terrain[playerTile.getNextTile(i).Type]);
			}
			else
			{
				sounds.extend(this.Const.SoundAmbience.TerrainAtNight[playerTile.getNextTile(i).Type]);
			}
		}

		return sounds;
	}

	function getSurroundingLocationSounds()
	{
		local sounds = [];
		local playerTile = this.m.Player.getTile();

		if (playerTile.IsOccupied)
		{
			local e = this.World.getEntityAtTile(playerTile.Coords);

			if (e != null && e.isLocation() && e.isActive())
			{
				sounds.extend(e.getSounds(false));
			}
		}

		for( local i = 0; i != 6; i = ++i )
		{
			if (!playerTile.hasNextTile(i))
			{
			}
			else
			{
				local tile = playerTile.getNextTile(i);

				if (!tile.IsOccupied)
				{
				}
				else
				{
					local e = this.World.getEntityAtTile(tile.Coords);

					if (e != null && e.isLocation() && e.isActive())
					{
						sounds.extend(e.getSounds(false));
					}
				}
			}
		}

		return sounds;
	}

	function showTownScreen()
	{
		if (this.m.MenuStack.hasBacksteps())
		{
			return;
		}

		if (this.m.LastEnteredTown == null)
		{
			return;
		}

		this.m.CustomZoom = this.World.getCamera().Zoom;
		this.World.getCamera().zoomTo(1.0, 4.0);
		this.World.getCamera().moveTo(this.m.LastEnteredTown);
		this.Music.setTrackList(this.m.LastEnteredTown.getMusic(), this.Const.Music.CrossFadeTime);
		this.setAutoPause(true);
		this.Tooltip.hide();
		this.m.WorldScreen.hide();
		this.m.WorldTownScreen.setTown(this.m.LastEnteredTown);
		this.m.WorldTownScreen.show();
		this.Cursor.setCursor(this.Const.UI.Cursor.Hand);
		this.Sound.setAmbience(0, this.getSurroundingAmbienceSounds(), this.Const.Sound.Volume.Ambience * this.Const.Sound.Volume.AmbienceTerrainInSettlement, this.World.getTime().IsDaytime ? this.Const.Sound.AmbienceMinDelay : this.Const.Sound.AmbienceMinDelayAtNight);
		this.Sound.setAmbience(1, this.m.LastEnteredTown.getSounds(), this.Const.Sound.Volume.Ambience * this.Const.Sound.Volume.AmbienceInSettlement, this.World.getTime().IsDaytime ? this.Const.Sound.AmbienceMinDelay : this.Const.Sound.AmbienceMinDelayAtNight);

		if (this.World.Assets.isIronman())
		{
			this.World.presave();
		}

		this.m.MenuStack.push(function ()
		{
			if (this.m.LastEnteredTown != null)
			{
				this.m.LastEnteredTown.onLeave();
				this.m.LastEnteredTown = null;
			}

			if (this.m.CombatStartTime == 0)
			{
				this.Sound.setAmbience(0, this.getSurroundingAmbienceSounds(), this.Const.Sound.Volume.Ambience * this.Const.Sound.Volume.AmbienceTerrain, this.World.getTime().IsDaytime ? this.Const.Sound.AmbienceMinDelay : this.Const.Sound.AmbienceMinDelayAtNight);
				this.Sound.setAmbience(1, this.getSurroundingLocationSounds(), this.Const.Sound.Volume.Ambience * this.Const.Sound.Volume.AmbienceOutsideSettlement, this.Const.Sound.AmbienceOutsideDelay);
			}

			this.World.getCamera().zoomTo(this.m.CustomZoom, 4.0);
			this.World.Assets.consumeItems();
			this.World.Assets.refillAmmo();
			this.World.Assets.updateAchievements();
			this.World.Assets.checkAmbitionItems();
			this.World.Ambitions.updateUI();
			this.World.Ambitions.resetTime(false, 3.0);
			this.updateTopbarAssets();
			this.World.State.getPlayer().updateStrength();
			this.m.WorldTownScreen.clear();
			this.m.WorldTownScreen.hide();
			this.m.WorldScreen.show();
			this.setWorldmapMusic(false);

			if (this.World.Assets.isIronman() && this.m.CombatStartTime == 0)
			{
				this.autosave();
			}

			this.Cursor.setCursor(this.Const.UI.Cursor.Hand);
			this.m.IsForcingAttack = false;
			this.setAutoPause(true);
			this.m.AutoUnpauseFrame = this.Time.getFrame() + 1;
		}, function ()
		{
			return !this.m.WorldTownScreen.isAnimating();
		});
	}

	function showCampScreen()
	{
		if (!this.isCampingAllowed())
		{
			return;
		}

		if (this.World.Camp.isCamping())
		{
			this.onCamp();
			return
		}
		//this.Music.setTrackList(this.m.LastEnteredTown.getMusic(), this.Const.Music.CrossFadeTime);
		this.setPause(true);
		this.setAutoPause(true);
		this.Tooltip.hide();
		this.m.WorldScreen.hide();
		//this.m.WorldTownScreen.setTown(this.m.LastEnteredTown);
		this.m.CampScreen.show();
		this.Cursor.setCursor(this.Const.UI.Cursor.Hand);
		this.Sound.setAmbience(0, this.getSurroundingAmbienceSounds(), this.Const.Sound.Volume.Ambience * this.Const.Sound.Volume.AmbienceTerrainInSettlement, this.World.getTime().IsDaytime ? this.Const.Sound.AmbienceMinDelay : this.Const.Sound.AmbienceMinDelayAtNight);
		//this.Sound.setAmbience(1, this.m.LastEnteredTown.getSounds(), this.Const.Sound.Volume.Ambience * this.Const.Sound.Volume.AmbienceInSettlement, this.World.getTime().IsDaytime ? this.Const.Sound.AmbienceMinDelay : this.Const.Sound.AmbienceMinDelayAtNight);
		this.m.MenuStack.push(function ()
		{
			this.Sound.setAmbience(0, this.getSurroundingAmbienceSounds(), this.Const.Sound.Volume.Ambience * this.Const.Sound.Volume.AmbienceTerrain, this.World.getTime().IsDaytime ? this.Const.Sound.AmbienceMinDelay : this.Const.Sound.AmbienceMinDelayAtNight);
			this.Sound.setAmbience(1, this.getSurroundingLocationSounds(), this.Const.Sound.Volume.Ambience * this.Const.Sound.Volume.AmbienceOutsideSettlement, this.Const.Sound.AmbienceOutsideDelay);
			this.World.getCamera().zoomTo(this.m.CustomZoom, 4.0);
			// this.World.Assets.consumeItems();
			// this.World.Assets.refillAmmo();
			// this.World.Assets.updateAchievements();
			// this.World.Assets.checkAmbitionItems();
			// this.World.Ambitions.resetTime(false, 2.0);
			// this.updateTopbarAssets();
			// this.World.State.getPlayer().updateStrength();
			this.m.CampScreen.clear();
			this.m.CampScreen.hide();
			this.m.WorldScreen.show();
			this.Music.setTrackList(this.World.FactionManager.isGreaterEvil() ? this.Const.Music.WorldmapTracksGreaterEvil : this.Const.Music.WorldmapTracks, this.Const.Music.CrossFadeTime);

			if (this.World.Assets.isIronman())
			{
				this.autosave();
			}

			this.Cursor.setCursor(this.Const.UI.Cursor.Hand);
			this.setAutoPause(false);
			this.setPause(true);
		}, function ()
		{
			return !this.m.CampScreen.isAnimating();
		});
	}

	function town_screen_main_dialog_module_onLeaveButtonClicked()
	{
		this.m.MenuStack.pop();
	}

	function town_screen_main_dialog_module_onBrothersButtonClicked()
	{
		this.showCharacterScreenFromTown();
	}

	function camp_screen_main_dialog_module_onBrothersButtonClicked()
	{
		this.showCharacterScreenFromCamp();
	}

	function camp_screen_main_dialog_module_onCommanderButtonClicked()
	{
		this.showCommanderScreenFromCamp();
	}

	function camp_screen_main_dialog_module_onTentButtonClicked( _id )
	{
		this.showTentScreenFromCamp( _id );
	}

	function initLoadingScreenHandler()
	{
		this.LoadingScreen.clearEventListener();
		this.LoadingScreen.setOnScreenShownListener(this.loading_screen_onScreenShown.bindenv(this));
		this.LoadingScreen.setOnQueryDataListener(this.loading_screen_onQueryData.bindenv(this));
	}

	function isInLoadingScreen()
	{
		if (this.LoadingScreen != null && (this.LoadingScreen.isAnimating() || this.LoadingScreen.isVisible()))
		{
			return true;
		}

		return false;
	}

	function loading_screen_onScreenShown()
	{
		if (!this.m.ExitGame)
		{
			if (this.m.CampaignToLoadFileName != null)
			{
				this.loadCampaign(this.m.CampaignToLoadFileName);
				this.m.CampaignToLoadFileName = null;
				this.m.MenuStack.popAll(true);
				this.show();
				this.LoadingScreen.hide();
			}
			else if (this.isVisible())
			{
				if (this.m.CombatProperties != null)
				{
					this.startScriptedCombat();
				}
				else
				{
					this.startCombat(this.m.EngageCombatPos);
				}

				this.hide();
			}
			else
			{
				this.show();
				this.LoadingScreen.hide();
			}
		}
		else
		{
			this.sendMessageToSiblings("AboutToFinish");
		}
	}

	function loading_screen_onQueryData()
	{
		if (!this.m.ExitGame)
		{
			return {
				imagePath = this.Const.LoadingScreens[this.Math.rand(0, this.Const.LoadingScreens.len() - 1)],
				text = this.Const.TipOfTheDay[this.Math.rand(0, this.Const.TipOfTheDay.len() - 1)]
			};
		}
		else
		{
			return {
				imagePath = this.Const.LoadingScreens[this.Math.rand(0, this.Const.LoadingScreens.len() - 1)],
				text = this.Const.TipOfTheDay[this.Math.rand(0, this.Const.TipOfTheDay.len() - 1)]
			};
		}
	}

	function isInDevScreen()
	{
		if (this.m.WorldScreen != null && this.m.WorldScreen.devConsoleVisible())
		{
			return true;
		}

		return false;
	}

	function isInCharacterScreen()
	{
		if (this.m.CharacterScreen != null && (this.m.CharacterScreen.isVisible() || this.m.CharacterScreen.isAnimating()))
		{
			return true;
		}

		return false;
	}

	function showCharacterScreen()
	{
		if (!this.m.CharacterScreen.isVisible() && !this.m.CharacterScreen.isAnimating())
		{
			this.m.CustomZoom = this.World.getCamera().Zoom;
			this.World.getCamera().zoomTo(1.0, 4.0);
			this.World.Assets.updateFormation();
			this.setAutoPause(true);
			this.m.CharacterScreen.show();
			this.m.WorldScreen.hide();
			this.Cursor.setCursor(this.Const.UI.Cursor.Hand);
			this.m.MenuStack.push(function ()
			{
				this.World.getCamera().zoomTo(this.m.CustomZoom, 4.0);
				this.m.CharacterScreen.hide();
				this.m.WorldScreen.show();
				this.World.Assets.refillAmmo();
				this.updateTopbarAssets();
				this.setAutoPause(false);
			}, function ()
			{
				return !this.m.CharacterScreen.isAnimating();
			});
		}
	}

	function showCharacterScreenFromTown()
	{
		this.World.Assets.updateFormation();
		this.m.WorldTownScreen.hideAllDialogs();
		this.m.CharacterScreen.show();
		this.m.MenuStack.push(function ()
		{
			this.m.CharacterScreen.hide();
			this.m.WorldTownScreen.showLastActiveDialog();
		}, function ()
		{
			return !this.m.CharacterScreen.isAnimating();
		});
	}


	function showCharacterScreenFromCamp()
	{
		this.World.Assets.updateFormation();
		this.m.CampScreen.hideAllDialogs();
		this.m.CharacterScreen.show();
		this.m.MenuStack.push(function ()
		{
			this.m.CharacterScreen.hide();
			this.m.CampScreen.showLastActiveDialog();
		}, function ()
		{
			return !this.m.CharacterScreen.isAnimating();
		});
	}

	function showCommanderScreenFromCamp()
	{
		this.m.CampScreen.hideAllDialogs();
		this.m.CampScreen.showCommanderDialog()
		this.m.MenuStack.push(function ()
		{
			this.m.CampScreen.showLastReturnDialog();
		}, function ()
		{
			return !this.m.CampScreen.isAnimating();
		});
	}

	function showTentScreenFromCamp( _id )
	{
		this.m.CampScreen.hideAllDialogs();
		this.m.CampScreen.showTentBuildingDialog( _id )
		this.m.MenuStack.push(function ()
		{
			this.m.CampScreen.showLastReturnDialog();
		}, function ()
		{
			return !this.m.CampScreen.isAnimating();
		});
	}

	function toggleCharacterScreen()
	{
		if (this.m.CharacterScreen.isVisible())
		{
			this.character_screen_onClosePressed();
		}
		else if (this.m.WorldTownScreen.isVisible())
		{
			this.showCharacterScreenFromTown();
		}
		else
		{
			this.showCharacterScreen();
		}
	}

	function character_screen_onClosePressed()
	{
		this.m.MenuStack.pop();
	}

	function updateCursorAndTooltip()
	{
		if (this.m.MenuStack.hasBacksteps())
		{
			this.Cursor.setCursor(this.Const.UI.Cursor.Hand);
			return;
		}

		local cursorX = this.Cursor.getX();
		local cursorY = this.Cursor.getY();

		if (this.Cursor.isOverUI())
		{
			if (this.m.LastEntityHovered != null || this.m.LastTileHovered != null)
			{
				this.Tooltip.mouseLeaveTile();
				this.m.LastEntityHovered = null;
				this.m.LastTileHovered = null;
			}

			if (!this.Cursor.wasOverUI())
			{
				this.Cursor.setCursor(this.Const.UI.Cursor.Hand);
			}

			return;
		}

		if ((this.m.LastEntityHovered != null || this.m.LastTileHovered != null) && this.isInCameraMovementMode())
		{
			this.m.LastEntityHovered = null;
			this.m.LastTileHovered = null;
			this.Tooltip.mouseLeaveTile();
			return;
		}

		if (!this.isInCameraMovementMode())
		{
			local entity;
			local entities = this.World.getAllEntitiesAndOneLocationAtPos(this.World.getCamera().screenToWorld(cursorX, cursorY), 1.0);

			foreach( e in entities )
			{
				if (e.getID() == this.m.Player.getID())
				{
					continue;
				}

				if (!e.isDiscovered())
				{
					continue;
				}

				if (e.isParty() && e.isHiddenToPlayer())
				{
					continue;
				}

				entity = e;
				break;
			}

			if (entity != null)
			{
				this.m.LastTileHovered = null;

				if (this.m.LastEntityHovered == null || this.m.LastEntityHovered.getID() != entity.getID())
				{
					this.m.LastEntityHovered = entity;
					this.Tooltip.mouseLeaveTile();
					this.Tooltip.mouseEnterTile(cursorX, cursorY, this.m.LastEntityHovered.getID());
				}
				else
				{
					this.Tooltip.mouseHoverTile(cursorX, cursorY);
				}

				if (entity.isParty())
				{
					if (entity.isPlayerControlled() || entity.isAlliedWith(this.World.getPlayerEntity()))
					{
						if (this.m.IsForcingAttack && this.World.Contracts.getActiveContract() == null)
						{
							this.Cursor.setCursor(this.Const.UI.Cursor.Attack);
						}
						else
						{
							this.Cursor.setCursor(this.Const.UI.Cursor.Hand);
						}
					}
					else
					{
						this.Cursor.setCursor(this.Const.UI.Cursor.Attack);
					}
				}
				else if (entity.isAttackable() && entity.getVisibilityMult() != 0 && !entity.isAlliedWithPlayer())
				{
					this.Cursor.setCursor(this.Const.UI.Cursor.Attack);
				}
				else if (entity.isLocationType(this.Const.World.LocationType.Settlement) && entity.isAlliedWithPlayer() || entity.isLocationType(this.Const.World.LocationType.Unique) && !entity.isVisited() || entity.getOnEnterCallback() != null)
				{
					this.Cursor.setCursor(this.Const.UI.Cursor.Enter);
				}
				else
				{
					this.Cursor.setCursor(this.Const.UI.Cursor.Hand);
				}

				return;
			}
		}

		if (this.m.LastEntityHovered != null)
		{
			this.m.LastEntityHovered = null;
			this.Tooltip.mouseLeaveTile();
		}

		local tile = this.World.getTile(this.World.screenToTile(cursorX, cursorY));

		if (tile != null && !this.isInCameraMovementMode())
		{
			this.m.LastEntityHovered = null;

			if (this.m.LastTileHovered == null || !this.m.LastTileHovered.isSameTileAs(tile))
			{
				this.m.LastTileHovered = tile;
				this.Tooltip.mouseLeaveTile();
				this.Tooltip.mouseEnterTile(cursorX, cursorY);
			}
			else
			{
				this.Tooltip.mouseHoverTile(cursorX, cursorY);
			}

			this.Cursor.setCursor(this.Const.UI.Cursor.Boot);
		}
	}

	function updateCamera( _mouseEvent )
	{
		if (this.m.UseDragStyleScrolling == true)
		{
			if (!this.Cursor.isOverUI())
			{
				switch(_mouseEvent.getState())
				{
				case 0:
					if ((this.m.IsInCameraMovementMode == null || this.m.IsInCameraMovementMode == false) && _mouseEvent.getID() == 1)
					{
						this.m.IsInCameraMovementMode = true;
						this.m.WasInCameraMovementMode = false;
						this.m.MouseDownPosition = {
							X = _mouseEvent.getX(),
							Y = _mouseEvent.getY()
						};
					}

					break;

				case 2:
					if (this.m.IsInCameraMovementMode != null && this.m.IsInCameraMovementMode == true && _mouseEvent.getID() == 6)
					{
						local xOffset = this.Math.abs(this.m.MouseDownPosition.X - _mouseEvent.getX());
						local yOffset = this.Math.abs(this.m.MouseDownPosition.Y - _mouseEvent.getY());

						if (xOffset > 0 || yOffset > 0)
						{
							if (this.m.WasInCameraMovementMode == false && xOffset <= this.Const.Camera.MouseMoveThreshold && yOffset <= this.Const.Camera.MouseMoveThreshold)
							{
								return;
							}

							if (this.Settings.getTempGameplaySettings().CameraLocked)
							{
								this.m.WorldScreen.getTopbarOptionsModule().onCameraLockButtonPressed();
							}

							local camera = this.World.getCamera();
							local newX = (this.m.MouseDownPosition.X - _mouseEvent.getX()) * camera.Zoom;
							local newY = -((this.m.MouseDownPosition.Y - _mouseEvent.getY()) * camera.Zoom);
							this.m.MouseDownPosition.X = _mouseEvent.getX();
							this.m.MouseDownPosition.Y = _mouseEvent.getY();
							this.m.WasInCameraMovementMode = true;
							camera.move(newX, newY);

							if (this.m.CursorBeforeCameraMovement == null)
							{
								this.m.CursorBeforeCameraMovement = this.Cursor.getCurrentCursor();
								this.Cursor.setHardwareCursor(false, true);
							}

							this.Cursor.setCursor(this.Const.UI.Cursor.Scroll);
						}
					}

					break;

				case 1:
					if (_mouseEvent.getID() == 1)
					{
						this.resetCameraState();
					}

					break;
				}
			}
			else
			{
				this.resetCameraState();
			}
		}
		else
		{
			this.m.ScrollDirectionX = 0;
			this.m.ScrollDirectionY = 0;

			if (this.Cursor.isOverUI())
			{
				return;
			}

			local currentVideoMode = this.Settings.getVideoMode();
			local distLeft = _mouseEvent.getX();
			local distTop = _mouseEvent.getY();
			local distRight = this.Math.abs(currentVideoMode.Width - _mouseEvent.getX());
			local distBottom = this.Math.abs(currentVideoMode.Height - _mouseEvent.getY());

			if (distLeft < this.Const.Camera.MouseScrollThreshold)
			{
				this.m.ScrollDirectionX = -(this.Const.Camera.MouseScrollThreshold - distLeft);
			}
			else if (distRight < this.Const.Camera.MouseScrollThreshold)
			{
				this.m.ScrollDirectionX = this.Const.Camera.MouseScrollThreshold - distRight;
			}

			if (distTop < this.Const.Camera.MouseScrollThreshold)
			{
				this.m.ScrollDirectionY = this.Const.Camera.MouseScrollThreshold - distTop;
			}
			else if (distBottom < this.Const.Camera.MouseScrollThreshold)
			{
				this.m.ScrollDirectionY = -(this.Const.Camera.MouseScrollThreshold - distBottom);
			}

			local camera = this.World.getCamera();
			this.m.ScrollDirectionX = this.m.ScrollDirectionX * this.Const.Camera.MouseScrollFactor * camera.Zoom;
			this.m.ScrollDirectionY = this.m.ScrollDirectionY * this.Const.Camera.MouseScrollFactor * camera.Zoom;
		}
	}

	function updateCameraScrolling()
	{
		if (this.m.UseDragStyleScrolling == true || (this.m.ScrollDirectionX == null || this.m.ScrollDirectionY == null) || this.m.ScrollDirectionX == 0 && this.m.ScrollDirectionY == 0)
		{
			return;
		}

		local camera = this.World.getCamera();
		local delta = this.Time.getDelta();
		camera.move(this.m.ScrollDirectionX * delta, this.m.ScrollDirectionY * delta);
	}

	function resetCameraState()
	{
		if (this.m.IsInCameraMovementMode != null && this.m.IsInCameraMovementMode == true)
		{
			this.m.IsInCameraMovementMode = null;
			this.m.MouseDownPosition = null;
			this.Cursor.setHardwareCursor(true);

			if (this.m.CursorBeforeCameraMovement != null)
			{
				this.Cursor.setCursor(this.m.CursorBeforeCameraMovement);
				this.m.CursorBeforeCameraMovement = null;
			}

			this.m.LastTileHovered = null;
			this.updateCursorAndTooltip();
		}
	}

	function helper_handleDeveloperKeyInput( _key )
	{
		if (_key.getState() != 0)
		{
			return false;
		}

		if (this.m.MenuStack.hasBacksteps())
		{
			return false;
		}

		switch(_key.getKey())
		{
		case 3:
			if (!this.m.IsDeveloperModeEnabled)
			{
				break;
			}

			if (this.getCurrentTown() != null)
			{
				break;
			}

			this.World.setSpeedMult(3.0);
			this.logDebug("World Speed set to x3.0");
			return true;

		case 4:
			if (!this.m.IsDeveloperModeEnabled)
			{
				break;
			}

			if (this.getCurrentTown() != null)
			{
				break;
			}

			this.World.setSpeedMult(4.0);
			this.logDebug("World Speed set to x4.0");
			return true;

		case 5:
			if (!this.m.IsDeveloperModeEnabled)
			{
				break;
			}

			if (this.getCurrentTown() != null)
			{
				break;
			}

			this.World.setSpeedMult(5.0);
			this.logDebug("World Speed set to x5.0");
			return true;

		case 6:
			if (!this.m.IsDeveloperModeEnabled)
			{
				break;
			}

			if (this.getCurrentTown() != null)
			{
				break;
			}

			this.World.setSpeedMult(6.0);
			this.logDebug("World Speed set to x6.0");
			return true;

		case 7:
			if (!this.m.IsDeveloperModeEnabled)
			{
				break;
			}

			if (this.getCurrentTown() != null)
			{
				break;
			}

			this.World.setSpeedMult(7.0);
			this.logDebug("World Speed set to x7.0");
			return true;

		case 8:
			if (!this.m.IsDeveloperModeEnabled)
			{
				break;
			}

			if (this.getCurrentTown() != null)
			{
				break;
			}

			this.World.setSpeedMult(8.0);
			this.logDebug("World Speed set to x8.0");
			return true;

		case 9:
			if (!this.m.IsDeveloperModeEnabled)
			{
				break;
			}

			if (this.getCurrentTown() != null)
			{
				break;
			}

			this.World.setSpeedMult(9.0);
			this.logDebug("World Speed set to x9.0");
			return true;

		case 11:
			if (!this.m.IsDeveloperModeEnabled)
			{
				break;
			}

			this.m.Player.setAttackable(!this.m.Player.isAttackable());

			if (this.m.Player.isAttackable())
			{
				this.logDebug("Player can now be attacked.");
			}
			else
			{
				this.logDebug("Player can NOT be attacked.");
			}

			return true;

		case 18:
			if (!this.m.IsDeveloperModeEnabled)
			{
				break;
			}

			this.World.Assets.setConsumingAssets(!this.World.Assets.isConsumingAssets());

			if (this.World.Assets.isConsumingAssets())
			{
				this.logDebug("Player is consuming assets.");
			}
			else
			{
				this.logDebug("Player is NOT consuming assets.");
			}

			return true;

		case 16:
			if (!this.m.IsDeveloperModeEnabled)
			{
				break;
			}

			this.World.setFogOfWar(!this.World.isUsingFogOfWar());

			if (this.World.isUsingFogOfWar())
			{
				this.logDebug("Fog Of War activated.");
			}
			else
			{
				this.logDebug("Fog Of War deactivated.");
			}

			return true;

		case 17:
			if (!this.m.IsDeveloperModeEnabled)
			{
				break;
			}

			if (this.m.LastTileHovered == null)
			{
				break;
			}

			this.logInfo("distance: " + this.m.LastTileHovered.getDistanceTo(this.getPlayer().getTile()));
			this.logInfo("y: " + this.m.LastTileHovered.SquareCoords.Y);
			this.logInfo("type: " + this.m.LastTileHovered.Type);
			return true;

		case 21:
			if (!this.m.IsDeveloperModeEnabled)
			{
				break;
			}

			if (this.m.LastEntityHovered != null && this.m.LastEntityHovered.isLocation())
			{
				local e = this.m.LastEntityHovered;
				e.setActive(false);
				e.getTile().spawnDetail(e.m.Sprite + "_ruins", this.Const.World.ZLevel.Object - 3, 0);
				e.die();
				return true;
			}

			break;

		case 22:
			if (!this.m.IsDeveloperModeEnabled)
			{
				break;
			}

			if (this.m.LastEntityHovered != null && this.m.LastEntityHovered.isLocation())
			{
				local e = this.m.LastEntityHovered;
				local tile = e.getTile();
				local name = e.getName();
				local sprite = e.m.Sprite;
				e.setActive(false);
				e.getTile().spawnDetail(e.m.Sprite + "_ruins", this.Const.World.ZLevel.Object - 3, 0, false);
				e.fadeOutAndDie();
				return true;
			}

			break;

		case 25:
			// if (!this.m.IsDeveloperModeEnabled)
			// {
			// 	break;
			// }

			if (this.m.LastTileHovered != null)
			{
				local faction = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Bandits);
				local party = faction.spawnEntity(this.m.LastTileHovered, "TEST GROUP", false, this.Const.World.Spawn.BanditRoamers, 200);
				party.getSprite("banner").setBrush("banner_orcs_04");
				party.setDescription("A band of menacing orcs, greenskinned and towering any man.");
				local c = party.getController();
				local ambush = this.new("scripts/ai/world/orders/ambush_order");
				c.addOrder(ambush);
				return true;
			}

			break;

		case 23:
			if (!this.m.IsDeveloperModeEnabled)
			{
				break;
			}

			this.World.Assets.addMoney(10000);
			this.updateTopbarAssets();
			break;

		case 24:
			if (!this.m.IsDeveloperModeEnabled)
			{
				break;
			}

			local playerRoster = this.World.getPlayerRoster().getAll();

			foreach( bro in playerRoster )
			{
				bro.addXP(1000, false);
				bro.updateLevel();
			}

			break;

		case 27:
			if (!this.m.IsDeveloperModeEnabled)
			{
				break;
			}

			this.World.Assets.addBusinessReputation(500);
			break;

		case 81:
			if (!this.m.IsDeveloperModeEnabled)
			{
			}
			else
			{
				if (this.Tooltip.getDelay() < 1000)
				{
					this.Tooltip.setDelay(900000);
				}
				else
				{
					this.Tooltip.setDelay(150);
				}

				break;
			}
		}

		return false;
	}

	function helper_handleContextualKeyInput( _key )
	{
		if (this.isInLoadingScreen())
		{
			return true;
		}

		if (this.m.IsDeveloperModeEnabled && this.helper_handleDeveloperKeyInput(_key))
		{
			return true;
		}

		if (this.isInDevScreen())
		{
			switch(_key.getKey())
			{
			case 41:
				this.m.WorldScreen.hideDevConsole();
				break;
			}

			return true;
		}

		if (this.isInCharacterScreen() && _key.getState() == 0)
		{
			switch(_key.getKey())
			{
			case 11:
			case 48:
				this.m.CharacterScreen.switchToPreviousBrother();
				break;

			case 38:
			case 14:
			case 50:
				this.m.CharacterScreen.switchToNextBrother();
				break;

			case 19:
			case 13:
			case 41:
				this.toggleCharacterScreen();
				break;


			case 29:
				this.m.CharacterScreen.toggleBrotherReserves();
				break;
			}

			return true;
		}

		if (this.m.CampfireScreen != null && this.m.CampfireScreen.isVisible() && _key.getState() == 0)
		{
			switch(_key.getKey())
			{
			case 41:
			case 26:
				this.m.CampfireScreen.onModuleClosed();
				break;
			}
		}
		else if (_key.getState() == 0)
		{
			switch(_key.getKey())
			{
			case 41:
				if (this.m.WorldMenuScreen.isAnimating())
				{
					return false;
				}

				if (this.toggleMenuScreen())
				{
					return true;
				}

				break;

			case 13:
			case 19:
				if (!this.m.MenuStack.hasBacksteps() || this.m.CharacterScreen.isVisible() || this.m.WorldTownScreen.isVisible() && !this.m.EventScreen.isVisible())
				{
					if (!this.m.EventScreen.isVisible() && !this.m.EventScreen.isAnimating())
					{
						this.toggleCharacterScreen();
					}

					return true;
				}

				break;

			case 28:
				if (!this.m.MenuStack.hasBacksteps() && !this.m.EventScreen.isVisible() && !this.m.EventScreen.isAnimating())
				{
					this.topbar_options_module_onRelationsButtonClicked();
				}
				else if (this.m.RelationsScreen.isVisible())
				{
					this.m.RelationsScreen.onClose();
				}

				break;

			case 25:
				if (!this.m.MenuStack.hasBacksteps() && !this.m.EventScreen.isVisible() && !this.m.EventScreen.isAnimating())
				{
					this.topbar_options_module_onObituaryButtonClicked();
				}
				else if (this.m.ObituaryScreen.isVisible())
				{
					this.m.ObituaryScreen.onClose();
				}

				break;

			case 30:
				if (!this.m.MenuStack.hasBacksteps())
				{
					this.showCampScreen();
					// if (this.isCampingAllowed())
					// {
					// 	this.onCamp();
					// }
				}

				break;

			case 32:
				if (!this.m.MenuStack.hasBacksteps())
				{
					this.m.WorldScreen.showDevConsole();
					return true;
				}
				break;

			case 26:
				if (!this.m.MenuStack.hasBacksteps() && !this.m.EventScreen.isVisible() && !this.m.EventScreen.isAnimating())
				{
					this.topbar_options_module_onPerksButtonClicked();
				}

				break;

			case 42:
			case 40:
			case 10:
				if (!this.m.MenuStack.hasBacksteps())
				{
					this.setPause(!this.isPaused());
					return true;
				}

				break;

			case 1:
				if (!this.m.MenuStack.hasBacksteps())
				{
					this.setNormalTime();
					break;
				}

			case 2:
				if (!this.m.MenuStack.hasBacksteps())
				{
					this.setFastTime();
					break;
				}

			case 16:
				if (!this.m.MenuStack.hasBacksteps())
				{
					this.m.WorldScreen.getTopbarOptionsModule().onTrackingButtonPressed();
					return true;
				}

				break;

			case 34:
				if (!this.m.MenuStack.hasBacksteps())
				{
					this.m.WorldScreen.getTopbarOptionsModule().onCameraLockButtonPressed();
				}

				break;

			case 75:
				if (!this.m.MenuStack.hasBacksteps() && !this.World.Assets.isIronman())
				{
					this.saveCampaign("quicksave");
				}

				break;

			case 79:
				if (!this.m.MenuStack.hasBacksteps() && !this.World.Assets.isIronman() && this.World.canLoad("quicksave"))
				{
					this.loadCampaign("quicksave");
				}

				break;

			case 14:
				if ((_key.getModifier() & 2) != 0 && this.m.IsAllowingDeveloperMode)
				{
					this.m.IsDeveloperModeEnabled = !this.m.IsDeveloperModeEnabled;

					if (this.m.IsDeveloperModeEnabled)
					{
						this.logDebug("*** DEVELOPER MODE ENABLED ***");
					}
					else
					{
						this.logDebug("*** DEVELOPER MODE DISABLED ***");
					}
				}

				break;

			case 1:
				if (!this.m.EventScreen.isVisible() || this.m.EventScreen.isAnimating())
				{
					break;
				}

				this.m.EventScreen.onButtonPressed(0);
				return true;

			case 2:
				if (!this.m.EventScreen.isVisible() || this.m.EventScreen.isAnimating())
				{
					break;
				}

				this.m.EventScreen.onButtonPressed(1);
				return true;

			case 3:
				if (!this.m.EventScreen.isVisible() || this.m.EventScreen.isAnimating())
				{
					break;
				}

				this.m.EventScreen.onButtonPressed(2);
				return true;

			case 4:
				if (!this.m.EventScreen.isVisible() || this.m.EventScreen.isAnimating())
				{
					break;
				}

				this.m.EventScreen.onButtonPressed(3);
				return true;

			case 95:
				this.m.IsForcingAttack = false;
				return true;
			}
		}

		if (_key.getState() == 1 && !this.m.MenuStack.hasBacksteps())
		{
			switch(_key.getKey())
			{
			case 11:
			case 27:
			case 48:
				if (_key.getModifier() != 2)
				{
					if (this.Settings.getTempGameplaySettings().CameraLocked)
					{
						this.m.WorldScreen.getTopbarOptionsModule().onCameraLockButtonPressed();
					}

					this.World.getCamera().move(-1500.0 * this.Time.getDelta() * this.Math.maxf(1.0, this.World.getCamera().Zoom * 0.66), 0);
					return true;
				}

				break;

			case 14:
			case 50:
				if (_key.getModifier() != 2)
				{
					if (this.Settings.getTempGameplaySettings().CameraLocked)
					{
						this.m.WorldScreen.getTopbarOptionsModule().onCameraLockButtonPressed();
					}

					this.World.getCamera().move(1500.0 * this.Time.getDelta() * this.Math.maxf(1.0, this.World.getCamera().Zoom * 0.66), 0);
					return true;
				}

				break;

			case 33:
			case 36:
			case 49:
				if (_key.getModifier() != 2)
				{
					if (this.Settings.getTempGameplaySettings().CameraLocked)
					{
						this.m.WorldScreen.getTopbarOptionsModule().onCameraLockButtonPressed();
					}

					this.World.getCamera().move(0, 1500.0 * this.Time.getDelta() * this.Math.maxf(1.0, this.World.getCamera().Zoom * 0.66));
					return true;
				}

				break;

			case 29:
			case 51:
				if (_key.getModifier() != 2)
				{
					if (this.Settings.getTempGameplaySettings().CameraLocked)
					{
						this.m.WorldScreen.getTopbarOptionsModule().onCameraLockButtonPressed();
					}

					this.World.getCamera().move(0, -1500.0 * this.Time.getDelta() * this.Math.maxf(1.0, this.World.getCamera().Zoom * 0.66));
					return true;
				}

				break;

			case 67:
			case 46:
				this.World.getCamera().zoomBy(-this.Time.getDelta() * this.Math.max(60, this.Time.getFPS()) * 0.15);
				break;

			case 68:
			case 47:
				this.World.getCamera().zoomBy(this.Time.getDelta() * this.Math.max(60, this.Time.getFPS()) * 0.15);
				break;

			case 96:
			case 39:
				this.World.getCamera().Zoom = 1.0;
				this.World.getCamera().setPos(this.World.State.getPlayer().getPos());
				break;

			case 95:
				if (this.m.MenuStack.hasBacksteps())
				{
				}
				else
				{
					this.m.IsForcingAttack = true;
					return true;
				}
			}
		}
	}

	function cancelCurrentAction()
	{
		return false;
	}

	function playEnemyDiscoveredSound()
	{
		if (this.m.LastEnemyDiscoveredSoundTime + 8.0 < this.Time.getRealTimeF())
		{
			this.m.LastEnemyDiscoveredSoundTime = this.Time.getRealTimeF();
			this.Sound.play(this.Const.Sound.EnemyDiscoveredOnWorldmap[this.Math.rand(0, this.Const.Sound.EnemyDiscoveredOnWorldmap.len() - 1)], this.Const.Sound.Volume.Inventory);
		}
	}

	function getRefFromID( _id )
	{
		if (_id == -1) return null;

		if (_id > this.m.IDToRef.len() - 1) return null;

		local val = this.m.IDToRef[_id];
		if (val == -1) {
			return null
		}
		return val;
	}

	function removeCompanyID( _id )
	{
		this.m.IDToRef[_id] = -1;
	}

	function addNewID( _actor ) //return the id we gave and also put wtr into id slot
	{
		for ( local i = 0; i < 27; i++ )
		{
			if (this.m.IDToRef[i] == -1)
			{
				this.m.IDToRef[i] = this.WeakTableRef(_actor);
				return i;
			}
		}
	}

	function setDistantVisionBonus( _bonus )
	{
		this.m.DistantVisionBonus = _bonus;
	}

	function getDistantVisionBonus()
	{
		return this.m.DistantVisionBonus;
	}

	function onBeforeSerialize( _out )
	{
		local meta = _out.getMetaData();
		meta.setVersion(this.Const.Serialization.Version);
		meta.setString("groupname", this.World.Assets.getName());
		meta.setString("banner", this.World.Assets.getBanner());
		meta.setInt("days", this.World.getTime().Days);
		meta.setInt("difficulty", this.World.Assets.getCombatDifficulty());
		meta.setInt("difficulty2", this.World.Assets.getEconomicDifficulty());
		meta.setInt("ironman", this.World.Assets.isIronman() ? 1 : 0);
		meta.setInt("dlc", this.Const.DLC.Mask);
		meta.setString("legendsVersion", ::Legends.Version);
	}

	function onBeforeDeserialize( _in )
	{
		this.m.AutoEnterLocation = null;
		this.m.AutoAttack = null;
		this.m.LastEnteredTown = null;
		this.m.LastPlayerTile = null;
		this.m.LastEntityHovered = null;
		this.m.LastTileHovered = null;
		this.m.LastWorldSpeedMult = 1.0;
		this.m.CustomZoom = 1.0;
		this.m.Player = null;
		this.m.CombatStartTime = 0;
		this.m.LastEnemyDiscoveredSoundTime = 0.0;
		this.m.IsTriggeringContractUpdatesOnce = true;
		this.m.IsForcingAttack = false;
		this.m.Regions = [];
		this.Time.clearEvents();
		this.World.Combat.clear();
		this.World.Events.clear();
		this.World.Ambitions.clear();
		this.World.Crafting.clear();
		this.World.Retinue.clear();
		this.World.EntityManager.clear();
		this.World.Contracts.clear();
		this.World.FactionManager.clear();
		this.World.Statistics.clear();
		this.World.Assets.clear();
		this.setEscortedEntity(null);
		this.logInfo("Save version: " + _in.getMetaData().getVersion());
		this.logInfo("Legends version in save: " + _in.getMetaData().getString("legendsVersion"));
		this.logInfo("Current Legends version: " + ::Legends.Version);
	}

	function onSerialize( _out )
	{
		_out.writeU16(this.m.Regions.len());

		foreach( r in this.m.Regions )
		{
			_out.writeString(r.Name);
			_out.writeU8(r.Type);
			_out.writeU16(r.Size);
			_out.writeI16(r.Center.Coords.X);
			_out.writeI16(r.Center.Coords.Y);
			_out.writeF32(r.Discovered);
		}

		this.World.Flags.onSerialize(_out);
		this.World.FactionManager.onSerialize(_out);
		this.World.EntityManager.onSerialize(_out);
		this.World.Assets.onSerialize(_out);
		this.World.Combat.onSerialize(_out);
		this.World.Contracts.onSerialize(_out);
		this.World.Events.onSerialize(_out);
		this.World.Ambitions.onSerialize(_out);
		this.World.Crafting.onSerialize(_out);
		this.World.Retinue.onSerialize(_out);
		this.World.Statistics.onSerialize(_out);
		_out.writeBool(this.m.IsCampingAllowed);
		_out.writeI32(this.m.CombatSeed);
		this.World.Camp.onSerialize(_out);

	}

	function onDeserialize( _in )
	{
		this.World.State.m.AppropriateTimeToRecalc = 0;	//Leonion's fix
		this.Sound.stopAmbience();
		this.m.Player = this.World.getPlayerEntity();

		if (_in.getMetaData().getVersion() >= 34)
		{
			local numRegions = _in.readU16();

			for( local i = 0; i < numRegions; i = ++i )
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
		this.World.State.m.AppropriateTimeToRecalc = 1;	//Leonion's fix
		this.World.State.getPlayer().calculateModifiers(); //Leonion's fix

		handleEscapeArtistRetirement(_in);
		
	}

	function handleEscapeArtistRetirement(_in)
	{
		// Gracefully retire Escape Artist Perk for players (merged into Net Mastery) in 18.2.0
		// Attempting to handle this in the deserialization of player.nut causes the game to crash
		// During the deserialization of player.nut, the game doesn't like calling player.getSkills().hasSkill("perk.legend_escape_artist") for some reason

		// moved separately because it makes hooking #onDeserialize very awkward in submods
		if (!::Legends.Mod.Serialization.isSavedVersionAtLeast("18.2.0", _in.getMetaData()))
		{
			foreach (player in ::World.getPlayerRoster().getAll())
			{
				local hasEscape = false;
				if (player.getSkills().hasSkill("perk.legend_escape_artist"))
				{
					hasEscape = true;
					::MSU.Log.printData("Removing Escape Artist from " + player.getName());
					player.m.PerkPoints++;
					player.m.PerkPointsSpent--;
					player.getSkills().removeByID("perk.legend_escape_artist");
					player.getBackground().removePerk(::Const.Perks.PerkDefs.LegendEscapeArtist);
				}

				// Beast Slayers origin used to grant Escape Artist and has been changed, so we need to call its onBuildPerkTree again
				local origin = ::World.Assets.getOrigin();
				if(origin != null && origin.getID()=="scenario.beast_hunters" && hasEscape)
				{
					::MSU.Log.printData("Rolling new Beast Slayers scenario perk for " + player.getName());
					origin.onBuildPerkTree(player.getBackground());
					player.m.PerkPoints--;
					player.m.PerkPointsSpent++;
				}
			}
		}
	}
});
