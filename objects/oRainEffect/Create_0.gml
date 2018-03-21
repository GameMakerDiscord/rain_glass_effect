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

buff = buffer_create(surfW*surfH*4, buffer_fixed, 1);
buffer_get_surface(buff, surf, 0, 0, 0);
buffCooldown = 0;

//Particle lists
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