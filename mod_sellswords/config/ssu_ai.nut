
::Const.AI.Behavior.ID.GhostPossess <- ::Const.AI.Behavior.ID.COUNT;
::Const.AI.Behavior.ID.COUNT = ::Const.AI.Behavior.ID.COUNT + 1;
::Const.AI.Behavior.Name.push("GhostPossess");
::Const.AI.Behavior.Order.GhostPossess <- 39;
::Const.AI.Behavior.Score.GhostPossess <- 200;
::Const.AI.Behavior.GhostPossessNoTurnTarget <- 1.1;
::Const.AI.Behavior.GhostPossessRangedTarget <- 0.33;
::Const.AI.Behavior.GhostPossessSpearwallMult <- 2.0;
::Const.AI.Behavior.GhostPossessShieldwallMult <- 1.5;
::Const.AI.Behavior.GhostPossessRiposteMult <- 1.5;
::Const.AI.Behavior.GhostPossessMeleeBonus <- 1.25;
::Const.AI.Behavior.GhostPossessZoCMult <- 1.2;
::Const.AI.Behavior.GhostPossessInMeleeWithMe <- 2.0;
::Const.AI.Behavior.GhostPossessCanReachMe <- 1.5;

::Const.AI.Behavior.ID.SsuAssistance <- ::Const.AI.Behavior.ID.COUNT;
::Const.AI.Behavior.ID.COUNT = ::Const.AI.Behavior.ID.COUNT + 1;
::Const.AI.Behavior.Name.push("SsuAssistance");
::Const.AI.Behavior.Order.SsuAssistance <- ::Const.AI.Behavior.Order.AttackDefault;
::Const.AI.Behavior.Score.SsuAssistance <- ::Const.AI.Behavior.Score.Attack * 0.5;
::Const.AI.Behavior.SsuAssistanceMinHelpers <- 2;

::Const.AI.Behavior.ID.SsuEquipOffhand <- ::Const.AI.Behavior.ID.COUNT;
::Const.AI.Behavior.ID.COUNT = ::Const.AI.Behavior.ID.COUNT + 1;
::Const.AI.Behavior.Name.push("SsuEquipOffhand");
::Const.AI.Behavior.Order.SsuEquipOffhand <- ::Const.AI.Behavior.Order.SwitchToMelee;
::Const.AI.Behavior.Score.SsuEquipOffhand <- ::Const.AI.Behavior.Score.Attack * 4;
