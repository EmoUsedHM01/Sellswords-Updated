::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/legend_demon_hound_bite_skill", function( q ) {

	q.create = @(__original) function()
	{
		__original();
		this.m.Description = ::Mod_Sellswords.Strings.legend_demon_hound_bite_skill.Description;
		this.m.IconDisabled = "skills/legend_demon_hound_bite_bw.png";
		this.m.SoundOnHitHitpoints = [
			"sounds/enemies/werewolf_claw_hit_01.wav",
			"sounds/enemies/werewolf_claw_hit_02.wav",
			"sounds/enemies/werewolf_claw_hit_03.wav"
		];
		this.m.InjuriesOnBody = this.Const.Injury.CuttingAndPiercingBody;
		this.m.InjuriesOnHead = this.Const.Injury.CuttingAndPiercingHead;
		this.m.ChanceDisembowel = 33;
	}
	
	q.getTooltip = @(__original) function()
	{
		return this.getDefaultTooltip();
	}

});