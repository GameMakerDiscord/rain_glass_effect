/// @description 
show_debug_overlay(1);
randomize();

#region Properties/Customization
chance = 0.05; //The probablity of the rain drops spawning each step (out of 1)
rainDir = -100; //Direction towards which the rain drops fall

#endregion

#region Internal
//Surface
surfW = surface_get_width(application_surface);
surfH = surface_get_height(application_surface);
surf = surface_create(surfW, surfH);
rainSurf = surface_create(surfW, surfH);

//Particles
//partSys = part_system_create();
//part_system_automatic_draw(partSys, 0);

////Droplet
//partDrop = part_type_create();
//part_type_sprite(partDrop, sREDroplet, 0, 0, 0);
//part_type_speed(partDrop, 3, 4, 0, 0);
//part_type_direction(partDrop, -90, -90, 0, -20);

//Particle list
partList = ds_list_create();
rainList = ds_list_create();

//Particle props
enum pr{
	spr,
	sub,
	x,
	y,
	xscale,
	yscale,
	spd,
	dir,
	angle,
	spdTarget,
	dirTarget,
	scaleTarget,
	xtar,
	ytar
}

//Shader
uniTexel = shader_get_uniform(shRainEffect, "texel");
uniAppTexel = shader_get_uniform(shRainEffect, "appTexel");
uniAppSize = shader_get_uniform(shRainEffect, "appSize");
uniCatch = shader_get_uniform(shRainEffect, "catchApp");
sampApp = shader_get_sampler_index(shRainEffect, "appSurf");
#endregion