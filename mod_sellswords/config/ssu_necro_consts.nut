::Const.Necro <- {
	ConditionLossPerSixHour = 0.125,
	NoMaintainedMult = 1.0,
	HasMaintainedMult = 0.1,
	UndeadType = {
		Zombie = 0,
		Skeleton = 1,
		Vampire = 2,
		Mummy = 3,
		Ghost = 4,
		Banshee = 5,
		DemonHound = 6,
		COUNT =	6
	},
	CommonUndeadBackgrounds = [
		"ssu_necro_ancient_auxiliary",
		"ssu_necro_embalmbed_slave",
		"ssu_necro_zombie",
		
		"ssu_necro_ancient_legionary",
		"ssu_necro_ancient_honour_guard",
		"ssu_necro_embalmbed_soldier",
		"ssu_necro_embalmbed_priest",
		"ssu_necro_necrosavant",
		"ssu_necro_fallen_hero"
	],
	GhostUndeadBackgrounds = [
		"ssu_necro_ghost",
		"ssu_necro_banshee",
		"ssu_necro_skeledog"
	],
	BossUndeadBackgrounds = [
		"ssu_necro_lorekeeper"
	],
	InjuryPermanent = [
		[	// zombie
			{
				ID = "injury.missing_nose",
				Script = "injury_permanent/missing_nose_injury"
			},
			{
				ID = "injury.missing_eye",
				Script = "injury_permanent/missing_eye_injury"
			},
			{
				ID = "injury.missing_ear",
				Script = "injury_permanent/missing_ear_injury"
			},
			{
				ID = "injury.missing_finger",
				Script = "injury_permanent/missing_finger_injury"
			},
			{
				ID = "injury.missing_hand",
				Script = "injury_permanent/missing_hand_injury"
			},
		],
		[	// skeleton
			{
				ID = "injury.missing_finger",
				Script = "injury_permanent/missing_finger_injury"
			},
			{
				ID = "injury.missing_hand",
				Script = "injury_permanent/missing_hand_injury"
			},
		],
		[], // vampire
		[	// mummy
			{
				ID = "injury.missing_ear",
				Script = "injury_permanent/missing_ear_injury"
			},
			{
				ID = "injury.missing_finger",
				Script = "injury_permanent/missing_finger_injury"
			},
			{
				ID = "injury.maimed_foot",
				Script = "injury_permanent/maimed_foot_injury"
			},
			{
				ID = "injury.broken_elbow_joint",
				Script = "injury_permanent/broken_elbow_joint_injury"
			},
			{
				ID = "injury.missing_hand",
				Script = "injury_permanent/missing_hand_injury"
			},
		],
		[], // ghost
		[], // banshee
		[	// skeledog
			{
				ID = "injury.maimed_foot",
				Script = "injury_permanent/maimed_foot_injury"
			},
			{
				ID = "injury.broken_elbow_joint",
				Script = "injury_permanent/broken_elbow_joint_injury"
			},
		],
	]
};

::Const.Tactical.Actor.SsuNecroZombieDog <- {
	XP = 200,
	ActionPoints = 12,
	Hitpoints = 125,
	Bravery = 0,
	Stamina = 180,
	MeleeSkill = 60,
	RangedSkill = 0,
	MeleeDefense = 5,
	RangedDefense = 5,
	Initiative = 110,
	FatigueEffectMult = 0.1,
	MoraleEffectMult = 0.0,
	FatigueRecoveryRate = 20,
	Armor = [
		30,
		30
	]
};

// Stats of the skeletons called by Summon Skeleton, Legends removed its own summoned skeletons in 19.5
::Const.Tactical.Actor.SsuNecroSkeletonHigh <- {
	XP = 350,
	ActionPoints = 9,
	Hitpoints = 65,
	Bravery = 100,
	Stamina = 100,
	MeleeSkill = 75,
	RangedSkill = 0,
	MeleeDefense = 5,
	RangedDefense = 5,
	Initiative = 70,
	FatigueEffectMult = 0.0,
	MoraleEffectMult = 0.0,
	Armor = [
		0,
		0
	]
};

::Const.Tactical.Actor.SsuNecroSkeletonMed <- {
	XP = 250,
	ActionPoints = 8,
	Hitpoints = 55,
	Bravery = 100,
	Stamina = 100,
	MeleeSkill = 65,
	RangedSkill = 0,
	MeleeDefense = 0,
	RangedDefense = 0,
	Initiative = 65,
	FatigueEffectMult = 0.0,
	MoraleEffectMult = 0.0,
	Armor = [
		0,
		0
	]
};

::Const.Tactical.Actor.SsuNecroSkeletonLow <- {
	XP = 150,
	ActionPoints = 6,
	Hitpoints = 45,
	Bravery = 100,
	Stamina = 100,
	MeleeSkill = 55,
	RangedSkill = 0,
	MeleeDefense = 0,
	RangedDefense = 0,
	Initiative = 65,
	FatigueEffectMult = 0.0,
	MoraleEffectMult = 0.0,
	Armor = [
		0,
		0
	]
};
