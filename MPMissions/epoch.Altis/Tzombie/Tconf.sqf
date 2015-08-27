/*
	file: configurations.sqf
	author: corvobrok
*/
TZedface = ["infected1","Infected2","zombi","zomboy"] call BIS_fnc_selectRandom;  // empty means normal faces most players get confused when it start slapping 2-3 hits means pain
Tzombielimit = 3;  //zombies respawn afterdead, but for each unit in zone, 7 zombies will spawn
Tzombiedamage = 50;   //% of the damage of a zombie for a punch  , yes 2x and your gone
Tzombierun = 1;		 //set 1 if zombie must run, 0 if they must walk
Trespawntime = 180;  //time for respawn killed zombies
zdebugging = 0;  //show the debug stats; enable with 1

//----------Only marker spawn---------------------------------------
//with this function, zombies will spawn only near markers

zombiemkr=[];	   //markers where zombie spawn
//EXAMPLE: zombiemkr=["marker1",marker2"];
//where marker1 and marker2 are marker placed on the editor
markerdist = 600;  //distance from markers where zombies spawn/despawn

//XXXXXXXXXXXXXXXXXXXXX  DON'T EDIT BELOW!  XXXXXXXXXXXXXXXXXXXXXXXXX
SideZMB = createCenter civilian;
groupZMB = createGroup civilian;
sleep 0.1;
fncTZcontact = compile preprocessFile "Tzombie\fnc_TZcontact.sqf";
fncTZMarkers = compile preprocessFile "Tzombie\fnc_TZMarkers.sqf";
fncTZproximity = compile preprocessFile "Tzombie\fnc_TZProximity.sqf";

zarray = [];

if (count zombiemkr > 0) then
{[]call fncTZMarkers;}
else
{[]call fncTZproximity;};
