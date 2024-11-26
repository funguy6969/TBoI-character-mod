local CharacterBuilder = include("lib.CharacterTemplateLib")

-- first we make a new character
local alpha = CharacterBuilder.newCharacterSet("Alpha")
--[[
	When calling newCharacter you can pass in the characters name to set that
	you can also pass in false if this character does not have a tainted variant

	if your tainted character has a different name you will need to set it afterwards
	by doing:
	
	Alpha.tainted.name = "" -- name here

	however, the base game gives the tainted and regular variant of a character the same name in the code
	so if you want to be like the game, it should be the same.
]]

-- next we setup all the characters stuff:
-- Note: anything you don't want you don't need to put, just remove it


--[[
	To add a costume you do
	Character:AddCostume(ID)
	
	you can do this multiple times if you have multiple costumes.

	If your character does not have a costume you can remove this line

	NOTE: your anm2 must be in ".\resources\gfx\characters" or it will not be found.
]]
   alpha:addItem(CollectibleType.COLLECTIBLE_TELEKINESIS, true)
   alpha:addItem(CollectibleType.COLLECTIBLE_ANTI_GRAVITY, true)
   alpha:addItem(CollectibleType.COLLECTIBLE_HOLY_LIGHT, true)
   alpha:addItem(CollectibleType.COLLECTIBLE_BREAKFAST, true)

--[[
  For every item you want to add to your character repeat this line.
  character:AddItem(ItemID, RemoveCostume)
  
  ItemID is the item ID you want to add, you can use the CollectibleType Enum to make this easier (like shown in the example)
  
  RemoveCostume is if you want to remove that items' costume.
  Put true if you want to remove it.
  Put false or just don't include it if you want to keep the costume.
  
  If you do not want to add any items to this character, just remove all of these lines.
	  
  You can find a list of avaliable CollectibleType's here: https://wofsauge.github.io/IsaacDocs/rep/enums/CollectibleType.html
]]


--[[
	Use the above line to give the character a starting trinket.
	If you do not want a starting trinket, just remove this line

	You can find a list of avaliable TrinketType's here: https://wofsauge.github.io/IsaacDocs/rep/enums/TrinketType.html
]]


--[[
	Use the above line to give the character a starting PocketItem.
	
	It can be either a card like above
	or a pill

	if you want a pill you need to do
	SetPocketItem(CardID, true) -- true means that your telling the template that this is a pill not a card.

	if you do not want a starting PocketItem you can just remove this line.

	You can find a list of avaliable Cards here: https://wofsauge.github.io/IsaacDocs/rep/enums/Card.html
	You can find a list of avaliable PillEffect's here: https://wofsauge.github.io/IsaacDocs/rep/enums/PillEffect.html

	NOTE: Exclusive, you cannot give both a Card and a Pill
]]

alpha:setCharge(1) -- set the starting charge for your Active item, the value must be greater than 0 or true
--[[
	Use the above line to give your starting active item a default charge
	if you have no active item, or you want no charges, you can just remove this line.
	set to a number for specific charges
	set to true for full charge :)
]]

-- next we need to setup our players stats
local normalStats = CharacterBuilder.newStatTable() -- create a new stat table
normalStats.Damage = 4.50
normalStats.Shotspeed = 1.00
normalStats.Range = 2.10
normalStats.Speed = 1.10
normalStats.Tearcolor = Color(1.0, 1.0, 1.0, 1.0, 0, 0, 1) -- Color, first four arguments between 0 and 1
normalStats.Flying = false
normalStats.Luck = -2.00

normalStats.criticalChance = 0
normalStats.criticalMultiplier = 2
--[[
	These two stats are for if the user is Running the Critical Hit Lib

	Critical Chance is how often you can crit, it is a value between 0 and 1
	Defaults to 0
	Critical Multiplier is how much your damage is multiplied by, it is a value between 0.01 - inf
	(Yes, this means your critical multiplier can actually reduce your damage)
	Defaults to 2x

	if you do not set these stats and they are running your character will simply start with no critchance and 2x crit multiplier
]]

alpha:setStats(normalStats)

--[[
    TearFlags.TEAR_LIGHT_FROM_HEAVEN
]]

--alpha:setHeartType(2) -- lets you set the character to be a blackheart or soulheart only character
-- USE AT YOUR OWN RISK!

--[[
	TAINTED CHARACTER SETUP

	Now do it all again for your tainted character :)
]]
alpha:setTrinket(TrinketType.TRINKET_SWALLOWED_PENNY, true)
-- its just like above, except we add a "true" onto the end to tell the template that this is the tainted variant were talking about

alpha:addItem(CollectibleType.COLLECTIBLE_INNER_EYE, false, true) -- I want Sad Onion and give me the costume.
-- again just like above, except we need to add true as the third option to let the template know were talking about the tainted variant

alpha:setPocketItem(PillEffect.PILLEFFECT_BAD_GAS, true, true) -- this is a pill, so the second option is true, and third option tells the template its the tainted variant
-- even if this is a card you would need the third option
-- so it would look like "Alpha:SetPocketItem(CardType, false, true)" meaning, its a card so set the second one to false, and third tells the template its the tainted variant

local taintedStats = CharacterBuilder.newStatTable() -- create a new stat table
taintedStats.Damage = 5.50
taintedStats.Firedelay = 3.73
taintedStats.Shotspeed = 2.00
taintedStats.Range = 7.50
taintedStats.Speed = 2.00
taintedStats.Tearflags = TearFlags.TEAR_POISON | TearFlags.TEAR_FREEZE
taintedStats.Tearcolor = Color(1.0, 1.0, 1.0, 1.0, 0, 0, 0) -- Color, first four arguments between 0 and 1
taintedStats.Flying = false
taintedStats.Luck = 1.00

alpha:setStats(taintedStats, true) -- true again at the end, getting the idea now?

--[[
	--MORE INFO:--
	
	--Tear Color Info:--
	for tearcolor the first 4 numbers are the color of the base tear, and the last 3 numbers are for the "overlay" tear color
	default value is (1,1,1,1,0,0,0)

	color is R,G,B,A,R0,G0,B0
	Red
	Green
	Blue
	Alpha (Transparency)
	Red offset
	Green offset
	Blue Offset

	The first four numbers are normalized between 0 and 1, basically to get a normalized RGB value take the RGB value from 0-255 and divide by 255. thats the normalized number.
	
	Offset values are input directly as 0-255 instead of being normalized.
	
	--Item Info:--
	For vanilla items, here are links to vanilla Enumerators:
	Vanilla Items: https://wofsauge.github.io/IsaacDocs/rep/enums/CollectibleType.html
	Trinkets: https://wofsauge.github.io/IsaacDocs/rep/enums/TrinketType.html
	Cards: https://wofsauge.github.io/IsaacDocs/rep/enums/Card.html
	Pills: https://wofsauge.github.io/IsaacDocs/rep/enums/PillColor.html

	For modded items, use these functions instead:
	Isaac.GetItemIdByName("CUSTOMITEM")
	Isaac.GetPillEffectByName("CUSTOMPILL")
	Isaac.GetCardIdByName("cardHudName")
	Isaac.GetTrinketIdByName("trinketName")
	Make sure to use the same name as in the items.xml file.
]]

return CharacterBuilder.build() -- last thing we call to tell the character builder were done.
