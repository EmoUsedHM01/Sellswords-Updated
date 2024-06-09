::Mod_Sellswords.HooksMod.hook("scripts/skills/effects/battle_standard_effect", function ( q ) {

	q.onAfterUpdate = @(__original) function( _properties )
	{
		local bonus = this.getBonus(_properties);

		if (bonus != 0)
		{
			this.m.IsHidden = false;
			local ab = this.Math.max(100 - this.getContainer().getActor().getBaseProperties().getBravery(), 0) * 0.5;
			_properties.Bravery += (bonus * (1 + 0.01 * ab)).tointeger();
			this.m.Difference = (bonus * (1 + 0.01 * ab)).tointeger();					
		}
		else
		{
			this.m.IsHidden = true;
			this.m.Difference = 0;
		}			
	}
});
