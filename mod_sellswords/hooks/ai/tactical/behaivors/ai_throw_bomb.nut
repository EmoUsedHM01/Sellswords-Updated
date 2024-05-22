::Mod_Sellswords.HooksMod.hook("ai/tactical/behaviors/ai_throw_bomb", function ( q )
{
	q.m.BombsMax = 1;
});
