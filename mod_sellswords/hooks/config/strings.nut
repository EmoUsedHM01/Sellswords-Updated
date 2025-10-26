::Const.Strings.PerkDescription.LegendAthlete = ::Legend.tooltip(@"
You're a well-rounded athlete!

[color=%active%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Sprint[/color] skill which allows you to quickly cover four tiles in a straight line.

• Does not work across rough terrain or through enemy zones of control.

• Costs [color=%negative%]5[/color] AP and [color=%negative%]25[/color] Fatigue 

• Additionally, unlock the [color=%skill%]Climb[/color] skill which allows you to climb sheer cliffs up to five levels of height in one action.

• Does not trigger attacks of opportunity.

• Costs [color=%negative%]3[/color] AP and [color=%negative%]20[/color] Fatigue.

• Picking the perk will also add [color=%perk%]Furinkazan[/color] to your perk map, which reduces the cost of [color=%skill%]Sprint[/color] and [color=%skill%]Climb[/color].
");
::Const.Perks.PerkDefObjects[::Legends.Perk.LegendAthlete].Tooltip = ::Const.Strings.PerkDescription.LegendAthlete;

// ::Const.Strings.PerkDescription.LegendSmashingShields = ::Legend.tooltip(@"
//'If you can't get around it, try smashing through. It works!'
//
//[color=%passive%][u]Passive:[/u][/color]
//• Abilities targeting Shields do [color=%positive%]100%[/color] increased damage.
//
//• If a Shield is destroyed by [color=%skill%]Split Shield[/color], recover [color=%positive%]4[/color] Action Points and [color=%positive%]50%[/color] of the Fatigue cost.
//");
// ::Const.Perks.PerkDefObjects[::Legends.Perk.LegendSmashingShields].Tooltip = ::Const.Strings.PerkDescription.LegendSmashingShields;

::Const.Strings.PerkDescription.LegendSmackdown = ::Legend.tooltip(@"
Use your size and strength to bully your way into a prime position.

[color=%passive%][u]Passive:[/u][/color] 
• Effectiveness vs Armor is increased by [color=%positive%]+20%[/color]. The bonus is increased to [color=%positive%]+30%[/color] for Two-Handed Weapons.

[color=%passive%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Wind Up[/color] skill which prepares your next attack to [color=%status%]Knock Back[/color] and [color=%status%]Baffle[/color] your target on hit.
• [color=%status%]Baffled[/color] enemies suffer [color=%negative%]-15%[/color] Damage, Fatigue, and Initiative.

• Additionally, on hit, reduce targets AP by [color=%negative%]2[/color] for two turns.

• Costs [color=%negative%]2[/color] AP and [color=%negative%]10[/color] Fatigue.

• AP cost is reduced to [color=%negative%]1[/color] if wielding a Two-Handed Melee weapon. Works only with melee weapons, unarmed attacks and one handed slings. With one handed slings it will grant the [color=%skill%]Prepare Bullet[/color] effect.
");
::Const.Perks.PerkDefObjects[::Legends.Perk.LegendSmackdown].Tooltip = ::Const.Strings.PerkDescription.LegendSmackdown;

if (::Is_PTR_Exist)
{
	::Const.Strings.PerkDescription.LegendSpecStaffStun = ::Legend.tooltip(@"
Master the movements required to spin your staff in a great flourish so that it lands with additional force.

[color=%passive%][u]Passive:[/u][/color]
• Any strike with a Staff or Sling-Staff that would normally [color=%status%]Daze[/color], also [color=%status%]Stuns[/color] and [color=%status%]Staggers[/color]. This does not apply to AoE attacks.

• Staff Sweep now applies [color=%status%]Dazed[/color].

• [color=%skill%]Whack a' Smack[/color] gains [color=%positive%]+10%[/color] chance to hit.
");
}
else
{
	::Const.Strings.PerkDescription.LegendSpecStaffStun = ::Legend.tooltip(@"
Master the movements required to spin your staff in a great flourish so that it lands with additional force.

[color=%passive%][u]Passive:[/u][/color]
• Any strike with a Staff or Sling-Staff that would normally [color=%status%]Daze[/color], also [color=%status%]Stuns[/color] and [color=%status%]Staggers[/color]. This does not apply to AoE attacks.

• Staff Sweep now applies [color=%status%]Dazed[/color].
");
}

::Const.Perks.PerkDefObjects[::Legends.Perk.LegendSpecStaffStun].Tooltip = ::Const.Strings.PerkDescription.LegendSpecStaffStun;

::Const.Strings.PerkDescription.LegendTumble = ::Legend.tooltip(@"
Make use of your acrobatic skill to improve your movements.

[color=%passive%][u]Passive:[/u][/color]
• Reduces the Fatigue Cost of [color=%skill%]Lunge[/color], [color=%skill%]Footwork[/color], [color=%skill%]Leap[/color], [color=%skill%]Sprint[/color], [color=%skill%]Evasion[/color], and [color=%skill%]Audacious Charge[/color] by [color=%negative%]50%[/color].

• The Action Point cost of all these skills, except [color=%skill%]Lunge[/color], is reduced by [color=%negative%]1[/color] and that of [color=%skill%]Leap[/color] is reduced by [color=%negative%]3[/color].

• This is an upgraded version of [color=%perk%]Furinkazan[/color] and is not stackable.
");
::Const.Perks.PerkDefObjects[::Legends.Perk.LegendTumble].Tooltip = ::Const.Strings.PerkDescription.LegendTumble;

::Const.Strings.PerkDescription.LegendLastStand = ::Legend.tooltip(@"
'This is the hill that you will NOT die on!'

[color=%passive%][u]Passive:[/u][/color]
• Gain [color=%positive%]+1[/color] additional Melee and Ranged Defense for every [color=%negative%]2%[/color] of missing Hitpoints below [color=%negative%]66%[/color]

• Gain [color=%positive%]+1[/color] additional Action Points for every [color=%negative%]20%[/color] of missing Hitpoints.

• When below [color=%negative%]44%[/color] Hitpoints this character becomes immune to the effects of subsequent injuries, and moral is no longer affected by health loss.
");
::Const.Perks.PerkDefObjects[::Legends.Perk.LegendLastStand].Tooltip = ::Const.Strings.PerkDescription.LegendLastStand;

::Const.Strings.PerkDescription.Indomitable = ::Legend.tooltip(@"
'Mountains cannot be moved, nor taken down!'

[color=%passive%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Indomitable[/color] skill which grants a [color=%negative%]50%[/color] damage reduction, as well as immunity to being [color=%status%]Stunned[/color], [color=%status%]Knocked Back[/color], [color=%status%]Grabbed[/color], or [color=%status%]Swallowed[/color] for one turn.

• Base Resolve is [color=%positive%]doubled[/color] until the effect ends.
• Costs [color=%negative%]5[/color] AP and [color=%negative%]25[/color] Fatigue.
");
::Const.Perks.PerkDefObjects[::Legends.Perk.Indomitable].Tooltip = ::Const.Strings.PerkDescription.Indomitable;

::Const.Strings.PerkDescription.LegendTwirl = ::Legend.tooltip(@"
Practice in physical movement with a partner has given the ability to take the lead and move someone's body in a twirling movement.

[color=%passive%][u]Passive:[/u][/color]
 • The [color=%skill%]Rotation[/color] skill can now target enemies as well as allies. If you don't have [color=%perk%]Rotation[/color], taking this perk will grant you it for as long as you have this perk.

• Picking the perk will also add [color=%perk%]Furinkazan[/color] to your perk map, which reduces the cost of [color=%skill%]Rotation[/color].

• Costs [color=%negative%]3[/color] AP and [color=%negative%]25[/color] Fatigue.
");
::Const.Perks.PerkDefObjects[::Legends.Perk.LegendTwirl].Tooltip = ::Const.Strings.PerkDescription.LegendTwirl;

::Const.Strings.PerkDescription.QuickHands = ::Legend.tooltip(@"
Looking for this?

[color=%passive%][u]Passive:[/u][/color]
• Swapping an item in battle becomes a free action with no Action Point cost, once every turn.

• Does not work when swapping a Shield or between Two-Handed Melee Weapons.
");
::Const.Perks.PerkDefObjects[::Legends.Perk.QuickHands].Tooltip = ::Const.Strings.PerkDescription.QuickHands;

::Const.Strings.PerkDescription.LegendMuscularity = ::Legend.tooltip(@"
[color=%negative%][u]Requires:[/u] Melee or Throwing Weapon Attack[/color]
Put your full weight into every blow!

[color=%passive%][u]Passive:[/u][/color]
• Gain additional Minimum and Maximum Damage based on your current Hitpoints. 

• The bonus is [color=%positive%]1.5%[/color] of your current Hitpoints per AP for attacks with a base Action Point cost of 5 or less, and [color=%positive%]2%[/color] per AP for attacks with a base Action Point cost of 6 or more.

• The factor is reduced to [color=%negative%]60%[/color] for weapons that have a range of more than one tile and [color=%negative%]80%[/color] for Daggers and Goblin Swords.

• The bonus damage cannot be higher than [color=%positive%]40[/color] for attacks with a base Action cost of 5 or less and [color=%positive%]60[/color] for attacks with base AP cost of 6 or more.
");
::Const.Perks.PerkDefObjects[::Legends.Perk.LegendMuscularity].Tooltip = ::Const.Strings.PerkDescription.LegendMuscularity;

::Const.Strings.PerkDescription.Overwhelm = ::Legend.tooltip(@"
Learn to take advantage of your initiative and prevent the enemy from attacking effectively by overwhelming them with your attacks!

[color=%passive%][u]Active/Passive:[/u][/color]
• With every attack, hit or miss, against an opponent that acts after you in the current round, inflict [color=%status%]Overwhelmed[/color] which lowers both Melee and Ranged Skill by [color=%negative%]-10%[/color] for one turn.

• The effect stacks with each attack, up to a maximum of 7 times, and can be applied to multiple targets at once with a single attack.

• Additionally, unlocks the [color=%skill%]Quick Feint[/color] skill which allows you to apply [color=%status%]Overwhelmed[/color] to 4 adjacent targets, and can be used every other turn.

• Costs [color=%negative%]1[/color] AP and [color=%negative%]5[/color] Fatigue.
");
::Const.Perks.PerkDefObjects[::Legends.Perk.Overwhelm].Tooltip = ::Const.Strings.PerkDescription.Overwhelm;

::Const.Strings.PerkDescription.LegendBattleheart = ::Legend.tooltip(@"
Wade into the thick of battle, dodging blades from behind and above, aware of all around you at the heart of the battle.

[color=%passive%][u]Passive:[/u][/color]
• Being surrounded no longer affects this character's Defenses at all.

• Upgraded version of [color=%perk%]Underdog[/color], immune to [color=%perk%]Backstabber[/color].

• Also prevents moral checks upon enemies entering your Zone of Control.
");
::Const.Perks.PerkDefObjects[::Legends.Perk.LegendBattleheart].Tooltip = ::Const.Strings.PerkDescription.LegendBattleheart;

::Const.Strings.PerkDescription.Underdog = ::Legend.tooltip(@"
I'm used to it.

[color=%passive%][u]Passive:[/u][/color]
• The defense malus due to being surrounded by opponents is reduced by [color=%negative%]5[/color].

• If an attacker has the [color=%perk%]Strength In Numbers[/color] perk, the effect of that perk is negated, and the normal defense malus due to being surrounded is applied instead.
");
::Const.Perks.PerkDefObjects[::Legends.Perk.Underdog].Tooltip = ::Const.Strings.PerkDescription.Underdog;

::Const.Strings.PerkDescription.SunderingStrikes = ::Legend.tooltip(@"
Learn how to strike best at your targets' Armor to destroy it as fast as possible.

[color=%passive%][u]Passive:[/u][/color]
• Effectiveness against Armor is increased by [color=%positive%]20%[/color] of your weapon's Armor effectiveness.

• The bonus is increased to [color=%positive%]30%[/color] for Two-Handed Weapons.

• When unarmed, effectiveness against Armor is increased by [color=%positive%]20%[/color].
");
::Const.Perks.PerkDefObjects[::Legends.Perk.SunderingStrikes].Tooltip = ::Const.Strings.PerkDescription.SunderingStrikes;

::Const.Strings.PerkDescription.LegendShieldsUp = ::Legend.tooltip(@"
Drilling your troops in a shieldwall prepares their reaction time to avoid early deaths on the battlefield.

[color=%passive%][u]Passive:[/u][/color]
• Taking this perk ensures every mercenary with a shield will use [color=%skill%]Shieldwall[/color] or [color=%skill%]Fortify[/color] before the start of each battle.
");
::Const.Perks.PerkDefObjects[::Legends.Perk.LegendShieldsUp].Tooltip = ::Const.Strings.PerkDescription.LegendSlaughterer;

::Const.Strings.PerkName.LegendSlaughterer = "Slaughterer";
::Const.Perks.PerkDefObjects[::Legends.Perk.LegendSlaughterer].Name = ::Const.Strings.PerkName.LegendSlaughterer;
::Const.Strings.PerkDescription.LegendSlaughterer = ::Legend.tooltip(@"
A gruesome display, enemies are more likely to lose morale when they witness their allies get split in two.

[color=%passive%][u]Passive:[/u][/color]
• Melee kills are always fatalities.

• Fatalaties have a [color=%negative%]-10[/color] penalty to enemy Resolve checks.

• Having the 'Bloodthirsty' trait allows you to trigger an additional positive morale check when killing an enemy.
");
::Const.Perks.PerkDefObjects[::Legends.Perk.LegendSlaughterer].Tooltip = ::Const.Strings.PerkDescription.LegendSlaughterer;

::Const.Strings.PerkDescription.LegendCheerOn = ::Legend.tooltip(@"
[color=%negative%][u]Requires:[/u] Instrument or Banner[/color]
Use your way with song to cheer on an ally!

[color=%active%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Cheer On[/color] skill which grants [color=%positive%]+2[/color] Action Points to an adjacent ally.

• Costs [color=%negative%]3[/color] AP and [color=%negative%]10[/color] Fatigue.
");
::Const.Perks.PerkDefObjects[::Legends.Perk.LegendCheerOn].Tooltip = ::Const.Strings.PerkDescription.LegendCheerOn;

::Const.Strings.PerkDescription.LegendFavouredEnemyGhoul = ::Const.Strings.PerkDescription.LegendFavouredEnemyGhoul += "\n\n" + ::Legend.tooltip(@"

• When this character reaches a bonus of [color=%positive%]15%[/color], the perk point spent is refunded.
");
::Const.Perks.PerkDefObjects[::Legends.Perk.LegendFavouredEnemyGhoul].Tooltip = ::Const.Strings.PerkDescription.LegendFavouredEnemyGhoul;

::Const.Strings.PerkDescription.LegendFavouredEnemyHexen = ::Const.Strings.PerkDescription.LegendFavouredEnemyHexen += "\n\n" + ::Legend.tooltip(@"
• When this character reaches a bonus of [color=%positive%]15%[/color], the perk point spent is refunded.
");
::Const.Perks.PerkDefObjects[::Legends.Perk.LegendFavouredEnemyHexen].Tooltip = ::Const.Strings.PerkDescription.LegendFavouredEnemyHexen;

::Const.Strings.PerkDescription.LegendFavouredEnemyAlps = ::Const.Strings.PerkDescription.LegendFavouredEnemyAlps += "\n\n" + ::Legend.tooltip(@"
• When this character reaches a bonus of [color=%positive%]15%[/color], the perk point spent is refunded.
");
::Const.Perks.PerkDefObjects[::Legends.Perk.LegendFavouredEnemyAlps].Tooltip = ::Const.Strings.PerkDescription.LegendFavouredEnemyAlps;

::Const.Strings.PerkDescription.LegendFavouredEnemyUnhold = ::Const.Strings.PerkDescription.LegendFavouredEnemyUnhold += "\n\n" + ::Legend.tooltip(@"
• When this character reaches a bonus of [color=%positive%]15%[/color], the perk point spent is refunded.
");
::Const.Perks.PerkDefObjects[::Legends.Perk.LegendFavouredEnemyUnhold].Tooltip = ::Const.Strings.PerkDescription.LegendFavouredEnemyUnhold;

::Const.Strings.PerkDescription.LegendFavouredEnemyLindwurm = ::Const.Strings.PerkDescription.LegendFavouredEnemyLindwurm += "\n\n" + ::Legend.tooltip(@"
• When this character reaches a bonus of [color=%positive%]15%[/color], the perk point spent is refunded.
");
::Const.Perks.PerkDefObjects[::Legends.Perk.LegendFavouredEnemyLindwurm].Tooltip = ::Const.Strings.PerkDescription.LegendFavouredEnemyLindwurm;

::Const.Strings.PerkDescription.LegendFavouredEnemyDirewolf = ::Const.Strings.PerkDescription.LegendFavouredEnemyDirewolf += "\n\n" + ::Legend.tooltip(@"
• When this character reaches a bonus of [color=%positive%]15%[/color], the perk point spent is refunded.
");
::Const.Perks.PerkDefObjects[::Legends.Perk.LegendFavouredEnemyDirewolf].Tooltip = ::Const.Strings.PerkDescription.LegendFavouredEnemyDirewolf;

::Const.Strings.PerkDescription.LegendFavouredEnemySpider = ::Const.Strings.PerkDescription.LegendFavouredEnemySpider += "\n\n" + ::Legend.tooltip(@"
• When this character reaches a bonus of [color=%positive%]15%[/color], the perk point spent is refunded.
");
::Const.Perks.PerkDefObjects[::Legends.Perk.LegendFavouredEnemySpider].Tooltip = ::Const.Strings.PerkDescription.LegendFavouredEnemySpider;

::Const.Strings.PerkDescription.LegendFavouredEnemySchrat = ::Const.Strings.PerkDescription.LegendFavouredEnemySchrat += "\n\n" + ::Legend.tooltip(@"
• When this character reaches a bonus of [color=%positive%]15%[/color], the perk point spent is refunded.
");
::Const.Perks.PerkDefObjects[::Legends.Perk.LegendFavouredEnemySchrat].Tooltip = ::Const.Strings.PerkDescription.LegendFavouredEnemySchrat;

::Const.Strings.PerkDescription.LegendFavouredEnemyOrk = ::Const.Strings.PerkDescription.LegendFavouredEnemyOrk += "\n\n" + ::Legend.tooltip(@"
• When this character reaches a bonus of [color=%positive%]15%[/color], the perk point spent is refunded.
");
::Const.Perks.PerkDefObjects[::Legends.Perk.LegendFavouredEnemyOrk].Tooltip = ::Const.Strings.PerkDescription.LegendFavouredEnemyOrk;

::Const.Strings.PerkDescription.LegendFavouredEnemyGoblin = ::Const.Strings.PerkDescription.LegendFavouredEnemyGoblin += "\n\n" + ::Legend.tooltip(@"
• When this character reaches a bonus of [color=%positive%]15%[/color], the perk point spent is refunded.
");
::Const.Perks.PerkDefObjects[::Legends.Perk.LegendFavouredEnemyGoblin].Tooltip = ::Const.Strings.PerkDescription.LegendFavouredEnemyGoblin;

::Const.Strings.PerkDescription.LegendFavouredEnemyVampire = ::Const.Strings.PerkDescription.LegendFavouredEnemyVampire += "\n\n" + ::Legend.tooltip(@"
• When this character reaches a bonus of [color=%positive%]15%[/color], the perk point spent is refunded.
");
::Const.Perks.PerkDefObjects[::Legends.Perk.LegendFavouredEnemyVampire].Tooltip = ::Const.Strings.PerkDescription.LegendFavouredEnemyVampire;

::Const.Strings.PerkDescription.LegendFavouredEnemySkeleton = ::Const.Strings.PerkDescription.LegendFavouredEnemySkeleton += "\n\n" + ::Legend.tooltip(@"
• When this character reaches a bonus of [color=%positive%]15%[/color], the perk point spent is refunded.
");
::Const.Perks.PerkDefObjects[::Legends.Perk.LegendFavouredEnemySkeleton].Tooltip = ::Const.Strings.PerkDescription.LegendFavouredEnemySkeleton;

::Const.Strings.PerkDescription.LegendFavouredEnemyZombie = ::Const.Strings.PerkDescription.LegendFavouredEnemyZombie += "\n\n" + ::Legend.tooltip(@"
• When this character reaches a bonus of [color=%positive%]15%[/color], the perk point spent is refunded.
");
::Const.Perks.PerkDefObjects[::Legends.Perk.LegendFavouredEnemyZombie].Tooltip = ::Const.Strings.PerkDescription.LegendFavouredEnemyZombie;

::Const.Strings.PerkDescription.LegendFavouredEnemyNoble = ::Const.Strings.PerkDescription.LegendFavouredEnemyNoble += "\n\n" + ::Legend.tooltip(@"
• When this character reaches a bonus of [color=%positive%]15%[/color], the perk point spent is refunded.
");
::Const.Perks.PerkDefObjects[::Legends.Perk.LegendFavouredEnemyNoble].Tooltip = ::Const.Strings.PerkDescription.LegendFavouredEnemyNoble;

::Const.Strings.PerkDescription.LegendFavouredEnemyBandit = ::Const.Strings.PerkDescription.LegendFavouredEnemyBandit += "\n\n" + ::Legend.tooltip(@"
• When this character reaches a bonus of [color=%positive%]15%[/color], the perk point spent is refunded.
");
::Const.Perks.PerkDefObjects[::Legends.Perk.LegendFavouredEnemyBandit].Tooltip = ::Const.Strings.PerkDescription.LegendFavouredEnemyBandit;

::Const.Strings.PerkDescription.LegendFavouredEnemyBarbarian = ::Const.Strings.PerkDescription.LegendFavouredEnemyBarbarian += "\n\n" + ::Legend.tooltip(@"
• When this character reaches a bonus of [color=%positive%]15%[/color], the perk point spent is refunded.
");
::Const.Perks.PerkDefObjects[::Legends.Perk.LegendFavouredEnemyBarbarian].Tooltip = ::Const.Strings.PerkDescription.LegendFavouredEnemyBarbarian;

::Const.Strings.PerkDescription.LegendFavouredEnemySwordmaster = ::Const.Strings.PerkDescription.LegendFavouredEnemySwordmaster += "\n\n" + ::Legend.tooltip(@"
• When this character reaches a bonus of [color=%positive%]15%[/color], the perk point spent is refunded.
");
::Const.Perks.PerkDefObjects[::Legends.Perk.LegendFavouredEnemySwordmaster].Tooltip = ::Const.Strings.PerkDescription.LegendFavouredEnemySwordmaster;

::Const.Strings.PerkDescription.LegendFavouredEnemyMercenary = ::Const.Strings.PerkDescription.LegendFavouredEnemyMercenary += "\n\n" + ::Legend.tooltip(@"
• When this character reaches a bonus of [color=%positive%]15%[/color], the perk point spent is refunded.
");
::Const.Perks.PerkDefObjects[::Legends.Perk.LegendFavouredEnemyMercenary].Tooltip = ::Const.Strings.PerkDescription.LegendFavouredEnemyMercenary;

::Const.Strings.PerkDescription.LegendFavouredEnemyCaravan = ::Const.Strings.PerkDescription.LegendFavouredEnemyCaravan += "\n\n" + ::Legend.tooltip(@"
• When this character reaches a bonus of [color=%positive%]15%[/color], the perk point spent is refunded.
");
::Const.Perks.PerkDefObjects[::Legends.Perk.LegendFavouredEnemyCaravan].Tooltip = ::Const.Strings.PerkDescription.LegendFavouredEnemyCaravan;

::Const.Strings.PerkDescription.LegendFavouredEnemySoutherner = ::Const.Strings.PerkDescription.LegendFavouredEnemySoutherner += "\n\n" + ::Legend.tooltip(@"
• When this character reaches a bonus of [color=%positive%]15%[/color], the perk point spent is refunded.
");
::Const.Perks.PerkDefObjects[::Legends.Perk.LegendFavouredEnemySoutherner].Tooltip = ::Const.Strings.PerkDescription.LegendFavouredEnemySoutherner;

::Const.Strings.PerkDescription.LegendFavouredEnemyNomad = ::Const.Strings.PerkDescription.LegendFavouredEnemyNomad += "\n\n" + ::Legend.tooltip(@"
• When this character reaches a bonus of [color=%positive%]15%[/color], the perk point spent is refunded.
");
::Const.Perks.PerkDefObjects[::Legends.Perk.LegendFavouredEnemyNomad].Tooltip = ::Const.Strings.PerkDescription.LegendFavouredEnemyNomad;

// Need to overwrite this directly because weird
::Const.Strings.PerkDescription.LegendFavouredEnemyArcher = ::Legend.tooltip(@"
Many claim to be the greatest shot in the land, but none have outshot you yet.

[color=%passive%][u]Passive:[/u][/color]
• Grants [color=%positive%]+5%[/color] base bonus to melee skill, ranged skill, and maximum damage while fighting archer archetypes.

• Additionally, this bonus increases the more archer archetypes you kill and counts all kills made previously with this character retroactively.

• Increase per kill:
  - Master Archer | [color=%positive%]+0.5%[/color]
  - Bandit Marksman | [color=%positive%]+0.125%[/color]
  - Rabble Poacher | [color=%positive%]+0.025%[/color]
  - Bandit Poacher | [color=%positive%]+0.0625%[/color]
  - Militia Marksman | [color=%positive%]+0.05%[/color]
  - Arbalist | [color=%positive%]+0.25%[/color]
  - Slinger | [color=%positive%]+0.0125%[/color]
  - Goblin Ambusher | [color=%positive%]+0.0125%[/color]
  - Nomad Slinger | [color=%positive%]+0.0125%[/color]
  - Nomad Marksman | [color=%positive%]+0.25%[/color]
  - Gunner | [color=%positive%]+0.25%[/color]
  - Desert Stalker | [color=%positive%]+0.5%[/color]

• Also increases spawn rate of archer archetype champions.

• Reduces the penalty for attacking targets behind cover by [color=%negative%]33%[/color].

• Total bonus capped at 25%.

• When this character reaches a bonus of [color=%positive%]15%[/color], the perk point spent is refunded.
");
::Const.Perks.PerkDefObjects[::Legends.Perk.LegendFavouredEnemyArcher].Tooltip = ::Const.Strings.PerkDescription.LegendFavouredEnemyArcher;

::Const.Strings.PerkDescription.LegendInTheZone = ::Legend.tooltip(@"
Use your Armor's blend of protection and mobility to punish your foes mistakes!

[color=%passive%][u]Passive:[/u][/color]
• Gain a stacking buff that boosts your Melee Skill and Melee Damage by [color=%positive%]0.5%[/color] up to a maximum of [color=%positive%]10%[/color].

• Gain [color=%positive%]0.5%[/color] when you dodge a Melee attack and lose [color=%positive%]1%[/color] when you get hit by any attack.

• When engaged in Melee, the Melee Damage bonus is doubled, up to a maximum of [color=%positive%]20%[/color], and the Melee Skill bonus is converted into Melee Defense instead.

• If your Initiative is higher than twice your combined body and head Armor's penalty to Maximum Fatigue, you start the battle with stacks equal to your Armor's weight above 15.
");
::Const.Perks.PerkDefObjects[::Legends.Perk.LegendInTheZone].Tooltip = ::Const.Strings.PerkDescription.LegendInTheZone;

::Const.Strings.PerkDescription.LegendRebound = ::Legend.tooltip(@"
Surpass your limits!

[color=%passive%][u]Passive:[/u][/color]
• Fatigue regeneration is increased by [color=%positive%]+5[/color] while over 75% fatigued.
");
::Const.Perks.PerkDefObjects[::Legends.Perk.LegendRebound].Tooltip = ::Const.Strings.PerkDescription.LegendRebound;

::Const.Strings.PerkName.LegendPiercingShot = "Piercing Shot";
::Const.Perks.PerkDefObjects[::Legends.Perk.LegendPiercingShot].Name = ::Const.Strings.PerkName.LegendPiercingShot;
::Const.Strings.PerkDescription.LegendPiercingShot = ::Legend.tooltip(@"
[color=%negative%][u]Requires:[/u] Crossbow [/color]
Launch a shot so powerful it can hit two targets in a straight line.

[color=%passive%][u]Active/Passive:[/u][/color]
• Unlocks the [color=%skill%]Piercing Bolt[/color] skill which allows you to fire a powerful shot that can pass through your target, dealing [color=%negative%]50%[/color] damage to the enemy behind them.

• Additionally, Handgonnes gain [color=%positive%]+1[/color] range.

• Costs [color=%negative%]5[/color] AP and [color=%negative%]20[/color] Fatigue.
");
::Const.Perks.PerkDefObjects[::Legends.Perk.LegendPiercingShot].Tooltip = ::Const.Strings.PerkDescription.LegendPiercingShot;

::Const.Strings.PerkDescription.FastAdaption = ::Legend.tooltip(@"
Adapt to your opponent's moves!

[color=%passive%][u]Passive:[/u][/color]
• Gain an additional stacking [color=%positive%]+20%[/color] chance to hit with each attack that misses an opponent.

• Upon landing a hit, the character will also recover 1 Action Point for every stack up to a maximum of 3 and the bonus will be reset. The refund cannot exceed the maximum Action Points.
");
::Const.Perks.PerkDefObjects[::Legends.Perk.FastAdaption].Tooltip = ::Const.Strings.PerkDescription.FastAdaption;

::Const.Strings.PerkDescription.Fearsome = ::Legend.tooltip(@"
Make them scatter and flee!

[color=#4f1800][u]Passive:[/u][/color]
• Any attack that inflicts at least [color=%positive%]1[/color] point of damage to Hitpoints triggers a morale check for the opponent with a penalty equal to [color=%negative%]20%[/color] of your current Resolve.

[color=%negative%]Does not trigger multiple times from the same attacker on the same target in one attack.[/color]
");


::Const.Strings.PerkDescription.Fearsome = ::Legend.tooltip(@"
Make them scatter and flee!

[color=%passive%][u]Passive:[/u][/color]
• Any attack that inflicts at least [color=%positive%]1[/color] point of damage to hitpoints triggers a morale check for the opponent with a penalty equal to [color=%negative%]20%[/color] of your current Resolve.

• A kill [color=%positive%]triples[/color] this effect for your next attack, but if you miss the effect will be wasted.

•[color=%negative%] Does not trigger multiple times from the same attacker on the same target from a single attack[/color].
");
::Const.Perks.PerkDefObjects[::Legends.Perk.Fearsome].Tooltip = ::Const.Strings.PerkDescription.Fearsome;

::Const.Strings.PerkDescription.Adrenaline = ::Legend.tooltip(@"
Seize the initiative!

[color=%active%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Adrenaline[/color] skill which puts you first in the turn order for the next round, allowing you another turn before your enemies.

• Additionally adds [color=%perk%]Irresistible Impulse[/color] to your perk map, which grants additional benefits when using [color=%skill%]Adrenaline[/color].

• Costs [color=%negative%]1[/color] AP and [color=%negative%]20[/color] Fatigue.
");
::Const.Perks.PerkDefObjects[::Legends.Perk.Adrenaline].Tooltip = ::Const.Strings.PerkDescription.Adrenaline;

::Const.Strings.PerkDescription.ReachAdvantage = ::Legend.tooltip(@"
Learn to use the superior reach of large weapons to keep the enemy from getting close enough to land a good hit.

[color=%passive%][u]Passive:[/u][/color]
• When hitting an enemy, gain [color=%positive%]+100%[/color] of your Melee Skill as Melee Defense against them until waiting or ending your turn.

• Also, attempt to prevent them from approaching your Zone of Control with an attack of opportunity until next turn with a damage reduction of [color=%negative%]20%[/color].
");
::Const.Perks.PerkDefObjects[::Legends.Perk.ReachAdvantage].Tooltip = ::Const.Strings.PerkDescription.ReachAdvantage;

::Const.Strings.PerkDescription.Footwork = ::Legend.tooltip(@"
Work those feet!

[color=%passive%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Footwork[/color] skill which allows you to leave a Zone of Control without triggering free attacks by using skillful footwork.

• The Fatigue Cost of the skill increases by [color=%positive%]1[/color] for every 1 point of total penalty to maximum Fatigue from head and body Armor above 15, up to a maximum Fatigue Cost of [color=%negative%]20[/color].

• Picking the perk will also add [color=%perk%]Furinkazan[/color] to your perk map, which reduces the cost of [color=%skill%]Footwork[/color].

• Costs [color=%negative%]3[/color] AP and [color=%negative%]10[/color] Fatigue.
");
::Const.Perks.PerkDefObjects[::Legends.Perk.Footwork].Tooltip = ::Const.Strings.PerkDescription.Footwork;

::Const.Strings.PerkDescription.Rotation = ::Legend.tooltip(@"
Just like dancing with your nan when you were young.

[color=%active%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Rotation[/color] skill which allows two characters to switch places while ignoring Zone of Control, as long as neither character is [color=%status%]Stunned[/color], [color=%status%]Rooted[/color] or otherwise disabled.

• Picking this perk will also add [color=%perk%]Furinkazan[/color] to your perk map, which reduces the cost of [color=%skill%]Rotation[/color]

• Costs [color=%negative%]3[/color] AP and [color=%negative%]25[/color] Fatigue.
");
::Const.Perks.PerkDefObjects[::Legends.Perk.Rotation].Tooltip = ::Const.Strings.PerkDescription.Rotation;

::Const.Strings.PerkDescription.LegendEvasion = ::Legend.tooltip(@"
'Excuse me'

[color=%active%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Evasion[/color] skill which enables this character to move swiftly and safely through any Zone of Control for the next whole turn without incurring any free attacks.

• Picking this perk will also add [color=%perk%]Furinkazan[/color] to your perk map, which reduces the cost of [color=%skill%]Evasion[/color]

• Costs [color=%negative%]4[/color] AP and [color=%negative%]30[/color] Fatigue.
");
::Const.Perks.PerkDefObjects[::Legends.Perk.LegendEvasion].Tooltip = ::Const.Strings.PerkDescription.LegendEvasion;

::Const.Strings.PerkDescription.LegendChoke = ::Legend.tooltip(@"
Once an opponent is fatigued, it may be easier to choke them out than to fight through their Armor.

[color=%active%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Choke[/color] skill when both hands are free.

• [color=%status%]Choked[/color] enemies have their Fatigue Recovery reduced by [color=%negative%]15[/color].

• Damage inflicted is equal to the sum of your current Initiative divided by 4 and current Hitpoints divided by 5.

• Hit chance determined by your target's Fatigue, [color=%negative%]0%[/color] if they are fresh and [color=%positive%]100%[/color] if they are exhausted.

• For every point of your targets body Armor that exceeds 125, a penalty is applied to hit chance, up to a maximum of [color=%negative%]35%[/color].

• Hit chance is increased by [color=%positive%]+10%[/color] if your target is [color=%status%]Dazed[/color] or [color=%status%]Parried[/color], [color=%positive%]+15%[/color] if they are [color=%status%]Stunned[/color] or [color=%status%]Netted[/color], and [color=%positive%]+20%[/color] if they are [color=%status%]Grappled[/color] or [color=%status%]Sleeping[/color].

• If your target is [color=%status%]Grappled[/color], damage is increased by [color=%positive%]50%[/color].

• Costs [color=%negative%]4[/color] AP and [color=%negative%]20[/color] Fatigue.
");
::Const.Perks.PerkDefObjects[::Legends.Perk.LegendChoke].Tooltip = ::Const.Strings.PerkDescription.LegendChoke;

::Const.Strings.PerkDescription.LegendSpecUnarmed = ::Legend.tooltip(@"
Master the martial arts of unarmed combat.

[color=%passive%][u]Passive:[/u][/color]
• Reduces the Fatigue costs of [color=%skill%]Hand to Hand[/color], [color=%skill%]Kick[/color], [color=%skill%]Grapple[/color], and [color=%skill%]Tackle[/color] by [color=%negative%]25%[/color].

• Lowers AP cost for [color=%skill%]Hand to Hand[/color] by [color=%negative%]1[/color] and increases Fatigue inflicted by [color=%positive%]5[/color].

• [color=%skill%]Kick[/color] has its [color=%status%]Daze[/color] chance increased to [color=%positive%]50%[/color] and hit chance increased by [color=%positive%]15%[/color].

• [color=%skill%]Choke[/color] damage is increased by [color=%positive%]+50%[/color] when target is already [color=%status%]Choked[/color] or [color=%skill%]Grappled[/color].

• [color=%skill%]Grapple[/color] now has a [color=%positive%]100%[/color] chance to [color=%status%]Disarm[/color] on hit and the hit chance is increased by [color=%positive%]+10%[/color].

• [color=%skill%]Tackle[/color] gains [color=%positive%]+10%[/color] chance to hit.
");
::Const.Perks.PerkDefObjects[::Legends.Perk.LegendSpecUnarmed].Tooltip = ::Const.Strings.PerkDescription.LegendSpecUnarmed;

::Const.Strings.PerkDescription.HoldOut = ::Legend.tooltip(@"
Keep it together!

[color=%passive%][u]Passive:[/u][/color]
• Any negative status effect with a finite duration (e.g., [color=%status%]Bleeding[/color], [color=%status%]Charmed[/color]) has its duration reduced to one turn.

• Status effects that have their effects grow weaker over several turns (e.g. [color=%status%]Goblin Poison[/color]) are at their weakest state from the start.

• Grants a [color=%negative%]25%[/color] reduction to the effect of all negative statuses.

• Raises the chance to survive being struck down and not killed from [color=%negative%]33%[/color] to [color=%positive%]66%[/color].
");
::Const.Perks.PerkDefObjects[::Legends.Perk.HoldOut].Tooltip = ::Const.Strings.PerkDescription.HoldOut;

::Const.Strings.PerkDescription.LegendBarterGreed = ::Legend.tooltip(@"
This character is keen to guard the horde of gold the company has accumulated — and intends to protect it with their life.

[color=#4f1800][u]Passive:[/u][/color]
• For every 10,000 crowns you have in your stash:
- Gain [color=%positive%]+1.5[/color] to Melee Skill and Ranged Skill.
- Gain [color=%positive%]+1.5[/color] as Melee Defense and Ranged Defense.
- Gain [color=%positive%]+2[/color] to Resolve.

• The Bonus gained from Crowns above 80000 is reduced by [color=%negative%]20%[/color].

• Additionally, your global Barter is divided by [color=%negative%](1 + Brothers with this perk)[/color] at all times.
");


::Const.Strings.PerkDescription.LegendBarterGreed = ::Legend.tooltip(@"
Lust for gold and self interest can be a double edged sword, an immediate benefit in one place, may come at the expense of others. 

[color=%passive%][u]Passive:[/u][/color]
• Gain [color=%positive%]0.06%[/color] of your gear value as Melee and Ranged Skill.

• Gain [color=%positive%]0.08%[/color] of your gear value as Resolve.

• Gain [color=%positive%]0.04%[/color] of your gear value as Melee and Ranged Defense.

• This bonus will cap at [color=%positive%]+20[/color].

• Your global Barter is divided by [color=%negative%](1 + Brothers with this perk)[/color] at all times.
");
::Const.Perks.PerkDefObjects[::Legends.Perk.LegendBarterGreed].Tooltip = ::Const.Strings.PerkDescription.LegendBarterGreed;

::Const.Strings.PerkDescription.LegendBalance = ::Legend.tooltip(@"
Gain increased defense by balancing your Armor's weight and mobility.

[color=%passive%][u]Passive:[/u][/color]
• Gain [color=%positive%]+10[/color] Ranged Defense when wearing head and body Armor with a total weight of 15 or less.

• Convert [color=%negative%]1[/color] Ranged Defense to Melee Defense for every 2 points that you exceed this value, but reduce the conversion by [color=%negative%]1[/color] for every 10 points that your Current Initiative is below twice your total Armor weight.

• Gain a third of the converted Melee Defense bonus back as Ranged Defense.

• The penalty to Initiative from your accumulated Fatigue is also reduced by [color=%positive%]30%[/color].
");
::Const.Perks.PerkDefObjects[::Legends.Perk.LegendBalance].Tooltip = ::Const.Strings.PerkDescription.LegendBalance;

::Const.Strings.PerkDescription.LegendLithe = ::Legend.tooltip(@"
Specialize in Medium Armour! Not as nimble as some but more lithe than others!

[color=%passive%][u]Passive:[/u][/color]
• Damage to Hitpoints and Armor are reduced by [color=%positive%]25%[/color] when the total penalty to Maximum Fatigue from head and body Armor is between [color=%negative%]25[/color] and [color=%negative%]35[/color].

• Outside this range, the bonus drops exponentially.
");
::Const.Perks.PerkDefObjects[::Legends.Perk.LegendLithe].Tooltip = ::Const.Strings.PerkDescription.LegendLithe;

::Const.Strings.PerkDescription.Nimble = ::Legend.tooltip(@"
Specialize in Light Armour! By nimbly dodging or deflecting blows, convert any hits to glancing hits.

[color=%passive%][u]Passive:[/u][/color]
• Damage to Hitpoints is reduced by up to [color=%negative%]60%[/color] and damage to Armor is reduced by [color=%negative%]half[/color] of that amount.

• This bonus drops exponentially when wearing head and body Armor with a total penalty to Maximum Fatigue above 15.

• Provides [color=%positive%]+10%[/color] extra injury threshold.

• [color=%perk%]Brawny[/color] does not affect this perk.

• Does not affect damage from mental attacks or status effects.
");
::Const.Perks.PerkDefObjects[::Legends.Perk.Nimble].Tooltip = ::Const.Strings.PerkDescription.Nimble;

::Const.Strings.PerkDescription.SpecThrowing = ::Legend.tooltip(@"
Master throwing weapons to wound or kill the enemy before they even get close.

[color=%passive%][u]Passive:[/u][/color]
• Skills build up [color=%negative%]25%[/color] less Fatigue.

• Gain [color=%positive%]20%[/color] of your Ranged Skill as additional Armor penetration and [color=%positive%]25%[/color] of your Melee Skill as additional Armor effectiveness when attacking at a distance of three tiles or less.

• Throwing Spear now ignores the damage reduction from [color=%perk%]Shield Expert[/color].
");
::Const.Perks.PerkDefObjects[::Legends.Perk.SpecThrowing].Tooltip = ::Const.Strings.PerkDescription.SpecThrowing;

::Const.Strings.PerkDescription.SpecFlail = ::Legend.tooltip(@"
Master the flail and circumvent your opponent's defenses.

[color=%passive%][u]Passive:[/u][/color]
• Skills build up [color=%negative%]25%[/color] less Fatigue.

• [color=%skill%]Lash[/color] and [color=%skill%]Hail[/color] ignore the defense bonus of shields.

• [color=%skill%]Pound[/color] ignores an additional [color=%positive%]10%[/color] of Armor on hits to the head.

• [color=%skill%]Thresh[/color] gains [color=%positive%]+5%[/color] chance to hit.
");
::Const.Perks.PerkDefObjects[::Legends.Perk.SpecFlail].Tooltip = ::Const.Strings.PerkDescription.SpecFlail;

// ::Const.Strings.PerkDescription.LegendSpecialistButcher = ::Legend.tooltip(@"
//After years of relentless training, you have achieved mastery over your weapon.
//
//[color=%passive%][u]Passive:[/u][/color]
//• Gain [color=%positive%]+12[/color] Melee Skill while using a Butcher's Cleaver.
//
//• [color=%negative%]25%[/color] of this skill applies to One-Handed Cleavers, except Whips.
//
//• This percentage will grow from time with the company, rising by [color=%positive%]5%[/color] each week until you hit 100%.
//");
// ::Const.Perks.PerkDefObjects[::Legends.Perk.LegendSpecialistButcher].Tooltip = ::Const.Strings.PerkDescription.LegendSpecialistButcher;

//::Const.Strings.PerkDescription.LegendSpecialistHammerSkill = ::Legend.tooltip(@"
//After years of relentless training, you have achieved mastery over your weapon.
//
//[color=%passive%][u]Passive:[/u][/color]
//• Gain [color=%positive%]+12[/color] Melee Skill and [color=%positive%]+40%[/color] Armor damage while using a Blacksmith's Hammer.
//
//• [color=%negative%]25%[/color] of this skill applies to other One-Handed Hammers.
//
//• This percentage will grow from time with the company, rising by [color=%positive%]5%[/color] each week until you hit 100%.
//");
//::Const.Perks.PerkDefObjects[::Legends.Perk.LegendSpecialistHammerSkill].Tooltip = ::Const.Strings.PerkDescription.LegendSpecialistHammerSkill;
//
//::Const.Strings.PerkDescription.LegendSpecialistKnifeSkill = ::Legend.tooltip(@"
//After years of relentless training, you have achieved mastery over your weapon.
//
//[color=%passive%][u]Passive:[/u][/color]
//• Gain [color=%positive%]+12[/color] Melee Skill and [color=%positive%]+40%[/color] Armor penetration while using a Knife or Shiv.
//
//• [color=%negative%]25%[/color] of this skill applies to other Daggers.
//
//• This percentage will grow from time with the company, rising by [color=%positive%]5%[/color] each week until you hit 100%.
//");
//::Const.Perks.PerkDefObjects[::Legends.Perk.LegendSpecialistKnifeSkill].Tooltip = ::Const.Strings.PerkDescription.LegendSpecialistKnifeSkill;
//
//::Const.Strings.PerkDescription.LegendSpecialistMilitiaSkill = ::Legend.tooltip(@"
//After years of relentless training, you have achieved mastery over your weapon.
//
//[color=%passive%][u]Passive:[/u][/color]
//• Gain [color=%positive%]+12[/color] Melee Skill while using a Militia Spear, Ancient Spear or Wooden Spear.
//
//• [color=%negative%]25%[/color] of this skill applies to other spears.
//
//• This percentage will grow from time with the company, rising by [color=%positive%]5%[/color] each week until you hit 100%.
//");
//::Const.Perks.PerkDefObjects[::Legends.Perk.LegendSpecialistMilitiaSkill].Tooltip = ::Const.Strings.PerkDescription.LegendSpecialistMilitiaSkill;
//
//::Const.Strings.PerkDescription.LegendSpecialistPickaxeSkill = ::Legend.tooltip(@"
//After years of relentless training, you have achieved mastery over your weapon.
//
//[color=%passive%][u]Passive:[/u][/color]
//• Gain [color=%positive%]+12[/color] Melee Skill while using a Pickaxe.
//
//• [color=%negative%]25%[/color] of this skill applies to other Two-Handed Hammers..
//
//• This percentage will grow from time with the company, rising by [color=%positive%]5%[/color] each week until you hit 100%.
//");
//::Const.Perks.PerkDefObjects[::Legends.Perk.LegendSpecialistPickaxeSkill].Tooltip = ::Const.Strings.PerkDescription.LegendSpecialistPickaxeSkill;
//
//::Const.Strings.PerkDescription.LegendSpecialistPitchforkSkill = ::Legend.tooltip(@"
//After years of relentless training, you have achieved mastery over your weapon.
//
//[color=%passive%][u]Passive:[/u][/color]
//• Gain [color=%positive%]+12[/color] Melee Skill and [color=%positive%]+25%[/color] Armor damage while using a Pitchfork, Wooden Pitchfork, Hoe, Scythe or Wooden Flail.
//
//• [color=%negative%]25%[/color] of this perk applies to other Polearms and Banners.
//
//• This percentage will grow from time with the company, rising by [color=%positive%]5%[/color] each week until you hit 100%.
//");
//::Const.Perks.PerkDefObjects[::Legends.Perk.LegendSpecialistPitchforkSkill].Tooltip = ::Const.Strings.PerkDescription.LegendSpecialistPitchforkSkill;
//
//::Const.Strings.PerkDescription.LegendSpecialistShortbowSkill = ::Legend.tooltip(@"
//After years of relentless training, you have achieved mastery over your weapon.
//
//[color=%passive%][u]Passive:[/u][/color]
//• Gain [color=%positive%]+12[/color] ranged skill and 25% Armor penetration while using a Shortbow, Wonky Bow or Boondock Bow.
//
//• [color=%negative%]25%[/color] of this skill applies to other Bows.
//
//• This percentage will grow from time with the company, rising by [color=%positive%]5%[/color] each week until you hit 100%.
//");
//::Const.Perks.PerkDefObjects[::Legends.Perk.LegendSpecialistShortbowSkill].Tooltip = ::Const.Strings.PerkDescription.LegendSpecialistShortbowSkill;
//
//::Const.Strings.PerkDescription.LegendSpecialistShovelSkill = ::Legend.tooltip(@"
//After years of relentless training, you have achieved mastery over your weapon.
//
//[color=%passive%][u]Passive:[/u][/color]
//• Gain [color=%positive%]+12[/color] Melee Skill and the 'Knock Out' skill while using a Shovel.
//
//• [color=%negative%]25%[/color] of this bonus Melee Skill applies to Two-Handed Maces.
//
//• This percentage will grow from time with the company, rising by [color=%positive%]5%[/color] each week until you hit 100%.
//");
//::Const.Perks.PerkDefObjects[::Legends.Perk.LegendSpecialistShovelSkill].Tooltip = ::Const.Strings.PerkDescription.LegendSpecialistShovelSkill;
//
//::Const.Strings.PerkDescription.LegendSpecialistWoodaxeSkill = ::Legend.tooltip(@"
//After years of relentless training, you have achieved mastery over your weapon.
//
//[color=%passive%][u]Passive:[/u][/color]
//• Gain [color=%positive%]+12[/color] Melee Skill while using a Woodcutter's Axe or Saw.
//
//• [color=%negative%]25%[/color] of this bonus Melee Skill applies to other Axes.
//
//• This percentage will grow from time with the company, rising by [color=%positive%]5%[/color] each week until you hit 100%.
//");
//::Const.Perks.PerkDefObjects[::Legends.Perk.LegendSpecialistWoodaxeSkill].Tooltip = ::Const.Strings.PerkDescription.LegendSpecialistWoodaxeSkill;
//
//::Const.Strings.PerkDescription.LegendSpecialistSickleSkill = ::Legend.tooltip(@"
//After years of relentless training, you have achieved mastery over your weapon.
//
//[color=%passive%][u]Passive:[/u][/color]
//• Gain [color=%positive%]+12[/color] Melee Skill and [color=%positive%]+25%[/color] Armor piercing while using a Sickle or Notched Blade.
//
//• [color=%negative%]25%[/color] of this skill applies to one handed swords.
//
//• This percentage will grow from time with the company, rising by [color=%positive%]5%[/color] each week until you hit 100%.
//");
//::Const.Perks.PerkDefObjects[::Legends.Perk.LegendSpecialistSickleSkill].Tooltip = ::Const.Strings.PerkDescription.LegendSpecialistSickleSkill;

::Const.Strings.PerkDescription.Bullseye = ::Legend.tooltip(@"
Nailed it!

[color=%passive%][u]Passive:[/u][/color]
• The penalty to hitchance when shooting at a target you have no clear line of fire to is reduced from [color=%negative%]75%[/color] to [color=%negative%]33%[/color] for ranged weapons.

• Unlocks the [color=%skill%]Mark Target[/color] skill.

• Costs [color=%negative%]2[/color] AP and [color=%negative%]15[/color] Fatigue.
");
::Const.Perks.PerkDefObjects[::Legends.Perk.Bullseye].Tooltip = ::Const.Strings.PerkDescription.Bullseye;

::Const.Strings.PerkDescription.LegendLookout = ::Legend.tooltip(@"
Learn to find your enemies before they find you.

[color=%passive%][u]Passive:[/u][/color]
• This Character's Vision is increased by [color=%positive%]+1[/color] and the ranged penalty at night is reduced by [color=%negative%]50%[/color].

• Will pause the game when an enemy party is discovered nearby while travelling, allowing the party to avoid ambushes.

• While on duty in the scout tent they grant [color=%positive%]+10%[/color] scouting.
");
::Const.Perks.PerkDefObjects[::Legends.Perk.LegendLookout].Tooltip = ::Const.Strings.PerkDescription.LegendLookout;

::Const.Strings.PerkDescription.LegendNetRepair = ::Legend.tooltip(@"
Many years spent repairing and packing nets allows you to create nets and wield them more effectively.

[color=%passive%][u]Passive:[/u][/color]
• Unlocks the 'Net' recipe in the crafting tent, which you can use to fix broken ones.

• Grants [color=%positive%]+10[/color] Melee Defense while holding a net and reduces the AP cost of throwing nets to [color=%negative%]3[/color].

• Ignore the weight of nets, both when equipped and in your bag.
");
::Const.Perks.PerkDefObjects[::Legends.Perk.LegendNetRepair].Tooltip = ::Const.Strings.PerkDescription.LegendNetRepair;

::Const.Strings.PerkDescription.LegendNetCasting = ::Legend.tooltip(@"
Always keep a net handy!

[color=%passive%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Throw Portable Net[/color] skill which allows you to throw a makeshift net once per battle.

• Increases the range of all nets by [color=%positive%]2[/color] tiles.

• Allows you to swap nets to and from your bag for no AP.

• Costs [color=%negative%]4[/color] AP and [color=%negative%]25[/color] Fatigue.
");
::Const.Perks.PerkDefObjects[::Legends.Perk.LegendNetCasting].Tooltip = ::Const.Strings.PerkDescription.LegendNetCasting;

::Const.Strings.PerkDescription.LegendMasteryNets = ::Legend.tooltip(@"
You've learned advanced net throwing techniques.

[color=%passive%][u]Passive:[/u][/color]
• Reduce the Fatigue cost of throwing a net by [color=%negative%]25%[/color].

• Makes throwing other tools such as pots more effective.

• Nets you throw have a chance to be reusable in battle and can be picked up from the ground.

• If the target breaks free:
- Regular Nets have a [color=%positive%]25%[/color] chance to be reusable.
- Reinforced Nets have a [color=%positive%]50%[/color] chance to be reusable.

• If the target is killed before breaking free:
- All nets have a [color=%positive%]100%[/color] chance to be reusable.
");
::Const.Perks.PerkDefObjects[::Legends.Perk.LegendMasteryNets].Tooltip = ::Const.Strings.PerkDescription.LegendMasteryNets;

::Const.Strings.PerkDescription.LegendEscapeArtist = ::Legend.tooltip(@"
Others see it as magic, but your deft hands know better.

[color=%passive%][u]Passive:[/u][/color]
• Grants a chance to dodge nets with Ranged Defense.

• At the start of your turn, perform a free [color=%skill%]Break Free[/color] action.

• Grants a baseline [color=%positive%]95%[/color] chance to break yourself free from [color=%status%]Rooting[/color] effects, such as Nets and Webs.

• Reduces the Action Point cost of breaking yourself and your allies free by [color=%negative%]1[/color] and the Fatigue cost by [color=%negative%]70%[/color].
");
::Const.Perks.PerkDefObjects[::Legends.Perk.LegendEscapeArtist].Tooltip = ::Const.Strings.PerkDescription.LegendEscapeArtist;

::Const.Strings.PerkDescription.LegendPackleader = ::Legend.tooltip(@"
Dogs can instinctively identify a pack leader, and your knowledge of their habits allows you to become that leader.

[color=%passive%][u]Passive:[/u][/color]
• Unlocks the ability to store additional dog items in your bags and use them in battle.

• Grants each dog you unleash the [color=%perk%]Assured Conquest[/color] perk.

• Increases the total Armor of unleashed dogs by [color=%positive%]100%[/color].
");
::Const.Perks.PerkDefObjects[::Legends.Perk.LegendPackleader].Tooltip = ::Const.Strings.PerkDescription.LegendPackleader;

::Const.Strings.PerkDescription.LegendDogBreeder = ::Legend.tooltip(@"
Intimate knowledge of dog care and conditions required for breeding allows you to successfully breed dogs.

[color=%passive%][u]Passive:[/u][/color]
• Unlocks a recipe in the crafting tent for breeding dogs.

• Grants each dog you unleash the [color=%perk%]Fast Adaption[/color] and [color=%perk%]Backswing[/color] perks.

• Increases the Melee Skill of unleashed dogs by [color=%positive%]5[/color].
");
::Const.Perks.PerkDefObjects[::Legends.Perk.LegendDogBreeder].Tooltip = ::Const.Strings.PerkDescription.LegendDogBreeder;

::Const.Strings.PerkDescription.LegendDogHandling = ::Legend.tooltip(@"
You have mastered the art of training dogs. In the heat of battle your hounds will respond and react to your commands.

[color=%active%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Dog Handling[/color] skill which allows you to order dogs to attack, or defend allies.

• Grants each dog you unleash the [color=%perk%]Overwhelm[/color] perk.

• Increases the Melee Defense of unleashed dogs by [color=%positive%]5[/color].
");
::Const.Perks.PerkDefObjects[::Legends.Perk.LegendDogHandling].Tooltip = ::Const.Strings.PerkDescription.LegendDogHandling;

::Const.Strings.PerkDescription.LegendDogWhisperer = ::Legend.tooltip(@"
You have a way with dogs, the bond you form with them imbues each dog with more confidence and strength, knowing that you are there gives them strength.

[color=%passive%][u]Passive:[/u][/color]
• Grants each dog you unleash the [color=%perk%]Colossus[/color], [color=%perk%]Fortified Mind[/color], [color=%perk%]Underdog[/color], and [color=%perk%]Clarity[/color] perks.
");
::Const.Perks.PerkDefObjects[::Legends.Perk.LegendDogWhisperer].Tooltip = ::Const.Strings.PerkDescription.LegendDogWhisperer;

::Const.Strings.PerkDescription.LegendDogMaster = ::Legend.tooltip(@"
Your way with animals extends so far you can turn away dogs that would otherwise do you harm.

[color=%active%][u]Active:[/u][/color]
• By spending [color=%negative%]1[/color] item of food you can make a dog flee from battle.

• The food item is chosen at random and the perk does not work if you have less than 25 food.

• Additionally, grant each dog you unleash the [color=%perk%]Dodge[/color] perk.

• Costs [color=%negative%]4[/color] AP and [color=%negative%]15[/color] Fatigue.
");
::Const.Perks.PerkDefObjects[::Legends.Perk.LegendDogMaster].Tooltip = ::Const.Strings.PerkDescription.LegendDogMaster;

::Const.Strings.PerkDescription.LegendFieldTreats = ::Legend.tooltip(@"
Make liberal use of alcohol and food to motivate your mercenaries.

[color=%passive%][u]Active:[/u][/color]
• Spend [color=%negative%]20[/color] food to take an ally from wavering to steady moral and reduces their current Fatigue by [color=%negative%]-15%[/color]

• Cannot be applied to someone who has already been treated this combat.

• Costs [color=%negative%]4[/color] AP and [color=%negative%]15[/color] Fatigue.
");
::Const.Perks.PerkDefObjects[::Legends.Perk.LegendFieldTreats].Tooltip = ::Const.Strings.PerkDescription.LegendFieldTreats;

::Const.Strings.PerkDescription.LegendFieldTriage = ::Legend.tooltip(@"
Spend medicine to heal an ally mid-battle.

[color=%passive%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Field Triage[/color] skill which allows you to spend medicine to heal up to [color=%positive%]20%[/color] of a unit's missing health during a battle.

• Heals at a rate of [color=%negative%]3[/color] medicine for every [color=%positive%]4[/color] Hitpoints.

• Costs [color=%negative%]6[/color] AP and [color=%negative%]16[/color] Fatigue.
");
::Const.Perks.PerkDefObjects[::Legends.Perk.LegendFieldTriage].Tooltip = ::Const.Strings.PerkDescription.LegendFieldTriage;

::Const.Strings.PerkDescription.LegendFieldRepairs = ::Legend.tooltip(@"
Spend tools to repair an allies Armor on the battlefield.

[color=%passive%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Field Repairs[/color] skill which allows you to spend tools to repair up to [color=%positive%]20%[/color] of a unit's missing Armor during a battle.

• Repairs Armor at a rate of [color=%negative%]3[/color] tools for every [color=%positive%]10[/color] Armor

• Costs [color=%negative%]6[/color] AP and [color=%negative%]16[/color] Fatigue.
");
::Const.Perks.PerkDefObjects[::Legends.Perk.LegendFieldRepairs].Tooltip = ::Const.Strings.PerkDescription.LegendFieldRepairs;

::Const.Strings.PerkDescription.LegendSpecBandage = ::Legend.tooltip(@"
Master the art of bandaging mid-combat, using any cloth available.

[color=%passive%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Bandage[/color] skill which allows you to bandage your allies.

• Can bandage while in a zone of control, and adds [color=%positive%]+5[/color] Hitpoints on the target's following turn.

• Costs [color=%negative%]4[/color] AP and [color=%negative%]10[/color] Fatigue.
");
::Const.Perks.PerkDefObjects[::Legends.Perk.LegendSpecBandage].Tooltip = ::Const.Strings.PerkDescription.LegendSpecBandage;

//::Const.Strings.PerkDescription.LegendDrumsOfWar = ::Legend.tooltip(@"
//[color=%negative%][u]Requires:[/u] Instrument[/color]
//Learn powerful rhythms that drive your allies on.
//
//[color=%passive%][u]Active:[/u][/color]
//• Unlocks the [color=%skill%]War Chant[/color] skill which restores [color=%positive%]+4[/color] Fatigue to every ally within eight tiles.
//
//• Costs [color=%negative%]8[/color] AP and [color=%negative%]30[/color] Fatigue.
//");
//::Const.Perks.PerkDefObjects[::Legends.Perk.LegendDrumsOfWar].Tooltip = ::Const.Strings.PerkDescription.LegendDrumsOfWar;

//::Const.Strings.PerkDescription.LegendDrumsOfLife = ::Legend.tooltip(@"
//[color=%negative%][u]Requires:[/u] Instrument or Unarmed[/color]
//Learn powerful rhythms that drive your allies on.
//
//[color=%passive%][u]Active:[/u][/color]
//• Unlocks the [color=%skill%]Drums of Life[/color] skill which restores [color=%positive%]+8[/color] health to every ally within eight tiles.
//
//• Costs [color=%negative%]8[/color] AP and [color=%negative%]30[/color] Fatigue.
//");
//::Const.Perks.PerkDefObjects[::Legends.Perk.LegendDrumsOfLife].Tooltip = ::Const.Strings.PerkDescription.LegendDrumsOfLife;

::Const.Strings.PerkDescription.LegendThrowSand = ::Legend.tooltip(@"
It's hard to fight with sand in your eyes.

[color=%passive%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Throw Dirt[/color] skill, which lets you throw dirt in the eyes of an enemy to [color=%status%]Distract[/color] them.

• [color=%status%]Distracted[/color] enemies have [color=%negative%]-35%[/color] Initiative and deal [color=%negative%]-35%[/color] Damage.

• Costs [color=%negative%]3[/color] AP and [color=%negative%]5[/color] Fatigue.
");
::Const.Perks.PerkDefObjects[::Legends.Perk.LegendThrowSand].Tooltip = ::Const.Strings.PerkDescription.LegendThrowSand;

::Const.Strings.PerkDescription.LegendDebilitate = ::Legend.tooltip(@"
Ankles, hands, elbows and knees, you've learned how to fight dirty to secure victory.

[color=%active%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Debilitate[/color] skill which primes your next attack to [color=%status%]Cripple[/color] a target for three turns, reducing their ability to inflict damage by [color=%negative%]-25%[/color] and increasing the damage they take by [color=%positive%]+15%[/color].

• Costs [color=%negative%]2[/color] AP and [color=%negative%]15[/color] Fatigue.
");
::Const.Perks.PerkDefObjects[::Legends.Perk.LegendDebilitate].Tooltip = ::Const.Strings.PerkDescription.LegendDebilitate;

::Const.Strings.PerkDescription.Duelist = ::Legend.tooltip(@"
Become one with your weapon and go for the weak spots!

[color=%passive%][u]Passive:[/u][/color]
• When wielding a one handed weapon and your off hand is empty or you're holding an offhand throwable item, an extra [color=%positive%]+25%[/color] of damage ignores armor.

• Bucklers and parrying daggers gain half of this bonus.

• An extra [color=%positive%]+20%[/color] of damage ignores armor when using Two Handed or Throwing Weapons and having the [color=%perk%]Grandslam[/color] perk, but will reduce Armor Penetration by [color=%negative%]10%[/color] for One Handed weapons.

• Having [color=%perk%]Grandslam[/color] also increases Armor penetration and damage by [color=%positive%]50%[/color] when Unarmed.
");
::Const.Perks.PerkDefObjects[::Legends.Perk.Duelist].Tooltip = ::Const.Strings.PerkDescription.Duelist;

::Const.Strings.PerkDescription.LegendConservation = ::Legend.tooltip(@"
Conduct profane rituals meant to stave off the passage of time, further preserving the means of your craft.

[color=%passive%][u]Passive:[/u][/color]
• Reduces the daily medicine cost of maintaining Human Corpses, Bones, and other Carrion by [color=%negative%]50%[/color].
");
::Const.Perks.PerkDefObjects[::Legends.Perk.LegendConservation].Tooltip = ::Const.Strings.PerkDescription.LegendConservation;

::Const.Strings.PerkDescription.LegendChainLightning = ::Legend.tooltip(@"
Unleash an arcing barrage of lightning!

[color=%active%][u]Active:[/u][/color]
• Unlocks 'Chain Lightning' skill which inflicts damage to up to 3 enemies, dealing [color=%damage%]15-30[/color] damage which ignores armor.

• Requires a mystic staff.

• Costs [color=%negative%]7[/color] AP and [color=%negative%]50[/color] Fatigue.
• If you have the 'Staff Mastery' perk, reduce the AP cost by 2 and the base fatigue cost by [color=%negative%]25%[/color].
");
::Const.Perks.PerkDefObjects[::Legends.Perk.LegendChainLightning].Tooltip = ::Const.Strings.PerkDescription.LegendChainLightning;

::Const.Strings.PerkDescription.LegendHoldTheLine = ::Legend.tooltip(@"
'DON'T LET THEM BREAK THROUGH!'

[color=%active%][u]Active:[/u][/color]
• Unlocks the [color=#400080]Hold the Line[/color] skill which allows you to direct your troops to stand their ground, granting [color=%positive%]+10[/color] Defense and Resolve to all allies within four tiles for one turn.

• Costs [color=%negative%]5[/color] AP and [color=%negative%]20[/color] Fatigue.
");
::Const.Perks.PerkDefObjects[::Legends.Perk.LegendHoldTheLine].Tooltip = ::Const.Strings.PerkDescription.LegendHoldTheLine;


local poleWeaponStrings = [
	"SpecAxe",
	"SpecHammer",
	"SpecMace",
	"SpecPolearm",
	"SpecSpear"
];

foreach (s in poleWeaponStrings)
{
	::Const.Strings.PerkDescription[s] = ::MSU.String.replace(::Const.Strings.PerkDescription[s], "no longer has a penalty", "has a reduced penalty");
	::Const.Strings.PerkDescription[s] = ::MSU.String.replace(::Const.Strings.PerkDescription[s], "no longer have a penalty", "have a reduced penalty");
	::Const.Perks.PerkDefObjects[::Legends.Perk[s]].Tooltip = ::Const.Strings.PerkDescription[s];
}
