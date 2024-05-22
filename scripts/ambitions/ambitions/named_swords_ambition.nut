this.named_swords_ambition <- this.inherit("scripts/ambitions/ambition", {
	m = {
		Obtained = 0,
	},
	function create()
	{
		this.ambition.create();
		this.m.ID = "ambition.named_swords";
		this.m.Duration = 21.0 * this.World.getTime().SecondsPerDay;
		this.m.ButtonText = "It is sad there are seven legendary swords with each of them has unique bonus and grants you powerful skills that can only be known and grasp by swordmasters.";
		this.m.UIText = "Find Legendary Swords around the world";
		this.m.TooltipText = "Always be in good fighting condition and go around the world in search of the legendary swords.";
		this.m.SuccessText = "[img]gfx/ui/events/event_82.png[/img]After weeks spent listening for rumors, buying pints of beer for decrepit old veterans, and negotiating with wheedling crones, you were able to ferret out the locations of a set of prestigious weapons. Having learned where to find the pieces, all that remained was the minor matter of defeating the various horrors and cutthroats guarding it. Now soon to be wielded by the men of your company, the pieces form a set fearsome to behold. %SPEECH_ON%The man who dons this arming onto the battlefield will see the fiercest enemy hobble away shaking a load down the leg of his pants!%SPEECH_OFF%%randombrother% exclaims proudly and to the laughing approval of his brothers in arms. You only hope their joy and excitement doesn\'t turn into envy once you announce which man will get to own all these legendary swords.";
		this.m.SuccessButtonText = "Tell everyone it was the %companyname% who won here!";
	}
		
	function CheckAbtswords()
	{		
		local items = this.World.Assets.getStash().getItems();

		foreach( item in items )
		{
			if (item != null && !this.World.Flags.get("SwordAmbition_zhanlu") && item.getID() == "weapon.named_sword_abt_zhanlu")
			{
				++this.m.Obtained;
				this.World.Flags.set("SwordAmbition_zhanlu", 1);			
			}
			if (item != null && !this.World.Flags.get("SwordAmbition_durandal") && item.getID() == "weapon.named_sword_abt_durandal")
			{
				++this.m.Obtained;
				this.World.Flags.set("SwordAmbition_durandal", 1);				
			}
			if (item != null && !this.World.Flags.get("SwordAmbition_excalibur") && item.getID() == "weapon.named_sword_abt_excalibur")
			{
				++this.m.Obtained;
				this.World.Flags.set("SwordAmbition_excalibur", 1);				
			}
			if (item != null && !this.World.Flags.get("SwordAmbition_guinevere") && item.getID() == "weapon.named_sword_abt_guinevere")
			{
				++this.m.Obtained;
				this.World.Flags.set("SwordAmbition_guinevere", 1);				
			}
			if (item != null && !this.World.Flags.get("SwordAmbition_herbstnebel") && item.getID() == "weapon.named_sword_abt_herbstnebel")
			{
				++this.m.Obtained;
				this.World.Flags.set("SwordAmbition_herbstnebel", 1);			
			}
			if (item != null && !this.World.Flags.get("SwordAmbition_mikazuki") && item.getID() == "weapon.named_sword_abt_mikazuki")
			{
				++this.m.Obtained;
				this.World.Flags.set("SwordAmbition_mikazuki", 1);				
			}
			if (item != null && !this.World.Flags.get("SwordAmbition_mystletainn") && item.getID() == "weapon.named_sword_abt_mystletainn")
			{
				++this.m.Obtained;
				this.World.Flags.set("SwordAmbition_mystletainn", 1);				
			}						
		}
	}

	function getUIText()
	{
		return this.m.UIText + " (" + this.m.Obtained + "/7)";
	}	
	
	function onPartyDestroyed( _party )
	{
		if (!this.World.Flags.get("SwordAmbitionCount"))
		{
			this.World.Flags.set("SwordAmbitionCount", 1);			
		}		
	}	
	
	function onUpdateScore()
	{
		if (this.World.getTime().Days < 105)
		{
			return;
		}

		if (this.World.Ambitions.getAmbition("ambition.make_nobles_aware").isDone())
		{
			return;
		}

		this.m.Score = 500;
	}

	function onCheckSuccess()
	{
		this.CheckAbtswords();		
		this.World.Ambitions.updateUI();	
		if (this.m.Obtained >= 7)
		{
			return true;
		}
		return false;		
	}

	function onPrepareVariables( _vars )
	{	
	}

	function onSerialize( _out )
	{
		this.ambition.onSerialize(_out);
		_out.writeU8(this.m.Obtained);
	}

	function onDeserialize( _in )
	{
		this.ambition.onDeserialize(_in);
		this.m.Obtained = _in.readU8();
	}

});

