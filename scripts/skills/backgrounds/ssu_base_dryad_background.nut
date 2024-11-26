this.ssu_base_dryad_background <- ::inherit("scripts/skills/backgrounds/character_background", {
	dummy = {
		array = []
	},

	function create() {
        // Implement the `create` method
        return this.character_background.create(); // Call the parent's `create` method if it exists
    },
	function onUpdate( _properties )
	{
		_properties.IsImmuneToBleeding = true;
		_properties.IsImmuneToPoison = true;

		// give all dryads the same green socket, matching dryad avatar
		this.getContainer().getActor().get().getSprite("socket").setBrush("bust_base_dryad");

		return this.character_background.onUpdate(_properties);
	}
});