# Hi
Hey, im Schokokeksrepublik, if you want some features, if you find a bug, let me know (on Github or Steam).


# Whats new
First of all, after some crashing and so on, i started everything from scratch again. New stuff is:
Timers, Talents, example Modifier, example Ability, Startitems, Thinker, so basically the files you find inside game/dota_addons/addon_template_butt/scripts/vscripts/.

# Use This Template
Either you make this the default template by copying everything from addon_template_butt into addon_template of game and content (before you create yours), or you copy the files into every new mod you make.
After that you can start the game inside Hammer just by clicking the "Game Controller Icon" and "Run (Skip Build)".

# Startitems
Lets you add free Items, Abilities, Talents or Modifiers, that everyone gets.

# Thinker
Events that triggers at a timer. Give free Rapiers after 20 Minutes or teleport everyone to the midlane (hero:SetAbsOrigin(Vector(0,0,120))) every 5 Minutes.

# Talents
If you want to add a new Talents, you have to add it to the game/..../scripts/npc/npc_abilites_custom.txt , and create a file in game/..../scripts/vscripts/talents/ as like the example talent.

To add it to the heroes you put it into startitems or you edit the kv files for each hero.

# Filters
You can modify some values like Damage, Heal, Gold or Experience. Keep the return true or the event will cancel (e.g. No Damage will be harmed)

# Abilities
If you want to add a new Ability, you can give it to every hero in the startitems.lua file or add it to the heroes manually inside the kv files. Abilites must be added into npc_abilities_custom.txt

# Modifiers
Modifiers are Buffs or Debuffs. The advantage of Modifiers is, that you dont have to edit the KV files, they are only in lua. To use them you have to use LinkLuaModifier(name, filepath, LUA_MODIFIER_MOTION_NONE) and then you can add them to the heroes or so.

You can add them to some events, like entity_spawned, entity_killed, or so. Modifiers have a little odd thing, that they technically exist twice, once on the players computer and once on the server, thats maybe good to keep in mind.

Modifiers can do stuff on a lot of events, found in the API. For that you have to add the CONSTANT in DeclareFunctions and add the function also to the .lua file. Most of the events are triggered on the whole map, not only the hero.

# Settings
The Loadscreen settings. Feel free to balance your game here.

# Lua Tipps
-- This is a comment (not Code)

If you have a typo in a file, the whole file turns useless.

If you have a function, e.g. function examplemodifier:OnAttackLanded(event), you can read the whole event on the console using:
"for k,v in pairs(event) do print("OnAttackLanded:",k,v) end"
Sometimes events might miss a value (like event.attacker).
The console can be opened in Dota (depending on your key assignment) or from asset browser. Filter for "VScript".

Arrays (or tables as they are called in lua) usually start with 1, but some Dota Stuff, like PlayerIDs start with 0, since they originally come from the C++ hardcode of Dota.

A lua table, e.g. "local herovalues = { antimag = 12, centaur = 5 }" can be accessed (or values can be added) with "herovalues.antimag" (=12) or "heorovalues["antimag"]". Numerial entries can be initiated like "local bestfood = { [1]="peppers", [2]="meat" }".

If a variable has no value, it is "nil" and acts like false. (So you can do "if (test) then..." instead of "if (not test\~=nil)").

If a function gets not enough parameters, it fills up with nil ("asd:whtvr(hero,nil)" equals to "asd:whtvr(hero)").

This "hero:GetLevel()" equals to "hero.GetLevel(hero)". "if (hero.GetLevel) then test = hero:GetLevel() end" can be used to ensure this function exists.

Creeps actually dont spawn at 00:00, 00:30 and so on, they spawn earlier and become teleported to the spawn after.

# Links
Lua API : https://developer.valvesoftware.com/wiki/Dota_2_Workshop_Tools/Scripting/API

(Important Sections: CDOTA_BaseNPC, CDOTA_BaseNPC_Hero, PlayerResource and the very Bottom with the CONSTANTS)
(I spent a lot of time here, use CTRL+F and type "setgold" or so)
Built-In Modifiers: https://developer.valvesoftware.com/wiki/Dota_2_Workshop_Tools/Scripting/Built-In_Modifier_Names
(some are broken if used manually)
Built-In Abilities: https://developer.valvesoftware.com/wiki/Dota_2_Workshop_Tools/Scripting/Built-In_Ability_Names

Dota Imba: https://github.com/EarthSalamander42/dota_imba/tree/master/game/dota_addons/dota_imba_reborn/scripts/vscripts/components

How can i code a blademail/ fury swipes/ whatever on my own? Look here (Intermediate level)

Volvo Recipe for lua Ability/Modifier: https://developer.valvesoftware.com/wiki/Dota_2_Workshop_Tools/Lua_Abilities_and_Modifiers

Volvo Recipe for Game Events: https://developer.valvesoftware.com/wiki/Dota_2_Workshop_Tools/Scripting/Listening_to_game_events

# Map Editing
Being done from Hammer, you can add and delete stuff (trees), alter the heights inside the map, move the spawnpoints or waypoints of creeps. If you edit the object properties you also can add trigger events, for example on a Roshan kill or so.
