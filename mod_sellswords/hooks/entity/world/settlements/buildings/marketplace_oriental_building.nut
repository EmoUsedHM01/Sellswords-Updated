::mods_hookExactClass("entity/world/settlements/buildings/marketplace_oriental_building", function(o) 
{
	local fillStash = ::mods_getMember(o, "fillStash");
	o.fillStash<- function(_list, _stash, _priceMult, _allowDamagedEquipment = true)
	{
		if (this.m.Settlement.getSize() >= 2)
		{
			_list.extend([
			{
				R = 80,
				P = 2.1,
				S = "supplies/banquet_item"
			},
			{
				R = 60,
				P = 2.1,
				S = "supplies/cured_rations_item"
			},
			{
				R = 50,
				P = 1.0,
				S = "misc/cr_pack"
			}
			]);
	    }
		
	    fillStash(_list, _stash, 1, true);
	}
})