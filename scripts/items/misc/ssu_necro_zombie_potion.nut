this.ssu_necro_zombie_potion <- this.inherit("scripts/items/item", {
	m = {},
	function create()
	{
		this.item.create();
		this.m.ID = "misc.ssu_necro_zombie_potion";
		this.m.Name = ::Mod_Sellswords.Strings.ssu_necro_zombie_potion.Name;
		this.m.Description = ::Mod_Sellswords.Strings.ssu_necro_zombie_potion.Description;
		this.m.Icon = "consumables/potion_22.png";
		this.m.IconLarge = "";
		this.m.SlotType = this.Const.ItemSlot.None;
		this.m.ItemType = this.Const.Items.ItemType.Usable;
		this.m.IsDroppedAsLoot = true;
		this.m.IsAllowedInBag = false;
		this.m.IsUsable = true;
		this.m.Value = 1000;
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
		result.push({
			id = 66,
			type = "text",
			text = this.getValueString()
		});

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
			id = 11,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Mod_Sellswords.Strings.ssu_necro_zombie_potion.Tooltip1
		});
		result.push({
			id = 65,
			type = "text",
			text = ::Mod_Sellswords.Strings.ssu_necro_zombie_potion.Tooltip2
		});
		return result;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/bottle_01.wav", this.Const.Sound.Volume.Inventory);
	}

	function onUse( _actor, _item = null )
	{
		if (_actor.getFlags().has("undead"))
			return false;

		if (_actor.getSkills().getSkillByID("trait.legend_withering_aura"))
			_actor.getSkills().removeByID("trait.legend_withering_aura");

		if (_actor.getSkills().getSkillByID("trait.legend_deathly_spectre"))
			_actor.getSkills().removeByID("trait.legend_deathly_spectre");

		if (!_actor.getSkills().getSkillByID("trait.legend_rotting_flesh"))
			_actor.getSkills().add(this.new("scripts/skills/traits/legend_rotting_flesh_trait"));

		_actor.getBackground().addPerkGroup(::Const.Perks.ZombieClassTree.Tree);

		_actor.getBaseProperties().Hitpoints += 30;

		this.Sound.play("sounds/enemies/zombie_rise_0" + this.Math.rand(1, 4) + ".wav", this.Const.Sound.Volume.Inventory);

		return true;
	}

});