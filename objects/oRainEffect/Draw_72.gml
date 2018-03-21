/// @description 
//Surface backup
if (!surface_exists(surf)){
	surf = surface_create(surfW, surfH);
	buffer_set_surface(buff, surf, 0, 0, 0);
}
else if (buffCooldown==0){
	buffer_get_surface(buff, surf, 0, 0, 0);
	buffCooldown = room_speed;
}

buffCooldown -= buffCooldown>0;

if (!surface_exists(rainSurf)){
	rainSurf = surface_create(surfW, surfH);
}