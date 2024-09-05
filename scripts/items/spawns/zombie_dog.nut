this.zombie_dog <- this.inherit("scripts/items/spawns/spawn_item", {
	m = {
		UnleashSounds = [
			"sounds/enemies/geist_idle_10.wav",
			"sounds/enemies/geist_idle_11.wav",
			"sounds/enemies/geist_idle_12.wav"
		]
	},
	function create()
	{
		this.spawn_item.create();
		this.m.Variant = 1;
		this.updateVariant();
		this.m.ID = "spawns.zombie_dog";
		this.m.Name = "Canine Carrion";
		this.m.Description = "A heap of canine offal; limbs, skin, and gore, all salvaged from mans best friend, the perfect medium for your grim work. Requires constant preservation as the encroaching rot threatens to stall your efforts.";
		this.m.IsDroppedAsLoot = false;
		this.m.ShowOnCharacter = false;
		this.m.IsChangeableInBattle = false;
		this.m.Icon = "supplies/necro_dog.png";
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