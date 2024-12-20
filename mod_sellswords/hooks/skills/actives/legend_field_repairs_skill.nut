::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/legend_field_repairs_skill", function ( q ) {

	q.create = @(__original) function()
	{
		__original();

		this.m.Description = "Repair 20% of missing armor, costs 3 Armor Parts for every 10 missing armor.";
		this.m.ActionPointCost = 6;
		this.m.MaxLevelDifference = 1;
		this.m.RepairPerTool = 3.33;
	}
	
	q.getTooltip = @( __original ) function()
	{
		local ret = this.getDefaultUtilityTooltip();
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/asset_money.png",
			text = "You have [color=" + this.Const.UI.Color.PositiveValue + "]" + this.Math.floor(this.World.Assets.getArmorParts()) + "[/color] tools."
		});
		local repairs = this.World.Assets.getArmorParts() * 3.33;
		ret.push({
			id = 8,
			type = "text",
			icon = "ui/icons/asset_money.png",
			text = "You can repair max [color=" + this.Const.UI.Color.PositiveValue + "]" + this.Math.floor(repairs) + "[/color] points of armor."
		});
		return ret;
	}
	
	
	q.onUse = @( __original ) function( _user, _targetTile )
	{
		local target = _targetTile.getEntity();
		local head = target.getHeadItem();
		local headArmor = head == null ? 1 : head.getArmor();
		local maxHeadArmor = head == null ? 1 : head.getArmorMax();
		local body = target.getBodyItem();
		local bodyArmor = body == null ? 1 : body.getArmor();
		local maxBodyArmor = body == null ? 1 : body.getArmorMax();
		local cost = this.Math.minf((maxHeadArmor - headArmor + maxBodyArmor - bodyArmor) * 0.06, this.World.Assets.getArmorParts());

		for( local i = 0; i < this.Math.ceil(cost * this.m.RepairPerTool); i = i )
		{
			if (headArmor + 1 / maxHeadArmor > bodyArmor + 1 / maxBodyArmor)
			{
				body.setArmor(this.Math.minf(maxBodyArmor, bodyArmor + 1));
				bodyArmor = body.getArmor();
			}
			else
			{
				head.setArmor(this.Math.minf(maxHeadArmor, headArmor + 1));
				headArmor = head.getArmor();
			}

			i = ++i;
		}

		target.setDirty(true);
		this.World.Assets.addArmorParts(cost * -1);
	}
	
});
