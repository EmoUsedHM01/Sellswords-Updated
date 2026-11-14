this.ssu_emperors_armor <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.Type = this.Const.Items.ArmorUpgrades.Plate;
		this.m.ID = "legend_armor.body.ssu_emperors_armor";
		this.m.Name = ::Mod_Sellswords.Strings.ssu_emperors_armor.Name;
		this.m.Description = ::Mod_Sellswords.Strings.ssu_emperors_armor.Description;
		this.m.ArmorDescription = "A shining armor once worn by the emperor of an age long past, made from the most woundrous of materials, imbued with mystical energies. Light reflects easily off the polished armor, turning the wearer into a shimmering figure of light during the day.";
		this.m.Variants = [
			0,
			1
		];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
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
			text = ::Mod_Sellswords.Strings.ssu_emperors_armor.Tooltip
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
					continue;

				if (actor.getTile().getDistanceTo(a.getTile()) > 2)
					continue;

				if (a.isAlliedWith(actor))
					continue;

				if (!a.getCurrentProperties().IsImmuneToDaze)
					a.getSkills().add(this.new("scripts/skills/effects/dazed_effect"));
			}
		}
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.SpriteBack = "ssu_bust_emperors_armor" + "_" + variant;
		this.m.SpriteDamagedBack = "ssu_bust_emperors_armor" + "_" + variant + "_damaged";
		this.m.SpriteCorpseBack = "ssu_bust_emperors_armor" + "_" + variant + "_dead";
		this.m.Icon = "legend_armor/ssu_icon_emperors_armor" + "_" + variant + ".png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "legend_armor/ssu_icon_emperors_armor" + "_" + variant + ".png";
		this.m.OverlayIconLarge = "legend_armor/ssu_inventory_emperors_armor" + "_" + variant + ".png";
	}

});