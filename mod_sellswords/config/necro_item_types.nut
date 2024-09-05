::Const.Items.addNewItemType("Ancient", "Ancient Item");

local ancient_weapons = this.IO.enumerateFiles("scripts/items/weapons/ancient");
ancient_weapons.extend([
	"scripts/items/weapons/named/legend_named_gladius",
	"scripts/items/weapons/named/named_bladed_pike",
	"scripts/items/weapons/named/named_crypt_cleaver",
	"scripts/items/weapons/named/named_khopesh",
	"scripts/items/weapons/named/named_legend_great_khopesh",
	"scripts/items/weapons/named/named_warscythe"
]);

foreach (directory in ancient_weapons)
{
	::Mod_Sellswords.HooksMod.hook(directory, function( q ) {

		q.create = @(__original) function()
		{
			__original();
			this.m.ItemType = this.m.ItemType | this.Const.Items.ItemType.Ancient;
		}

	})
}