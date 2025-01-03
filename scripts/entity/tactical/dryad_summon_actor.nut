this.dryad_summon_actor <- this.inherit("scripts/entity/tactical/actor", {
	addedSprites = [],

	function addSprite(_name) {
		// Track the added sprite to auto flip all added sprites
		this.addedSprites.append(_name);

		return this.actor.addSprite(_name);
	}

	function onFactionChanged() {
		this.actor.onFactionChanged();
		local flip = this.isAlliedWithPlayer();

		foreach(spriteName in this.addedSprites) {
			local spriteObj = this.getSprite(spriteName);
			if (spriteObj != null && "setHorizontalFlipping" in spriteObj) {
				spriteObj.setHorizontalFlipping(flip);
			}
		}

		if (!this.Tactical.State.isScenarioMode()) {
			local f = this.World.FactionManager.getFaction(this.getFaction());

			if (f != null) {
				this.getSprite("socket").setBrush(f.getTacticalBase());
			}
		} else {
			this.getSprite("socket").setBrush(this.Const.FactionBase[this.getFaction()]);
		}
	}
});