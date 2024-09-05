::Const.LegendMod.ArmorObjs.extend([
	{
		ID = "necro/embalmbed_soldier_chest",
		Script = "",
		Sets = [{
			Cloth = [
				[1, "cloth/legend_bandages"]
			],
			Chain = [
			],
			Plate = [
			],
			Cloak = [
				[1, "cloak/necro_embalmbed_soldier_body"]
			],
			Tabard = [
			],
			Attachments =[
			]
		}]
	},
	{
		ID = "necro/embalmbed_priest_chest",
		Script = "",
		Sets = [{
			Cloth = [
				[1, "cloth/legend_bandages"]
			],
			Chain = [
			],
			Plate = [
			],
			Cloak = [
			],
			Tabard = [
				[1, "tabard/necro_embalmbed_priest_body"]
			],
			Attachments =[
			]
		}]
	}
]);

// Overwriting the base Lorekeeper equipment
local lich_armor = { 
	ID = "ancient/ancient_lich_attire",
	Script = "",
	Sets = [{
		Cloth = [
			[1, "cloth/legend_bandages"]
		],
		Chain = [
		],
		Plate = [
		],
		Cloak = [
			[1, "cloak/necro_lorekeeper_body"]		
		],
		Tabard = [
		],
		Attachments =[
		]
	}]
}

local lich_helmet = {
	ID = "ancient/ancient_lich_headpiece",
	Script = "",
	Sets = [{
		Hoods = [
			[1, "hood/legend_helmet_mummy_bandage"]
		],
		Helms = [
		],
		Tops = [
		],
		Vanity = [
			[1, "vanity/necro_lorekeeper_head"]
		]
	}]
}

::Const.LegendMod.ArmorObjs.push(lich_armor);
::Const.LegendMod.Armors[lich_armor.ID] <- lich_armor;
::Const.LegendMod.HelmObjs.push(lich_helmet);
::Const.LegendMod.Helmets[lich_helmet.ID] <- lich_helmet;