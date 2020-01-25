cd ~/butt/addon_template_butt/
git checkout nerd -f
git reset --hard
git pull
cd ~/butt/addon_template_butt/game/dota_addons/addon_template_butt/scripts/npc/
rm items.txt
rm neutral_items.txt
rm abilities.txt
rm heroes.txt
rm units.txt
rm herolist.txt
wget "https://raw.githubusercontent.com/SteamDatabase/GameTracking-Dota2/master/game/dota/pak01_dir/scripts/npc/items.txt"
wget "https://raw.githubusercontent.com/SteamDatabase/GameTracking-Dota2/master/game/dota/pak01_dir/scripts/npc/neutral_items.txt"
wget "https://raw.githubusercontent.com/SteamDatabase/GameTracking-Dota2/master/game/dota/scripts/npc/npc_abilities.txt"
wget "https://raw.githubusercontent.com/SteamDatabase/GameTracking-Dota2/master/game/dota/scripts/npc/npc_heroes.txt"
wget "https://raw.githubusercontent.com/SteamDatabase/GameTracking-Dota2/master/game/dota/scripts/npc/npc_units.txt"
wget "https://raw.githubusercontent.com/SteamDatabase/GameTracking-Dota2/master/game/dota/pak01_dir/scripts/npc/activelist.txt"
mv npc_abilities.txt abilities.txt
mv npc_heroes.txt heroes.txt
mv npc_units.txt units.txt
mv activelist.txt herolist.txt
git add items.txt -f
git add neutral_items.txt -f
git add abilities.txt -f
git add heroes.txt -f
git add units.txt -f
git add herolist.txt -f
git commit -m "Auto-Update from https://github.com/SteamDatabase/GameTracking-Dota2"
git push

cd ~/butt/
rm -r game_nerd/
rm -r content_nerd/
cp -r addon_template_butt/game/ game_nerd/
cp -r addon_template_butt/content/ content_nerd/
cd addon_template_butt/
git checkout master -f
git reset --hard
git pull
rm .gitignore
wget "https://raw.githubusercontent.com/Jochnickel/addon_template_butt/gitignore_master/.gitignore"
rm -r game/
rm -r content/
cp -r ../game_nerd/ game/
cp -r ../content_nerd/ content/
rm -r ../game_nerd/
rm -r ../content_nerd/
date > game/dota_addons/addon_template_butt/version.txt
git add .
git commit -m "Auto-Commit generated from https://github.com/Jochnickel/addon_template_butt/tree/nerd"
git push
