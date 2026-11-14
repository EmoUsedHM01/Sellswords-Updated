this.ssu_necro_zombie_dog <- this.inherit("scripts/items/spawns/legend_spawn_item", {
	m = {
		UnleashSounds = [
			"sounds/enemies/geist_idle_10.wav",
			"sounds/enemies/geist_idle_11.wav",
			"sounds/enemies/geist_idle_12.wav"
		]
	},
	function create()
	{
		this.legend_spawn_item.create();
		this.m.Variant = 1;
		this.updateVariant();
		this.m.ID = "spawns.ssu_necro_zombie_dog";
		this.m.Name = ::Mod_Sellswords.Strings.ssu_necro_zombie_dog_spawns.Name;
		this.m.Description = ::Mod_Sellswords.Strings.ssu_necro_zombie_dog_spawns.Description;
		this.m.IsDroppedAsLoot = false;
		this.m.ShowOnCharacter = false;
		this.m.IsChangeableInBattle = false;
		this.m.Icon = "supplies/ssu_necro_dog.png";
		this.m.Value = 100;
		this.m.MedicinePerDay = 2;
	}

	function playInventorySound( _eventType )
	{
		local index = this.Math.rand(1, 5);
		local variant = "" + index;

		if (index < 10)
			variant = "0" + index;

		this.Sound.play("sounds/enemies/wardog_idle_" + variant + ".wav", this.Const.Sound.Volume.Inventory);
	}

});