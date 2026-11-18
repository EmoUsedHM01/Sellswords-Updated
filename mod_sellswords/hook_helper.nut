::Mod_Sellswords.HookHelper <- 
{
	hookDoubleAP_CostIfEngageMelee = function( _object , _withTooltip = true )
	{
		if (_withTooltip)
		{
			_object.getTooltip = @(__original) function()
			{
				local ret = __original();

				foreach (tooltip in ret)
				{
					if ("icon" in tooltip && tooltip.icon != "ui/tooltips/warning.png") continue;

					tooltip.text = "[color=%negative%]AP cost is doubled because this character is engaged in melee[/color]";
					break;
				}

				return ret;
			}
		}

		if (_object.contains("isUsable"))
		{
			// must overdrive
			_object.isUsable = @(__original) function()
			{
				return !::Tactical.isActive() || this.skill.isUsable();
			}
		}
		else
		{
			_object.isUsable <- function()
			{
				return !::Tactical.isActive() || this.skill.isUsable();
			}
		}

		if (_object.contains("onAfterUpdate"))
		{
			_object.onAfterUpdate = @(__original) function( _properties )
			{
				__original(_properties);

				if (!this.getContainer().getActor().isPlacedOnMap()) return;	

				if (::Tactical.isActive() && this.getContainer().getActor().isEngagedInMelee())
				{
					this.m.ActionPointCost *= 2;
				}
			}
		}
		else
		{
			_object.onAfterUpdate <- function( _properties )
			{
				if (!this.getContainer().getActor().isPlacedOnMap()) return;

				if (::Tactical.isActive() && this.getContainer().getActor().isEngagedInMelee())
				{
					this.m.ActionPointCost *= 2;
				}
			}
		}
	}

	hookNewEatFoodEffectSystem = function( _object, _amountNum = 0, _turnNum = 10 )
	{
		local amount = _amountNum;
		local turnLeft = _turnNum;

		if (!(_object.contains("getAmount")))
		{
			_object.getAmount <- function()
			{
				return this.m.Amount;
			}
		}

		if (!(_object.contains("addAmount")))
		{
			_object.addAmount <- function( _a )
			{
				this.m.Amount = _a;
			}
		}

		if (!(_object.contains("getTurnsLeft")))
		{
			_object.getTurnsLeft <- function()
			{
				return this.m.TurnsLeft;
			}
		}

		if (!(_object.contains("resetTurns")))
		{
			_object.resetTurns <- function()
			{
				this.m.TurnsLeft = turnLeft;
			}
		}

		_object.onAdded = @(__original) function()
		{
			this.m.TurnsLeft = turnLeft;
		}

		_object.create = @(__original) function()
		{
			__original();

			this.m.Amount = amount;
			this.m.TurnsLeft = turnLeft;
			this.m.Icon = "skills/status_effect_93.png";
			this.m.IconMini = "status_effect_93_mini";
			this.m.Overlay = "status_effect_93";
		}
	}

	hookNewEatFoodSystem = function( _object, _withTooltip = true )
	{
		if (!("Amount" in _object.m))
		{
			_object.m.Amount <- 0;

			_object.setAmount <- function( _a )
			{
				this.m.Amount = _a;
			}
		}
		
		_object.m.ValidEffects <- [
			"effects.legend_rations_effect",
			"effects.legend_pudding_effect",
			"effects.legend_pie_effect",
			"effects.legend_porridge_effect"
		];

		_object.create = @(__original) function()
		{
			__original();

			this.m.Name = "Eat or Give Food";
			this.m.Description = "Give to an adjacent ally or eat food that slowly heals. AP cost is doubled while engaged in melee, and anyone receiving the item needs to have a free bag slot. Eating this kind of comestible will increase your Fatigue recovery, hitchance and initiative, based on amount of the food.";
			this.m.IsStacking = false;
			this.m.ActionPointCost = 1;
		}

		this.hookDoubleAP_CostIfEngageMelee(_object, _withTooltip);
	}

	// _function mustn't have any parameter, only apply to named shields or named weapons
	hookNamedItemToChangeStats = function ( _object , _function )
	{
		local hookFunction = _function;
		_object.create = @(__original) function()
		{
			// turn off randomize values
			this.m.IsAllowedRandomizeValues = false;

			// call the original function
			__original();

			// turn on randomize values
			this.m.IsAllowedRandomizeValues = true;

			// do stuffs
			hookFunction.call(this);

			// start randomize this shit
			this.randomizeValues();
		}
	},

	// will use .call(item) for this, _function must have a _skill as the only parameter
	hookSpecificItemSkill = function( _id, _function )
	{
		foreach (_skill in this.m.SkillPtrs)
		{
			if (_skill.getID() != _id) continue;
			
			// make sure the changes are applied and save properly
			_skill.hardReset(["Container"]);
			_function.call(this, _skill);
			_skill.saveBaseValues();
			break;
		}
	},

	// will use .call(item) for this
	removeItemSkill = function( _id )
	{
		local index;

		for (local i = this.m.SkillPtrs.len() - 1; i >= 0; --i)
		{
			if (this.m.SkillPtrs[i].getID() != _id) continue;

			index = i;
			break;
		}

		if (index == null) return null;

		this.m.SkillPtrs[index].removeSelf();
		return this.m.SkillPtrs.remove(index);
	},

	// will use .call(item) for this
	addGenericSkillToItem = function()
	{
		if (this.m.AddGenericSkill)
		{
			this.addGenericItemSkill();
		}
	},

	convertToUsableFood = function( _object )
	{
		_object.m.AddGenericSkill <- true;
		_object.m.StaminaModifier <- 0;
		_object.m.StashModifier <- 0;

		if (!(_object.contains("resetTurns")))
		{
			_object.onPutIntoBag <- function()
			{
				this.onEquip();
			};
		}

		if (!(_object.contains("isDesirable")))
		{
			_object.isDesirable <- function()
			{
				return this.m.IsUndesirable;
			};
		}

		_object.create = function()
		{
			__original();

			// usable food
			this.m.SlotType = ::Const.ItemSlot.Bag;
			this.m.IsAllowedInBag = true;
			this.m.IsDroppedAsLoot = true;	
		};
	},

	addNCSetting = function ( _page, _setting )
	{
		_setting.getData().NewCampaign <- true;
		_setting.getData().NewCampaignOnly <- true;
		_page.addElement(_setting);
	},

	getOptionInEventScreen = function( _text, _screen )
	{
		foreach (option in _screen.Options)
		{
			if (option.Text == _text)
			{
				return option;
			}
		}

		return null;
	}

	addPerkTreesToCustomPerkTree = function ( _customPerkTree, _treesToAdd )
	{
		foreach( tree in _treesToAdd )
		{
			for( local i = 0; i < tree.Tree.len(); i++ )
			{
				foreach( perk in tree.Tree[i] )
				{
					_customPerkTree[i].push(perk);
				}
			}
		}
	},
	
	addPerksToCustomPerkTree = function ( _tier, _customPerkTree, _perks )
	{
		local row = _tier - 1;

		foreach( perk in _perks )
		{
			_customPerkTree[row].push(perk);
		}
	},

	// gives an unleashed animal the SSU bonuses from its handler's perks and professions
	addHoundBonuses = function ( _actor, _entity )
	{
		local houndeffect = ::new("scripts/skills/effects/ssu_houndmaster_effect");

		if (::Legends.Perks.has(_actor, ::Legends.Perk.LegendDogWhisperer))
		{
			_entity.getSkills().add(::new("scripts/skills/effects/ssu_clarity_effect_permanent"));
		}

		if (::Legends.Professions.has(_actor, ::Legends.Profession.LegendDogBreeder))
		{
			::Legends.Perks.grant(_entity, ::Legends.Perk.FastAdaption);
			::Legends.Perks.grant(_entity, ::Legends.Perk.SsuBackswing);
			houndeffect.m.dogbreeder = true;
		}

		if (::Legends.Perks.has(_actor, ::Legends.Perk.LegendDogHandling))
		{
			::Legends.Perks.grant(_entity, ::Legends.Perk.Overwhelm);
			houndeffect.m.doghandling = true;
		}

		if (::Legends.Perks.has(_actor, ::Legends.Perk.LegendPackLeader))
		{
			::Legends.Perks.grant(_entity, ::Legends.Perk.LegendAssuredConquest);
			houndeffect.m.packleader = true;
		}

		_entity.getSkills().add(houndeffect);
	},

	// swaps a perk for another one wherever it sits in a perk tree
	replacePerkInTree = function ( _tree, _old, _new )
	{
		foreach( tier in _tree.Tree )
		{
			local i = tier.find(_old);

			if (i != null)
			{
				tier[i] = _new;
			}
		}
	},

	clearCustomPerkTree = function ( _customPerkTree )
	{
		if (_customPerkTree == null)
		{
			_customPerkTree = [];
		}
		else
		{
			_customPerkTree.clear();
		}

		for( local i = 0; i < 7; i++ )
		{
			local emptyArray = [];
			_customPerkTree.push(emptyArray);
		}

		return _customPerkTree;
	}

	addTreeOfEquippedWeapon = function( _actor, _maxTier = 7 )
	{
		local weapon = _actor.getMainhandItem();

		if (weapon == null)
		{
			return;
		}

		local trees = [];

		if (weapon.isWeaponType(::Const.Items.WeaponType.Axe))
		{
			trees.push(::Const.Perks.AxeTree);
		}
		if (weapon.isWeaponType(::Const.Items.WeaponType.Bow))
		{
			trees.push(::Const.Perks.BowTree);
		}
		if (weapon.isWeaponType(this.Const.Items.WeaponType.Cleaver))
		{
			trees.push(::Const.Perks.CleaverTree);
		}
		if (weapon.isWeaponType(::Const.Items.WeaponType.Crossbow))
		{
			trees.push(::Const.Perks.CrossbowTree);
		}
		if (weapon.isWeaponType(::Const.Items.WeaponType.Dagger))
		{
			trees.push(::Const.Perks.DaggerTree);
		}
		if (weapon.isWeaponType(::Const.Items.WeaponType.Flail))
		{
			trees.push(::Const.Perks.FlailTree);
		}
		if (weapon.isWeaponType(::Const.Items.WeaponType.Hammer))
		{
			trees.push(::Const.Perks.HammerTree);
		}
		if (weapon.isWeaponType(::Const.Items.WeaponType.Mace))
		{
			trees.push(::Const.Perks.MaceTree);
		}
		if (weapon.isWeaponType(::Const.Items.WeaponType.Polearm))
		{
			trees.push(::Const.Perks.PolearmTree);
		}
		if (weapon.isWeaponType(::Const.Items.WeaponType.Sling))
		{
			trees.push(::Const.Perks.SlingTree);
		}
		if (weapon.isWeaponType(::Const.Items.WeaponType.Spear))
		{
			trees.push(::Const.Perks.SpearTree);
		}
		if (weapon.isWeaponType(::Const.Items.WeaponType.Sword))
		{
			trees.push(::Const.Perks.SwordTree);
		}
		if (weapon.isWeaponType(::Const.Items.WeaponType.Throwing))
		{
			trees.push(::Const.Perks.ThrowingTree);
		}

		if (trees.len() == 0)
		{
			return;
		}

		this.addPerkTree(_actor, ::MSU.Array.rand(trees), _maxTier);
	}

	addPerkTree = function( _actor, _tree, _maxTier = 7 )
	{
		local max = _maxTier > _tree.Tree.len() - 1 ? _tree.Tree.len() - 1 : _maxTier; 

		for (local i = 0; i < max; i++)
		{
			foreach (perk in _tree.Tree[i])
			{
				_actor.getSkills().add(::new(::Const.Perks.PerkDefObjects[perk].Script));
			}
		}
	},

	// equips the weapon, the ones listed in ::Mod_Sellswords.DualWield.Paired get a second one for the off hand
	equipWeapon = function( _actor, _script )
	{
		_actor.getItems().equip(::new("scripts/items/" + _script));

		if (::Mod_Sellswords.DualWield.Paired.find(_script) != null)
		{
			_actor.getItems().equip(::new("scripts/items/" + _script));
		}
	},

	// adds SSU Sellswords to a recruit pool, half as many as it has regular Sellswords, so they are twice as rare
	addSellswordsToDraftList = function( _list )
	{
		local regular = 0;

		foreach (background in _list)
		{
			// the pool has been through here already
			if (background == "ssu_sellsword_background")
				return;

			if (background == ::Legends.Background.Sellsword || background == "sellsword_background")
				++regular;
		}

		// one for every two, and a coin flip for an odd one left over
		local wanted = regular / 2;

		if (regular % 2 == 1 && ::Math.rand(1, 100) <= 50)
			++wanted;

		for (; wanted > 0; --wanted)
		{
			_list.push("ssu_sellsword_background");
		}
	},

	// adds SSU units to a party list of Legends without replacing anything in it
	// a group with Join is put into the group of the list that has that unit, so its units can be picked in place of that one
	// without Join, or if the list has no such group, the group is added on its own with its Weight
	addTroops = function( _party, _groups )
	{
		foreach (group in _groups)
		{
			local target = null;

			if ("Join" in group)
			{
				target = this.getTroopGroup(_party, group.Join);
				delete group.Join;
			}

			if (target == null)
			{
				_party.Troops.push(group);
				continue;
			}

			// the types of a group are kept in order of cost
			foreach (type in group.Types)
			{
				local index = 0;

				while (index < target.Types.len() && target.Types[index].Cost <= type.Cost)
				{
					++index;
				}

				target.Types.insert(index, type);
			}
		}
	},

	// the group of a party list that has the unit, null if there is none
	getTroopGroup = function( _party, _unit )
	{
		if (_unit == null)
			return null;

		foreach (group in _party.Troops)
		{
			foreach (type in group.Types)
			{
				if (type.Type.Script == _unit.Script)
					return group;
			}
		}

		return null;
	}
}