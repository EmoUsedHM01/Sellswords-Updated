this.ssu_dryad_forest_heart_ammo <- this.inherit("scripts/items/ammo/ammo", {
	m = {},
	function create()
	{
		this.ammo.create();
		this.m.ID = "ammo.ssu_dryad_heart";
		this.m.Name = ::Mod_Sellswords.Strings.ssu_dryad_forest_heart_ammo.Name;
		this.m.Description = ::Mod_Sellswords.Strings.ssu_dryad_forest_heart_ammo.Description;
		this.m.Icon = "ammo/ssu_forest_heart_ammo.png";
		this.m.IconEmpty = "ammo/ssu_forest_heart_empty.png";
		this.m.SlotType = this.Const.ItemSlot.Ammo;
		this.m.ItemType = this.Const.Items.ItemType.Ammo;
		this.m.AmmoType = this.Const.Items.AmmoType.Heart;
		this.m.ShowOnCharacter = false;
		this.m.ShowQuiver = false;
		this.m.Value = 0;
		this.m.Ammo = 3;
		this.m.AmmoMax = 3;
		this.m.AmmoCost = 5;
		this.m.IsDroppedAsLoot = true;
	}

	function getTooltip()
	{
		local result = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			}
		];

		if (this.getIconLarge() != null)
		{
			result.push({
				id = 3,
				type = "image",
				image = this.getIconLarge(),
				isLarge = true
			});
		}
		else
		{
			result.push({
				id = 3,
				type = "image",
				image = this.getIcon()
			});
		}

		result.push({
			id = 66,
			type = "text",
			text = this.getValueString()
		});

		if (this.m.Ammo != 0)
		{
			result.push({
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.ssu_dryad_forest_heart_ammo.Tooltip1, this.m.Ammo)
			});
		}
		else
		{
			result.push({
				id = 6,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = ::Mod_Sellswords.Strings.ssu_dryad_forest_heart_ammo.Tooltip2
			});
		}

		return result;
	}

});

