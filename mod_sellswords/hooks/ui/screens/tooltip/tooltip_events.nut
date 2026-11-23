::mods_hookNewObject("ui/screens/tooltip/tooltip_events", function(o) {

	local general_queryUIElementTooltipData = o.general_queryUIElementTooltipData;
	o.general_queryUIElementTooltipData = function (_entityId, _elementId, _elementOwner )
	{
		switch(_elementId)
		{
		case "character-screen.left-panel-header-module.Experience":
			return [
				{
					id = 1,
					type = "title",
					text = ::Mod_Sellswords.Strings.tooltip_events.Tooltip1
				},
				{
					id = 2,
					type = "description",
					text = ::Mod_Sellswords.Strings.tooltip_events.Tooltip2
				}
			];

		case "character-screen.left-panel-header-module.Level":
			return [
				{
					id = 1,
					type = "title",
					text = ::Mod_Sellswords.Strings.tooltip_events.Tooltip3
				},
				{
					id = 2,
					type = "description",
					text = ::Mod_Sellswords.Strings.tooltip_events.Tooltip4
				}
			];

		case "character-screen.left-panel-header-module.Reserves":
			local text = ::Mod_Sellswords.Strings.tooltip_events.Tooltip5;
			local entity = _entityId != null ? this.Tactical.getEntityByID(_entityId) : null;

			if (entity != null && entity.isInReserves())
			{
				text = ::Mod_Sellswords.Strings.tooltip_events.Tooltip6;
			}

			return [
				{
					id = 1,
					type = "title",
					text = ::Mod_Sellswords.Strings.tooltip_events.Tooltip7
				},
				{
					id = 2,
					type = "description",
					text = text
				}
			];
		}

		return general_queryUIElementTooltipData(_entityId, _elementId, _elementOwner);
	}

});
