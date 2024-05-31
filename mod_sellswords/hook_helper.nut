::Mod_Sellswords.HookHelper <- 
{
	hookDoubleAP_CostIfEngageMelee = function( _object , _withTooltip = true )
	{
		if (_withTooltip)
		{
			local ws_getTooltip = _object.getTooltip;
			_object.getTooltip = function()
			{
				local ret = ws_getTooltip();

				foreach (tooltip in ret)
				{
					if ("icon" in tooltip && tooltip.icon != "ui/tooltips/warning.png") continue;

					tooltip.text = "[color=" + ::Const.UI.Color.NegativeValue + "]AP cost is doubled because this character is engaged in melee[/color]";
					break;
				}

				return ret;
			}
		}

		if ("isUsable" in _object)
		{
			// must overdrive
			_object.isUsable = function()
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

		if ("onAfterUpdate" in _object)
		{
			local ws_onAfterUpdate = _object.onAfterUpdate;
			_object.onAfterUpdate = function( _properties )
			{
				ws_onAfterUpdate(_properties);

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

		if (!("getAmount" in _object))
		{
			_object.getAmount <- function()
			{
				return this.m.Amount;
			}
		}

		if (!("addAmount" in _object))
		{
			_object.addAmount <- function( _a )
			{
				this.m.Amount = _a;
			}
		}

		if (!("getTurnsLeft" in _object))
		{
			_object.getTurnsLeft <- function()
			{
				return this.m.TurnsLeft;
			}
		}

		if (!("resetTurns" in _object))
		{
			_object.resetTurns <- function()
			{
				this.m.TurnsLeft = turnLeft;
			}
		}

		_object.onAdded = function()
		{
			this.m.TurnsLeft = turnLeft;
		}

		local ws_create = _object.create;
		_object.create = function()
		{
			ws_create();

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

		local ws_create = _object.create;
		_object.create = function()
		{
			ws_create();

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

		if (!("onPutIntoBag" in _object))
		{
			_object.onPutIntoBag <- function()
			{
				this.onEquip();
			};
		}

		if (!("isDesirable" in _object))
		{
			_object.isDesirable <- function()
			{
				return this.m.IsUndesirable;
			};
		}

		local old_create = _object.create;
		_object.create = function()
		{
			old_create();

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

	// ::Mod_Sellswords.HookHelper.addTreeOfEquippedWeapon(this, 7);
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
		if (weapon.isWeaponType(::Const.Items.WeaponType.Staff))
		{
			trees.push(::Const.Perks.StaffTree);
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
	}
}