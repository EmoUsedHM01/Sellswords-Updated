this.necro_lorekeeper_book <- ::inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.necro_lorekeeper_book";
		this.m.Name = "The Black Book";
		this.m.Description = "An old and eerie looking tome with a fleshen cover. Its pages are filled with inscrutable writing and mysterious drawings that you can\'t begin to understand. The longer you look at the book, the more uneasy it makes you feel. Perhaps someone with more knowledge in ancient languages could make some sense of it.";
		this.m.IconLarge = "tools/ancient_lich_book.png";
		this.m.Icon = "tools/ancient_lich_book_70x70.png";
		this.m.WeaponType = ::Const.Items.WeaponType.MagicStaff;
		this.m.SlotType = ::Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = ::Const.ItemSlot.Offhand;
		this.m.ItemType = ::Const.Items.ItemType.Tool | ::Const.Items.ItemType.TwoHanded | ::Const.Items.ItemType.Defensive | ::Const.Items.ItemType.Legendary;
		this.m.AddGenericSkill = true;
		this.m.ShowArmamentIcon = true;
		this.m.IsDroppedAsLoot = true;
		this.m.IsIndestructible = true;
		this.m.ArmamentIcon = "icon_necronomicon";
		this.m.Value = 1000;
	}

	function getTooltip()
	{
		local result = this.weapon.getTooltip();
		local index = this.isRuned() ? result.len() - 2 : result.len() - 1;
		local find;

		result.insert(index, {
			id = 64,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Contains forbidden knowledge that only those well versed in languages of the past can make use of"
		});

		foreach (i, a in result )
		{
			if (a.id == 5)
			{
				find = i;
				break;
			}
		}

		if (find != null) result.remove(find);
		return result;
	}

	function playInventorySound( _eventType )
	{
		local sounds = [
			"sounds/combat/dlc4/prophet_chant_01.wav",
			"sounds/combat/dlc4/prophet_chant_02.wav",
			"sounds/combat/dlc4/prophet_chant_03.wav",
			"sounds/combat/dlc4/prophet_chant_04.wav"
		];

		::Sound.play(::MSU.Array.rand(sounds), ::Const.Sound.Volume.Inventory);
	}

	function onEquip()
	{
		this.weapon.onEquip();
		local c = this.getContainer();
		local hasActor = c != null && c.getActor() != null && !c.getActor().isNull();
		local hasFlags = hasActor && c.getActor().getFlags().has("IsPlayerCharacter");
		
		if (hasFlags)
		{
			this.addSkill(::new("scripts/skills/actives/raise_undead"));
			this.addSkill(::new("scripts/skills/actives/mod_raise_all_undead"));
			return;
		}
		else
		{
			this.addSkill(::new("scripts/skills/actives/raise_undead"));
		}
	}

});