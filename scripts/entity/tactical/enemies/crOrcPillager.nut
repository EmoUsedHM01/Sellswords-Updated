this.crOrcPillager <- this.inherit("scripts/entity/tactical/actor", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.crOrcPillager;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.crOrcPillager.XP;
		this.m.BloodSplatterOffset = this.createVec(0, 0);
		this.m.DecapitateSplatterOffset = this.createVec(20, -20);
		this.m.DecapitateBloodAmount = 3.0;
		this.m.ConfidentMoraleBrush = "icon_confident_orcs";
		this.actor.create();
		this.m.Sound[this.Const.Sound.ActorEvent.Death] = [
			"sounds/enemies/orc_death_01.wav",
			"sounds/enemies/orc_death_02.wav",
			"sounds/enemies/orc_death_03.wav",
			"sounds/enemies/orc_death_04.wav",
			"sounds/enemies/orc_death_05.wav",
			"sounds/enemies/orc_death_06.wav",
			"sounds/enemies/orc_death_07.wav",
			"sounds/enemies/orc_death_08.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Flee] = [
			"sounds/enemies/orc_flee_01.wav",
			"sounds/enemies/orc_flee_02.wav",
			"sounds/enemies/orc_flee_03.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.DamageReceived] = [
			"sounds/enemies/orc_hurt_01.wav",
			"sounds/enemies/orc_hurt_02.wav",
			"sounds/enemies/orc_hurt_03.wav",
			"sounds/enemies/orc_hurt_04.wav",
			"sounds/enemies/orc_hurt_05.wav",
			"sounds/enemies/orc_hurt_06.wav",
			"sounds/enemies/orc_hurt_07.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Idle] = [
			"sounds/enemies/orc_idle_01.wav",
			"sounds/enemies/orc_idle_02.wav",
			"sounds/enemies/orc_idle_03.wav",
			"sounds/enemies/orc_idle_04.wav",
			"sounds/enemies/orc_idle_05.wav",
			"sounds/enemies/orc_idle_06.wav",
			"sounds/enemies/orc_idle_07.wav",
			"sounds/enemies/orc_idle_08.wav",
			"sounds/enemies/orc_idle_09.wav",
			"sounds/enemies/orc_idle_10.wav",
			"sounds/enemies/orc_idle_11.wav",
			"sounds/enemies/orc_idle_12.wav",
			"sounds/enemies/orc_idle_13.wav",
			"sounds/enemies/orc_idle_14.wav",
			"sounds/enemies/orc_idle_15.wav",
			"sounds/enemies/orc_idle_16.wav",
			"sounds/enemies/orc_idle_17.wav",
			"sounds/enemies/orc_idle_18.wav",
			"sounds/enemies/orc_idle_19.wav",
			"sounds/enemies/orc_idle_20.wav",
			"sounds/enemies/orc_idle_21.wav",
			"sounds/enemies/orc_idle_22.wav",
			"sounds/enemies/orc_idle_23.wav",
			"sounds/enemies/orc_idle_24.wav",
			"sounds/enemies/orc_idle_25.wav",
			"sounds/enemies/orc_idle_26.wav",
			"sounds/enemies/orc_idle_27.wav",
			"sounds/enemies/orc_idle_28.wav",
			"sounds/enemies/orc_idle_29.wav",
			"sounds/enemies/orc_fatigue_01.wav",
			"sounds/enemies/orc_fatigue_02.wav",
			"sounds/enemies/orc_fatigue_03.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Move] = [
			"sounds/enemies/orc_fatigue_01.wav",
			"sounds/enemies/orc_fatigue_02.wav",
			"sounds/enemies/orc_fatigue_03.wav"
		];
		this.m.SoundPitch = 0.9;
		this.m.SoundVolume[this.Const.Sound.ActorEvent.Idle] = 1.25;
		this.m.SoundVolume[this.Const.Sound.ActorEvent.DamageReceived] = 1.0;
		this.m.SoundVolume[this.Const.Sound.ActorEvent.Move] = 0.75;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/orc_warrior_agent");
		this.m.AIAgent.setActor(this);
	}

	function playSound( _type, _volume, _pitch = 1.0 )
	{
		if (_type == this.Const.Sound.ActorEvent.Move && this.Math.rand(1, 100) <= 50)
		{
			return;
		}

		this.actor.playSound(_type, _volume, _pitch);
	}

	function onDeath(_killer, _skill, _tile, _fatalityType)
	{
		local flip = this.Math.rand(1, 100) < 50;

		if (_tile != null)
		{
			this.m.IsCorpseFlipped = flip;
			this.spawnBloodPool(_tile, 1);
			local decal;
			local appearance = this.getItems().getAppearance();
			local sprite_body = this.getSprite("body");
			local sprite_head = this.getSprite("head");
			decal = _tile.spawnDetail(sprite_body.getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip);
			decal.Color = sprite_body.Color;
			decal.Saturation = sprite_body.Saturation;
			decal.Scale = 0.9;
			decal.setBrightness(0.9);

			if (appearance.CorpseArmor != "")
			{
				decal = _tile.spawnDetail(appearance.CorpseArmor, this.Const.Tactical.DetailFlag.Corpse, flip);
				decal.Scale = 0.9;
				decal.setBrightness(0.9);
			}

			if (_fatalityType != this.Const.FatalityType.Decapitated)
			{
				if (!appearance.HideCorpseHead)
				{
					decal = _tile.spawnDetail(sprite_head.getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip);
					decal.Color = sprite_head.Color;
					decal.Saturation = sprite_head.Saturation;
					decal.Scale = 0.9;
					decal.setBrightness(0.9);
				}

				if (appearance.HelmetCorpse != "")
				{
					decal = _tile.spawnDetail(appearance.HelmetCorpse, this.Const.Tactical.DetailFlag.Corpse, flip);
					decal.Scale = 0.9;
					decal.setBrightness(0.9);
				}
			}
			else if (_fatalityType == this.Const.FatalityType.Decapitated)
			{
				local layers = [];

				if (!appearance.HideCorpseHead)
				{
					layers.push(sprite_head.getBrush().Name + "_dead");
				}

				if (appearance.HelmetCorpse.len() != 0)
				{
					layers.push(appearance.HelmetCorpse);
				}

				local decap = this.Tactical.spawnHeadEffect(this.getTile(), layers, this.createVec(-50, 30), 180.0, "bust_orc_03_head_dead_bloodpool");
				local idx = 0;

				if (!appearance.HideCorpseHead)
				{
					decap[idx].Color = sprite_head.Color;
					decap[idx].Saturation = sprite_head.Saturation;
					decap[idx].Scale = 0.9;
					decap[idx].setBrightness(0.9);
					idx = ++idx;
				}

				if (appearance.HelmetCorpse.len() != 0)
				{
					decap[idx].Scale = 0.9;
					decap[idx].setBrightness(0.9);
					idx = ++idx;
				}
			}

			if (_fatalityType == this.Const.FatalityType.Disemboweled)
			{
				decal = _tile.spawnDetail(appearance.CorpseArmor + "_guts", this.Const.Tactical.DetailFlag.Corpse, flip);
				decal.Scale = 0.9;
			}
			else if (_skill && _skill.getProjectileType() == this.Const.ProjectileType.Arrow)
			{
				decal = _tile.spawnDetail(appearance.CorpseArmor + "_arrows", this.Const.Tactical.DetailFlag.Corpse, flip);
				decal.Scale = 0.9;
			}
			else if (_skill && _skill.getProjectileType() == this.Const.ProjectileType.Javelin)
			{
				decal = _tile.spawnDetail(appearance.CorpseArmor + "_javelin", this.Const.Tactical.DetailFlag.Corpse, flip);
				decal.Scale = 0.9;
			}

			this.spawnTerrainDropdownEffect(_tile);
			local corpse = clone this.Const.Corpse;
			corpse.CorpseName = "An Orc Warrior";
			corpse.Tile = _tile;
			corpse.IsResurrectable = false;
			corpse.IsConsumable = true;
			corpse.Items = this.getItems();
			corpse.IsHeadAttached = _fatalityType != this.Const.FatalityType.Decapitated;
			_tile.Properties.set("Corpse", corpse);
			this.Tactical.Entities.addCorpse(_tile);
		}

		this.getItems().dropAll(_tile, _killer, flip);
		this.actor.onDeath(_killer, _skill, _tile, _fatalityType);

		local chance = 1.25;
		local item = "scripts/items/misc/anatomist/orc_sequence_item";
		::Mod_Sellswords.doPotionDrop(_killer, _skill, _tile, _fatalityType, chance, item);
	}

	function onFactionChanged()
	{
		this.actor.onFactionChanged();
		local flip = !this.isAlliedWithPlayer()

		foreach (a in this.Const.CharacterSprites.Helmets)
		{
			if (!this.hasSprite(a))
			{
				continue;
			}
			this.getSprite(a).setHorizontalFlipping(flip);
		}
	}

	function onInit()
	{
		this.actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.crOrcPillager);

		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 160)
		{
			b.MeleeSkill += 5;
			b.DamageTotalMult += 0.1;
		}

		this.m.BaseProperties.DamageTotalMult -= 0.1;
		b.IsSpecializedInAxes = true;
		b.IsSpecializedInCleavers = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		this.m.Items.getAppearance().Body = "bust_orc_03_body";
		this.addSprite("socket").setBrush("bust_base_orcs");
		local body = this.addSprite("body");
		body.setBrush("bust_orc_03_body");
		body.varyColor(0.3, 0.3, 0.3);
		local injury_body = this.addSprite("injury_body");
		injury_body.Visible = false;
		injury_body.setBrush("bust_orc_03_body_injured");
		this.addSprite("armor");
		local head = this.addSprite("head");
		head.setBrush("bust_orc_03_head_0" + this.Math.rand(1, 3));
		head.Saturation = body.Saturation;
		head.Color = body.Color;
		local injury = this.addSprite("injury");
		injury.Visible = false;
		injury.setBrush("bust_orc_03_head_injured");
		local v = 1;
		local v2 = -6;
		foreach (a in this.Const.CharacterSprites.Helmets)
		{
			this.addSprite(a)
			this.setSpriteOffset(a, this.createVec(v2, v));
		}

		local body_blood = this.addSprite("body_blood");
		body_blood.setBrush("bust_orc_03_body_bloodied");
		body_blood.Visible = false;
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.6;
		this.setSpriteOffset("status_rooted", this.createVec(0, 5));
		this.m.Skills.add(this.new("scripts/skills/special/double_grip"));
		this.m.Skills.add(this.new("scripts/skills/actives/hand_to_hand_orc"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_battering_ram"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_stalwart"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_hold_out"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_killing_frenzy"));			
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fearsome"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_flow"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));

		if (::Is_PTR_Exist)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_menacing"));
			this.m.Skills.add(this.new("scripts/skills/racial/ptr_orc_racial"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_survival_instinct"));	
		}		

		if("Assets" in this.World && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{		
			this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));	
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_onslaught"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_overwhelm"));				
			this.m.Skills.add(this.new("scripts/skills/perks/perk_colossus"));			
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));

			if (::Is_PTR_Exist)
			{
				this.m.Skills.add(this.new("scripts/skills/effects/ptr_fresh_and_furious_effect"));	
				//this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_vigorous_assault"));	
			}
		}	

		if (this.Const.DLC.Unhold)
		{
			this.m.Skills.add(this.new("scripts/skills/actives/wake_ally_skill"));
		}

		this.m.Skills.add(this.new("scripts/skills/effects/captain_effect"));		
		
		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 60)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_true_believer"));
			if (this.World.getTime().Days >= 100)
			{
				if (::Is_PTR_Exist)
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_unstoppable"));	
				}
				
				this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));				
				if (this.World.getTime().Days >= 150)
				{
					if (::Is_PTR_Exist)
					{
						this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_exude_confidence"));
						this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_wears_it_well"));		
					}
		
					b.MeleeDefense += 5;				

					if (this.World.getTime().Days >= 200)
					{				
						this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_second_wind"));						
						this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_assured_conquest"));
						b.MeleeSkill += 5;									
					}
				}
			}
		}		
		
		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getEconomicDifficulty() == this.Const.Difficulty.Legendary)
		{
			local dc = this.World.getTime().Days;
			local dca = this.Math.floor(dc/50) + this.Math.floor(dc/100) + this.Math.floor(dc/150) + this.Math.floor(dc/200);
			dca = this.Math.min(dca, 8 + this.Math.floor(dc/100));				
			this.m.BaseProperties.MeleeSkill += dca;
			this.m.BaseProperties.MeleeDefense += 0.5 * dca;
			this.m.BaseProperties.RangedSkill += dca;	
			this.m.BaseProperties.RangedDefense += 0.5 * dca;				
			this.m.BaseProperties.Bravery += dca;
			this.m.BaseProperties.Hitpoints += 2 * dca;	
		}			
		
	}

	function onFinish()
	{
		this.actor.onFinish();
	}

	function assignRandomEquipment()
	{
		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand) == null)
		{
			local weapons = [
				"weapons/greenskins/orc_axe",
				"weapons/greenskins/legend_skin_flayer",
				"weapons/greenskins/orc_cleaver",
				"weapons/greenskins/orc_axe_2h",
				"weapons/greenskins/legend_man_mangler",
				"weapons/greenskins/legend_limb_lopper",
				"weapons/greenskins/legend_meat_hacker",				
			];
			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}

		local helmet;
		helmet = [
			[6, ""],
			[3, "greenskins/orc_warrior_light_helmet"],
			[1, "greenskins/orc_warrior_medium_helmet"]		
		];
		if (this.World.getTime().Days >= 80)
		{
			helmet = [
				[2, ""],
				[2, "greenskins/orc_warrior_light_helmet"],
				[1, "greenskins/orc_warrior_medium_helmet"]	
			];
		}
		if (this.World.getTime().Days >= 160)
		{
			helmet = [			
				[2, "greenskins/orc_warrior_light_helmet"],
				[1, "greenskins/orc_warrior_medium_helmet"]
			];
		}
		if (this.World.getTime().Days >= 240)
		{
			helmet = [
				[1, "greenskins/orc_warrior_light_helmet"],
				[1, "greenskins/orc_warrior_medium_helmet"]
			];
		}			

		this.m.Items.equip(this.Const.World.Common.pickHelmet(helmet));	
		
		local armor;
		armor = [
				[4, "greenskins/orc_warrior_light_armor"],
				[1, "greenskins/orc_warrior_medium_armor"]		
		];
		if (this.World.getTime().Days >= 80)
		{
			armor = [
				[2, "greenskins/orc_warrior_light_armor"],
				[1, "greenskins/orc_warrior_medium_armor"]
			];
		}
		if (this.World.getTime().Days >= 160)
		{
			armor = [
				[1, "greenskins/orc_warrior_light_armor"],
				[1, "greenskins/orc_warrior_medium_armor"]
			];
		}
		if (this.World.getTime().Days >= 240)
		{
			armor = [
				[1, "greenskins/orc_warrior_light_armor"],
				[2, "greenskins/orc_warrior_medium_armor"]
			];
		}				

		this.m.Items.equip(this.Const.World.Common.pickArmor(armor));

		if (::Is_PTR_Exist)
		{
			//this.m.Skills.addTreeOfEquippedWeapon(6);	
			this.m.Skills.removeByID("perk.ptr_kata");
		}

		::Mod_Sellswords.HookHelper.addTreeOfEquippedWeapon(this, 6);

		local weapon = this.getMainhandItem();
		if (::Is_PTR_Exist && weapon != null)
		{
			if(weapon.isItemType(this.Const.Items.ItemType.TwoHanded))
			{
				this.m.Skills.addPerkTree(this.Const.Perks.TwoHandedTree);
			}

			if (weapon.isItemType(this.Const.Items.ItemType.OneHanded))
			{
				this.m.Skills.addPerkTree(this.Const.Perks.OneHandedTree);				
			}
		}		
	}
	
	function makeMiniboss()
	{
		if (!this.actor.makeMiniboss())
		{
			return false;
		}
		this.getSprite("miniboss").setBrush("bust_miniboss");		
		
		local weapons = [
			"weapons/named/named_orc_cleaver",
			"weapons/named/named_orc_axe_2h",
			"weapons/named/named_orc_flail_2h",
			"weapons/named/named_orc_axe"
		];			
		this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));		
		this.m.Skills.add(this.new("scripts/skills/effects/dodge_effect"));		

		if (::Is_PTR_Exist)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_the_rush_of_battle"));
		}

		return true;
	}	

});

