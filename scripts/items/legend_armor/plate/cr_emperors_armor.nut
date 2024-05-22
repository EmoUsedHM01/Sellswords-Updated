this.cr_emperors_armor <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.Type = this.Const.Items.ArmorUpgrades.Plate;	
		this.m.ID = "legend_armor.body.cr_emperors_armor";
		this.m.Name = "The Emperor\'s Armor";	
		this.m.Description = "A shining armor once worn by the emperor of an age long past, made from the most woundrous of materials, imbued with mystical energies. Light reflects easily off the polished armor, turning the wearer into a shimmering figure of light during the day.";
		this.m.ArmorDescription = "A shining armor once worn by the emperor of an age long past, made from the most woundrous of materials, imbued with mystical energies. Light reflects easily off the polished armor, turning the wearer into a shimmering figure of light during the day.";
		this.m.Variant = 99;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = this.Const.Sound.ArmorLeatherImpact;
		this.m.Value = 20000;
		this.m.Condition = 350;
		this.m.ConditionMax = 350;
		this.m.StaminaModifier = -35;
		this.m.ItemType = this.m.ItemType | this.Const.Items.ItemType.Legendary;
	}

	function getTooltip()
	{
		local result = this.legend_armor_upgrade.getTooltip();
		this.onArmorTooltip(result);
		return result;
	}
	
	function onArmorTooltip( _result )
	{
		_result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "At the start of your turn, apply the Dazed status effect to all nearby enemies"
		});
	}		

	function onTurnStart()
	{
		local actor = this.getContainer().getActor();
		local actors = this.Tactical.Entities.getAllInstances();
		foreach( i in actors )
		{
			foreach( a in i )
			{
				if (a.getID() == actor.getID())
				{
					continue;
				}
				if (actor.getTile().getDistanceTo(a.getTile()) > 3)
				{
					continue;
				}			
				if (a.getFaction() == actor.getFaction())
				{
					continue;
				}			
				if (this.Math.rand(1, 100) <= 80)
				{
					continue;
				}
				a.getSkills().add(this.new("scripts/skills/effects/dazed_effect"));
			}
		}		
	}

	function updateVariant()
	{
		this.m.SpriteBack = "bust_body_cr99";
		this.m.SpriteDamagedBack = "bust_body_cr99_damaged";
		this.m.SpriteCorpseBack = "bust_body_cr99_dead";
		this.m.Icon = "armor/icon_body_armor_cr99.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "armor/icon_body_armor_cr99.png";
		this.m.OverlayIconLarge = "armor/inventory_body_armor_cr99.png";		
	}	

});

