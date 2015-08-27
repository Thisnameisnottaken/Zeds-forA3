/*
	file: fn_zombieinit.sqf
	author: corvobrok
	
	description: create zombies near a marker (more zombies if you are in a city)
*/
_units = ["zZombie_Base","z_villager3","z_deadsurvivor","z_policeman","z_soldier","z_soldier_pilot","z_soldier_heavy"];
_suoni = ["zomb1","zomb2","zomb3"];
_marker = zombiemkr select 0;

if (isNil "inSafeZone") then {
    inSafeZone = false;
};

while {true} do {
	if !(inSafeZone)then{
		{
			if (player distance getmarkerpos _x < player distance getmarkerpos _marker) then
			{
				_marker = _x;
			};
			sleep 0.01;
		}foreach zombiemkr;

		if (player distance getmarkerpos _marker < markerdist) then
		{
			if (count zarray < zombielimit) then {
				_pos = [(position player select 0) + floor (random 400)-200, (position player select 1) + floor (random 400)-200, 0];
				_type = _units call BIS_fnc_selectRandom;
				_type createUnit [_pos, groupZMB, "[this]spawn fncZcontact;"];
				sleep 0.2;
			};
		}
		else {sleep 3;};
		sleep 1;
		_rand = floor (random 2);
		if (count zarray > 2 && _rand > 0) then
		{
			_one = zarray call BIS_fnc_selectRandom;
			_two = _suoni call BIS_fnc_selectRandom;
			_one say3d _two;
		};
		if (zdebugging > 0) then
		{
			if (!isdedicated) then 
			{
				hintsilent format ["DEBUGGING MENU\n>single player<\n\n>Spawned zombies: %1\n>Nearest Marker: %2m",(count zarray),floor (player distance getmarkerpos _marker)];
			}else
			{
				hintsilent format ["DEBUGGING MENU\n>dedicated server<\n\n>Spawned zombies: %1\n>Nearest Marker: %2m",(count zarray),floor (player distance getmarkerpos _marker)];
			};
		};		
	};
};
