/// @description 
delta = delta_time/30000;

//Create droplets
if (!irandom(1/chance)){
	var xx = irandom(surfW);
	var yy = irandom(surfH) - surfH/4;
	
	var xxx = xx + lengthdir_x(surfW, rainDir-180);
	var yyy = yy + lengthdir_y(surfW, rainDir-180);
	var dir = point_direction(xxx, yyy, xx, yy);
	
	ds_list_add(rainList, [sREDroplet, 0, xxx, yyy,
		3, 0.5, random_range(20, 30)*delta, dir, dir, 0, 0, 0, xx, yy]);
}

//Droplet particles step
for(var i=0; i<ds_list_size(partList); i++){
	var arr = partList[| i];
	
	//Speed
	arr[@ pr.x] += lengthdir_x(arr[pr.spd], arr[pr.dir]);
	arr[@ pr.y] += lengthdir_y(arr[pr.spd], arr[pr.dir]);
	
	//Vars
	var chooseNew = irandom(30*delta)==0;
	
	//Direction wiggle
	if (chooseNew) arr[@ pr.dirTarget] = irandom_range(-50, -140);
	
	arr[@ pr.dir] += angle_difference(arr[pr.dirTarget] + irandom_range(-30, 30), arr[pr.dir])/(5/delta);
	
	//Speed wiggle
	if (chooseNew || arr[pr.xscale]==0) arr[@ pr.spdTarget] = random_range(0, 2);
	
	arr[@ pr.spd] = lerp(arr[pr.spd], arr[pr.spdTarget], 0.2*delta);
	
	//Scale wiggle
	if (chooseNew) arr[@ pr.scaleTarget] = random_range(0.75, 1.25);
	
	arr[@ pr.xscale] = lerp(arr[pr.xscale], arr[pr.scaleTarget], 0.1*delta);
	arr[@ pr.yscale] = arr[pr.xscale];
	
	//Destroy
	if (arr[pr.x]<-40 || arr[pr.x]>surfW+40 || arr[pr.y]<-40 || arr[pr.y]>surfH+40){
		ds_list_delete(partList, i);
		i--;
	}
}

//Rain particles step
for(var i=0; i<ds_list_size(rainList); i++){
	var arr = rainList[| i];
	
	//Speed
	arr[@ pr.x] += lengthdir_x(arr[pr.spd], arr[pr.dir]);
	arr[@ pr.y] += lengthdir_y(arr[pr.spd], arr[pr.dir]);
	
	//End
	if (point_distance(arr[pr.x], arr[pr.y], arr[pr.xtar], arr[pr.ytar])<=arr[pr.spd]){
		ds_list_delete(rainList, i);
		i--;
		
		addPartList(sREDroplet, 0, arr[pr.xtar], arr[pr.ytar], 0, 0, random_range(1, 4)*delta, -90, 0);
	}
}