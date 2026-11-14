foreach(script in [
	"warwolf",
	"warhound",
	"wardog",
])
{
	::Mod_Sellswords.HooksMod.hook("scripts/entity/tactical/" + script, function ( q ) {

		q.onInit = @( __original ) function()
		{
			__original();

			if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 50)
			{
				this.m.BaseProperties.MeleeSkill += 2;
				this.m.BaseProperties.Bravery += 5;

				if (this.World.getTime().Days >= 100)
				{	
					this.m.BaseProperties.MeleeDefense += 2;
					this.m.BaseProperties.Hitpoints += 5;

					if (this.World.getTime().Days >= 150)
					{										
						this.m.BaseProperties.MeleeSkill += 3;			
						this.m.BaseProperties.MeleeDefense += 3;			
						this.m.BaseProperties.Bravery += 5;
						if (this.World.getTime().Days >= 200)
						{
							
							this.m.BaseProperties.Hitpoints += 5;													
						}		
					}
				}
			}				
		}
	});
}