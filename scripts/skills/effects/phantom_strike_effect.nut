this.phantom_strike_effect <- this.inherit("scripts/skills/skill", {
	m = {
		PhantomStacks = 0,
		LastRageSoundTime = 0,
		skillCount = 0,
		LastTargetID = 0
		
	},
	function create()
	{
		this.m.ID = "effects.phantom_strike";
		this.m.Name = "Phantom Strike";
		this.m.Icon = "skills/status_effect_256.png";
		this.m.Overlay = "status_effect_256";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsHidden = true;
        
	}

	function getDescription()
	{
		return "This charater has accumulated [color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.PhantomStacks + "[/color] charges for Phantom Strike";
	}

	function addPhantom( _r )
	{
	    
		this.m.PhantomStacks += _r;
		if(this.m.PhantomStacks < 0)
		{
		 this.m.PhantomStacks = 0;
	    }
	    if(this.m.PhantomStacks> 3)
	    {
	    this.m.PhantomStacks = 3;
	    }
		
	}

	function onUpdate( _properties )
	{
		
	}

	function onTurnStart()
	{
		this.m.PhantomStacks = this.Math.max(0, this.m.PhantomStacks - 1);
		
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
	   if (this.m.skillCount == this.Const.SkillCounter && this.m.LastTargetID == _targetEntity.getID() )
			{
				return;
			}

		this.m.skillCount = this.Const.SkillCounter;
		this.m.LastTargetID = _targetEntity.getID();
		this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(this.getContainer().getActor()) + " has connected with a phantom strike!");
		this.addPhantom(1);
	    
            
	    
		
	}
    function onTargetMissed(_skill, _targetEntity)
    {
      this.m.skillCount = this.Const.SkillCounter;
      this.m.LastTargetID = _targetEntity.getID();
      
    }
    function onCombatFinished()
	{
		this.m.PhantomStacks = 0;
	}
	

});

