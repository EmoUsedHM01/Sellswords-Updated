this.cr_swordsambiton_event_7 <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.cr_swordsambiton_7";
		this.m.Title = "Along the way...";
		this.m.Cooldown = 25.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_86.png[/img]Broken walls and jagged stumps are everywhere, the ground is covered with bloodstained weapons and mutilated bodies that vanishing in the far distance.\nExperience tells you that a group of men ambushed and attacked another force, and from the fallen banners and insignia the attacked force was not large in number, or even very small in comparison, but surprisingly they seemed to be very resilient and caused a lot of trouble and damage to the other side. You don't know if it was because of their bravery or well trained coordination, or both, that made them fight so hard, but unfortunately, they were outnumbered, and seemed to be fighting and retreating...",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Let\'s follow these footprints.",
					function getResult( _event )
					{
						return "Attack";
					}

				},
				{
					Text = "This doesn\'t concern us.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "Attack",
			Text = "[img]gfx/ui/events/event_165.png[/img]You follow the gradually weakening signs of battle sites and fading trail cautiously, it does not take much time to reach the end.\nApparently the attacker's side of the force has completely surrounded the attacked force, only to see that although just one person fighting alone, the weapon in his hand is exceptionally sharp, wielding like dragon flying or snake dancing, as if the weapon has a soul or mind of its own. However like an arrow at the end of its flight, under the frenzied and vigorous attack more and more mistake happens, interspersed with occasional vicious tricks - and probably unable to ward off any more, finally his defense is completely crushed, immediately followed by the death.\n\nWho by his mien seemed the leader of the party brandishes the trophy taken from the hands of the dead, a subtle and unparalleled sword, which is exactly what you are looking for. Just as you are about to give orders when the opposite side also found you with greedy and bloodthirsty, indicate that a fierce fight is inevitable.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Charge!",
					function getResult( _event )
					{
						local properties = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						properties.CombatID = "SwordsAmbitionCombat";
						properties.Music = this.Const.Music.OrientalBanditTracks;
						properties.IsAutoAssigningBases = false;
						properties.Entities = [];
						//properties.TemporaryEnemies = [
						//	_event.m.NobleHouse.getID()
						//];
						this.Const.World.Common.addUnitsToCombat(properties.Entities, this.Const.World.Spawn.SAEassasins, 125 * _event.getReputationToDifficultyLightMult(), this.Const.Faction.Enemy);				
						properties.Loot = [
							"scripts/items/weapons/special/named_sword_abt_mystletainn"
						];
						this.World.State.startScriptedCombat(properties, false, false, true);
						return 0;
					}					
				}				
			],
			function start( _event )
			{
			}						
		});
	}

	function onUpdateScore()
	{
		local currentTile = this.World.State.getPlayer().getTile();	
	
		if (!this.World.Flags.get("SwordAmbitionCount"))
		{
			return;
		}	
		
		if (this.World.Flags.get("SwordAmbition_mystletainn"))
		{
			return;
		}

		if (currentTile.SquareCoords.Y > this.World.getMapSize().Y * 0.3)
		{
			return;
		}		
		
		if (!this.World.Assets.getStash().hasEmptySlot())
		{
			return;
		}
		
		if (!currentTile.HasRoad)
		{
			return;
		}		
		
		local condition = 0;		
		local brothers = this.World.getPlayerRoster().getAll();
		foreach( bro in brothers )
		{
			if (bro.getSkills().hasSkillOfType(this.Const.SkillType.TemporaryInjury))
			{
				condition += 10;
			}
			if (bro.getItems().getItemAtSlot(this.Const.ItemSlot.Body).getCondition() < bro.getItems().getItemAtSlot(this.Const.ItemSlot.Body).getConditionMax() / 2)
			{
				condition += 5;
			}			
		}		

		this.m.Score = this.Math.max(3, 100 - condition);
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
	}

	function onClear()
	{
	}

});

