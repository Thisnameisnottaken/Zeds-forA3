/*
	file: fn_proximity.sqf
	author: corvobrok
	
	descripttion: create random zombies near the player (more zombies if you are in a city)
*/
_maxnum = Tzombielimit;
_units = ["gulo_Base","z_gulo3","z_gulo2","z_deadgulo","z_gulo1","z_guloman","z_gulodier","z_gulo_pilot","z_gulo_heavy"];
_suoni = ["zomb1","zomb2","zomb3"];
_zombienum = 0;

if (isNil "inSafeZone") then {
    inSafeZone = false;
};

while {true} do {
	waitUntil {
        !inSafeZone
	};	
	
		_house = getPos player nearObjects ["House",120];
		_nhouse = count _house;
		if (Tzombielimit > 50) then {_zombienum = _nhouse;};
		if (Tzombielimit > 20 && Tzombielimit < 51)then {_zombienum = floor (_nhouse/2);};
		if (Tzombielimit < 21) then {_zombienum = floor (_nhouse/3);};
		if (_zombienum > _maxnum) then {_zombienum = _maxnum;};
		if (count zarray < _zombienum) then {
			_pos = [(position player select 0) + floor (random 400)-200, (position player select 1) + floor (random 400)-200, 0];
			_type = _units call BIS_fnc_selectRandom;
			_zombie = groupZMB createUnit [_type, _pos, [], 0, "NONE"];
			[_zombie] spawn fncTZcontact;
			sleep 0.2;
		};
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
				hintsilent format ["DEBUGGING MENU\n>single player<\n\n>Spawned Tzombies: %1\n>House near player: %2\nMax TZombies: %3",(count zarray),count _house,_zombienum];
			}else
			{
				hintsilent format ["DEBUGGING MENU\n>dedicated server<\n\n>Spawned Tzombies: %1\n>House near player: %2\nMax TZombies: %3",(count zarray),count _house,_zombienum];
			};
		};
};
