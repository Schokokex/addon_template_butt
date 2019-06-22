# Hi
Hey, im Schokokeksrepublik, if you want some features, if you find a bug, let me know (on Github or Steam).


# Whats new
First of all, after some crashing and so on, i started everything from scratch again. New stuff is:
Timers, Talents, example Modifier, example Ability, Startitems, Thinker, so basically the files you find inside game/dota_addons/addon_template_butt/scripts/vscripts/.

# Use This Template
Either you make this the default template by copying everything from addon_template_butt into addon_template of game and content (before you create yours), or you copy the files into every new mod you make.
After that you can start the game inside Hammer just by clicking the "Game Controller Icon" and "Run (Skip Build)".

# KV Files
The KV files are the files inside game/.../scripts/npc/. To modify a hero, an ability or so, copy the whole bracket section into the custom file. It works also if you delete the values, that you dont change.

# Startitems
Lets you add free Items, Abilities, Talents or Modifiers, that everyone gets.
Abilities can start with cooldown, a certain level or can be casted initially and more (as shown in the file).

# Thinker
Events that triggers at a timer. Give free Rapiers after 20 Minutes or teleport everyone to the midlane (hero:SetAbsOrigin(Vector(0,0,120))) every 5 Minutes.
<br/><sub><b>TP everyone to the midlane</b></sub><br/>
<img src="https://raw.githubusercontent.com/Jochnickel/addon_template_butt/images/game/dota_addons/addon_template_butt/5minTP.png" />

# Filters
You can modify some values like Damage, Heal, Gold or Experience. Keep the return true or the event will cancel (e.g. No Damage will be harmed). If you want to modify the values, for example the gold, you have change the "event.gold" value (r.g. "event.gold = event.gold / 2").
<br/><sub><b>More RNG in Abilites</b></sub><br/>
<img src="https://raw.githubusercontent.com/Jochnickel/addon_template_butt/images/game/dota_addons/addon_template_butt/Filter1.png" />

# Talents
If you want to add a new Talents, you have to add it to the game/..../scripts/npc/npc_abilites_custom.txt , and create a file in game/..../scripts/vscripts/talents/ as like the example talent.
Make sure to start the name in npc_abilites_custom.txt with "special_bonus_" and the modifier file name with "modifier_special_bonus_".

To add it to the heroes you put it into startitems or you edit the npc_heroes_custom.txt file for the hero. Talents are at Ability10 to Ability17 (10 is bottom right, 11 bottom left and so on).

# Abilities
If you want to add a new Ability, you can give it to every hero in the startitems.lua file or add it to the heroes manually inside the npc_heroes_custom.txt file. Abilites must be added into npc_abilities_custom.txt, where you put the right path to the lua script file.


# Modifiers
Modifiers are Buffs or Debuffs. The advantage of Modifiers is, that you dont have to edit the KV files, they are only in lua. If you want to use delayed stuff, they become necessary, because they have StartIntervalThink and OnIntervalThink. To use them you can use unit:AddNewModifierButt(unit, nil, modifiername, {}), which automatically looks for it in the modifier folder. The Valve provided unit:AddNewModifier(unit, nil, modifiername, {}) can only use modifiers that are already added to the game (with LinkLuaModifier(modifiername, path, 0)).

You can add them to some events, like entity_spawned, entity_killed, or so. Modifiers have a little odd thing, that they technically exist twice, once on the players computer and once on the server, thats maybe good to keep in mind (If you check Dota Imba in Github from EarthSalamander42, you might often see IsServer(), thats because of the duality).

Modifiers can do stuff on a lot of events, found in the API. For that you have to add the CONSTANT in DeclareFunctions and add the function also to the .lua file. Most of the events are triggered on the whole map, not only the hero.
<sub><b>DeclareFunctions is great</b></sub><br/>
<img src="https://raw.githubusercontent.com/Jochnickel/addon_template_butt/images/game/dota_addons/addon_template_butt/DeclareFuncs.png" /><br/>
<sub><b>Can be used to call event functions</b></sub><br/>
<img src="https://raw.githubusercontent.com/Jochnickel/addon_template_butt/images/game/dota_addons/addon_template_butt/UseFuncs1.png" /><br/>
<sub><b>Or to give bonus stats</b></sub><br/>
<img src="https://raw.githubusercontent.com/Jochnickel/addon_template_butt/images/game/dota_addons/addon_template_butt/UseFuncs2.png" />

# Settings
The Loadscreen settings. Feel free to balance your game here.

# Events
Events are the main point for making Dota Mods fun. You can add a modifier on any kind of thing, for example you could cut all nearby trees every time a lasthit is made. Or you give a heal for every kill that a player makes.
At the bottom of the file you can find an example, on how to do stuff with nearby units and on how to deal Damage to a unit, here all nearby units.
<br/><sub><b>Dead Heroes drop Feaareiy Fires</b></sub><br/>
<img src="https://raw.githubusercontent.com/Jochnickel/addon_template_butt/images/game/dota_addons/addon_template_butt/Events1.png" />

# Lua Tipps
-- This is a comment. This means everything in the line after -- will get ignored in the code

If you have a typo in a file, the whole file may turn useless (you will see when you get red errors inside the game).

Using Sublime or Notepad++ makes it much easier.


If you have a function, e.g. function examplemodifier:OnAttackLanded(event), you can read the whole event on the console using:
"for k,v in pairs(event) do print("OnAttackLanded:",k,v) end"
Sometimes events might miss a value (like event.attacker).
The console can be opened in Dota (depending on your key assignment) or from asset browser. Filter for "VScript".

Arrays (or tables as they are called in lua) usually start with 1, but some Dota Stuff, like PlayerIDs start with 0, since they originally come from the C++ hardcode of Dota.

A lua table, e.g. "local herovalues = { antimag = 12, centaur = 5 }" can be accessed (or values can be added) with "herovalues.antimag" (=12) or "heorovalues["antimag"]". Numerial entries can be initiated like "local bestfood = { [1]="peppers", [2]="meat" }".

If a variable has no value, it is "nil" and acts like false. (So you can do "if (test) then..." instead of "if (test\~=nil)").

If a function gets not enough parameters, it fills up with nil ("asd:whtvr(hero,nil)" equals to "asd:whtvr(hero)").

This "hero:GetLevel()" equals to "hero.GetLevel(hero)". "if (hero.GetLevel) then test = hero:GetLevel() end" can be used to ensure this function exists.

If you get errors inside a modifier function, try to set "if IsClient() then return end" as the first line inside the function.

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
