/// @function addPartList
/// @description Description of the function.
/// @arg spr
/// @arg sub
/// @arg x
/// @arg y
/// @arg [xscale
/// @arg yscale
/// @arg spd
/// @arg dir
/// @arg angle]

//Args
var _spr = argument[0];
var _sub = argument[1];
var _x = argument[2];
var _y = argument[3];

if (argument_count>4){
	var _xs = argument[4];
	var _ys = argument[5];
	var _spd = argument[6];
	var _dir = argument[7];
	var _angle = argument[8];
}
else{
	var _xs = 1;
	var _ys = 1;
	var _spd = 0;
	var _dir = 0;
	var _angle = 0;
}

//Function
var arr = [_spr, _sub, _x, _y, _xs, _ys, _spd, _dir, _angle, _spd, _dir, _xs];

ds_list_add(partList, arr);