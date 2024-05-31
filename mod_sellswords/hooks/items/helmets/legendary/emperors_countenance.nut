::mods_hookExactClass("items/helmets/legendary/emperors_countenance", function ( q ) {

	q.create = @(__original) function()
	{
		__original();
		
		this.m.ConditionMax = 555;
		this.m.Condition = this.m.ConditionMax;
		this.m.StaminaModifier = -32;
	}
});
