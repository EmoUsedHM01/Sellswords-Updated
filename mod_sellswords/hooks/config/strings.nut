::Const.Perks.PerkDefObjects[::Legends.Perk.LegendAthlete].Tooltip = ::Const.Strings.PerkDescription.LegendAthlete;

::Const.Perks.PerkDefObjects[::Legends.Perk.LegendSmackdown].Tooltip = ::Const.Strings.PerkDescription.LegendSmackdown;

::Const.Perks.PerkDefObjects[::Legends.Perk.LegendLastStand].Tooltip = ::Const.Strings.PerkDescription.LegendLastStand;

::Const.Perks.PerkDefObjects[::Legends.Perk.Indomitable].Tooltip = ::Const.Strings.PerkDescription.Indomitable;

::Const.Perks.PerkDefObjects[::Legends.Perk.LegendTwirl].Tooltip = ::Const.Strings.PerkDescription.LegendTwirl;

::Const.Perks.PerkDefObjects[::Legends.Perk.QuickHands].Tooltip = ::Const.Strings.PerkDescription.QuickHands;

::Const.Perks.PerkDefObjects[::Legends.Perk.LegendMuscularity].Tooltip = ::Const.Strings.PerkDescription.LegendMuscularity;

::Const.Perks.PerkDefObjects[::Legends.Perk.Overwhelm].Tooltip = ::Const.Strings.PerkDescription.Overwhelm;

::Const.Perks.PerkDefObjects[::Legends.Perk.LegendBattleheart].Tooltip = ::Const.Strings.PerkDescription.LegendBattleheart;

::Const.Perks.PerkDefObjects[::Legends.Perk.Underdog].Tooltip = ::Const.Strings.PerkDescription.Underdog;

::Const.Perks.PerkDefObjects[::Legends.Perk.SunderingStrikes].Tooltip = ::Const.Strings.PerkDescription.SunderingStrikes;

::Const.Perks.PerkDefObjects[::Legends.Perk.LegendShieldsUp].Tooltip = ::Const.Strings.PerkDescription.LegendSlaughterer;
::Const.Perks.PerkDefObjects[::Legends.Perk.LegendSlaughterer].Tooltip = ::Const.Strings.PerkDescription.LegendSlaughterer;

::Const.Perks.PerkDefObjects[::Legends.Perk.LegendCheerOn].Tooltip = ::Const.Strings.PerkDescription.LegendCheerOn;

::Const.Perks.PerkDefObjects[::Legends.Perk.LegendInTheZone].Tooltip = ::Const.Strings.PerkDescription.LegendInTheZone;

::Const.Perks.PerkDefObjects[::Legends.Perk.LegendRebound].Tooltip = ::Const.Strings.PerkDescription.LegendRebound;

::Const.Perks.PerkDefObjects[::Legends.Perk.FastAdaption].Tooltip = ::Const.Strings.PerkDescription.FastAdaption;

::Const.Perks.PerkDefObjects[::Legends.Perk.Fearsome].Tooltip = ::Const.Strings.PerkDescription.Fearsome;

::Const.Perks.PerkDefObjects[::Legends.Perk.Adrenaline].Tooltip = ::Const.Strings.PerkDescription.Adrenaline;

::Const.Perks.PerkDefObjects[::Legends.Perk.ReachAdvantage].Tooltip = ::Const.Strings.PerkDescription.ReachAdvantage;

::Const.Perks.PerkDefObjects[::Legends.Perk.Footwork].Tooltip = ::Const.Strings.PerkDescription.Footwork;

::Const.Perks.PerkDefObjects[::Legends.Perk.Rotation].Tooltip = ::Const.Strings.PerkDescription.Rotation;

::Const.Perks.PerkDefObjects[::Legends.Perk.LegendEvasion].Tooltip = ::Const.Strings.PerkDescription.LegendEvasion;

::Const.Perks.PerkDefObjects[::Legends.Perk.HoldOut].Tooltip = ::Const.Strings.PerkDescription.HoldOut;

::Const.Perks.PerkDefObjects[::Legends.Perk.LegendBalance].Tooltip = ::Const.Strings.PerkDescription.LegendBalance;

::Const.Perks.PerkDefObjects[::Legends.Perk.LegendLithe].Tooltip = ::Const.Strings.PerkDescription.LegendLithe;

::Const.Perks.PerkDefObjects[::Legends.Perk.SpecThrowing].Tooltip = ::Const.Strings.PerkDescription.SpecThrowing;

::Const.Perks.PerkDefObjects[::Legends.Perk.SpecFlail].Tooltip = ::Const.Strings.PerkDescription.SpecFlail;

//
//
//
//
//
//
//
//

::Const.Perks.PerkDefObjects[::Legends.Perk.Bullseye].Tooltip = ::Const.Strings.PerkDescription.Bullseye;

::Const.Perks.PerkDefObjects[::Legends.Perk.LegendNetCasting].Tooltip = ::Const.Strings.PerkDescription.LegendNetCasting;

::Const.Perks.PerkDefObjects[::Legends.Perk.LegendMasteryNets].Tooltip = ::Const.Strings.PerkDescription.LegendMasteryNets;

::Const.Perks.PerkDefObjects[::Legends.Perk.LegendEscapeArtist].Tooltip = ::Const.Strings.PerkDescription.LegendEscapeArtist;

::Const.Perks.PerkDefObjects[::Legends.Perk.LegendDogHandling].Tooltip = ::Const.Strings.PerkDescription.LegendDogHandling;

::Const.Perks.PerkDefObjects[::Legends.Perk.LegendDogWhisperer].Tooltip = ::Const.Strings.PerkDescription.LegendDogWhisperer;

::Const.Perks.PerkDefObjects[::Legends.Perk.LegendThrowSand].Tooltip = ::Const.Strings.PerkDescription.LegendThrowSand;

::Const.Perks.PerkDefObjects[::Legends.Perk.Duelist].Tooltip = ::Const.Strings.PerkDescription.Duelist;

::Const.Perks.PerkDefObjects[::Legends.Perk.LegendConservation].Tooltip = ::Const.Strings.PerkDescription.LegendConservation;

::Const.Perks.PerkDefObjects[::Legends.Perk.LegendChainLightning].Tooltip = ::Const.Strings.PerkDescription.LegendChainLightning;

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
