this.crOrcGrunt <- this.inherit("scripts/entity/tactical/actor", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.crOrcGrunt;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.crOrcGrunt.XP;
		this.m.BloodSplatterOffset = this.createVec(0, 0);
		this.m.DecapitateSplatterOffset = this.createVec(25, -25);
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
		this.m.SoundPitch = 1.0;
		this.m.SoundVolume[this.Const.Sound.ActorEvent.Death] = 0.9;
		this.m.SoundVolume[this.Const.Sound.ActorEvent.DamageReceived] = 0.9;
		this.m.SoundVolume[this.Const.Sound.ActorEvent.Idle] = 1.25;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/orc_young_agent");
		this.m.AIAgent.setActor(this);
	}

	function onDeath( _killer, _skill, _tile, _fatalityType )
	{
		local flip = this.Math.rand(1, 100) < 50;

		if (_tile != null)
		{
			this.m.IsCorpseFlipped = flip;
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

				local decap = this.Tactical.spawnHeadEffect(this.getTile(), layers, this.createVec(-50, 30), 180.0, "bust_orc_01_head_dead_bloodpool");
				local idx = 0;

				if (!appearance.HideCorpseHead)
				{
					decap[idx].Color = sprite_head.Color;
					decap[idx].Saturation = sprite_head.Saturation;
					decap[idx].Scale = 0.9;
					decap[idx].setBrightness(0.9);
					idx = ++idx;
					idx = idx;
				}

				if (appearance.HelmetCorpse.len() != 0)
				{
					decap[idx].Scale = 0.9;
					decap[idx].setBrightness(0.9);
					idx = ++idx;
					idx = idx;
				}
			}

			if (_fatalityType == this.Const.FatalityType.Disemboweled)
			{
				if (appearance.CorpseArmor != "")
				{
					decal = _tile.spawnDetail(appearance.CorpseArmor + "_guts", this.Const.Tactical.DetailFlag.Corpse, flip);
				}
				else
				{
					decal = _tile.spawnDetail("bust_orc_01_body_dead_guts", this.Const.Tactical.DetailFlag.Corpse, flip);
				}

				decal.Scale = 0.9;
			}
			else if (_skill && _skill.getProjectileType() == this.Const.ProjectileType.Arrow)
			{
				if (appearance.CorpseArmor != "")
				{
					decal = _tile.spawnDetail(appearance.CorpseArmor + "_arrows", this.Const.Tactical.DetailFlag.Corpse, flip);
				}
				else
				{
					decal = _tile.spawnDetail("bust_orc_01_armor_01_dead_arrows", this.Const.Tactical.DetailFlag.Corpse, flip);
				}

				decal.Scale = 0.9;
			}
			else if (_skill && _skill.getProjectileType() == this.Const.ProjectileType.Javelin)
			{
				if (appearance.CorpseArmor != "")
				{
					decal = _tile.spawnDetail(appearance.CorpseArmor + "_javelin", this.Const.Tactical.DetailFlag.Corpse, flip);
				}
				else
				{
					decal = _tile.spawnDetail("bust_orc_01_armor_01_dead_javelin", this.Const.Tactical.DetailFlag.Corpse, flip);
				}

				decal.Scale = 0.9;
			}

			this.spawnTerrainDropdownEffect(_tile);
			local corpse = clone this.Const.Corpse;
			corpse.CorpseName = "An Orc Grunt";
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

	function onInit()
	{
		this.actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.crOrcGrunt);

		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 70)
		{
			b.IsSpecializedInThrowing = true;

			if (this.World.getTime().Days >= 150)
			{
				b.RangedSkill += 5;
			}
		}

		b.IsSpecializedInAxes = true;
		b.IsSpecializedInCleavers = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		this.m.Items.getAppearance().Body = "bust_orc_01_body";
		this.addSprite("socket").setBrush("bust_base_orcs");
		local body = this.addSprite("body");
		body.setBrush("bust_orc_01_body");
		body.varySaturation(0.05);
		body.varyColor(0.07, 0.07, 0.07);
		local injury_body = this.addSprite("injury_body");
		injury_body.Visible = false;
		injury_body.setBrush("bust_orc_01_body_injured");
		this.addSprite("armor");
		local head = this.addSprite("head");
		head.setBrush("bust_crorc_01_head_0" + this.Math.rand(1, 3));
		head.Saturation = body.Saturation;
		head.Color = body.Color;
		local injury = this.addSprite("injury");
		injury.Visible = false;
		injury.setBrush("bust_orc_01_head_injured");
		local v = -5;   //-7
		local v2 = 0;   //0

		foreach( a in this.Const.CharacterSprites.Helmets )
		{
			this.addSprite(a);
			this.setSpriteOffset(a, this.createVec(v2, v));
		}

		local body_blood = this.addSprite("body_blood");
		body_blood.setBrush("bust_orc_01_body_bloodied");
		body_blood.Visible = false;
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.55;
		this.m.Skills.add(this.new("scripts/skills/special/double_grip"));
		this.m.Skills.add(this.new("scripts/skills/actives/hand_to_hand_orc"));
		this.m.Skills.add(this.new("scripts/skills/actives/charge"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_onslaught"));

		if (::Is_PTR_Exist)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_menacing"));
			this.m.Skills.add(this.new("scripts/skills/racial/ptr_orc_racial"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_momentum"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_primal_fear"));	
		}

		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_overwhelm"));	
			this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));			
			this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));

			if (::Is_PTR_Exist)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_strength_in_numbers"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_hybridization"));			
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_bully"));	
			}
		}

		if (this.Const.DLC.Unhold)
		{
			this.m.Skills.add(this.new("scripts/skills/actives/wake_ally_skill"));
		}

		this.m.Skills.add(this.new("scripts/skills/effects/captain_effect"));

		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 120)
		{
			this.m.BaseProperties.RangedSkill += 5;	
			this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));

			if (::Is_PTR_Exist)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_tempo"));	
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
		local r;
		local weapon;
		if (this.Math.rand(1, 100) <= 90)
		{
			if (this.Math.rand(1, 100) <= 75)
			{
				r = this.Math.rand(1, 3);

				if (r == 1)
				{
					weapon = this.new("scripts/items/weapons/greenskins/orc_axe");
				}
				else if (r == 2)
				{
					weapon = this.new("scripts/items/weapons/greenskins/orc_cleaver");
				}
				else if (r == 3)
				{
					weapon = this.new("scripts/items/weapons/greenskins/legend_skin_flayer");
				}
			}
			else
			{
					weapon = this.new("scripts/items/weapons/morning_star");
			}
		}
		else
		{
			r = this.Math.rand(1, 2);
			if (r == 1)
			{
				weapon = this.new("scripts/items/weapons/greenskins/legend_meat_hacker");
			}
			else if (r == 2)
			{
				weapon = this.new("scripts/items/weapons/greenskins/legend_bone_carver");
			}
		}
		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Mainhand))
		{
			this.m.Items.equip(weapon);
		}
		else
		{
			this.m.Items.addToBag(weapon);
		}
		this.m.Items.equip(this.new("scripts/items/shields/greenskins/orc_light_shield"));
		this.m.Items.addToBag(this.new("scripts/items/weapons/greenskins/orc_javelin"));		
		local item = this.Const.World.Common.pickArmor([
			[
				1,
				"greenskins/cr_orc_grunt_light_armor"
			],
			[
				1,
				"greenskins/cr_orc_grunt_medium_armor"
			],
			[
				1,
				"greenskins/cr_orc_grunt_heavy_armor"
			]
		]);
		this.m.Items.equip(item);				
		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Head) == null)
		{
			local helmet = [
				"helmets/cr_helmet_orc_bear_head_helm",
				"helmets/cr_helmet_orc_bone_helm",
				"helmets/cr_helmet_orc_faceplate_helm"
			];
			this.m.Items.equip(this.new("scripts/items/" + helmet[this.Math.rand(0, helmet.len() - 1)]));
		}

		if (::Is_PTR_Exist)
		{
			//this.m.Skills.addTreeOfEquippedWeapon(5);
			this.m.Skills.removeByID("perk.ptr_kata");	
		}

		::Mod_Sellswords.HookHelper.addTreeOfEquippedWeapon(this, 5);
	}
	
	function makeMiniboss()
	{
		if (!this.actor.makeMiniboss())
		{
			return false;
		}
		this.getSprite("miniboss").setBrush("bust_miniboss_greenskins");
		local weapons = [
			"weapons/named/named_axe",
			"weapons/named/named_cleaver",
			"weapons/named/named_mace",			
		];
		this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		
		if (::Is_PTR_Exist)
		{
			//this.m.Skills.addTreeOfEquippedWeapon();
			this.m.Skills.removeByID("perk.ptr_kata");	
		}
		
		::Mod_Sellswords.HookHelper.addTreeOfEquippedWeapon(this);
		return true;
	}	

});

