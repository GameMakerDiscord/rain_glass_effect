/// @description 
//On surface
surface_set_target(surf);

for(var i=0; i<ds_list_size(partList); i++){
	var arr = partList[| i];
	
	draw_sprite_ext(arr[pr.spr], arr[pr.sub], arr[pr.x], arr[pr.y],
		arr[pr.xscale], arr[pr.yscale], arr[pr.angle], -1, 1);
}

surface_reset_target();

surface_set_target(rainSurf);

draw_clear_alpha(0, 0);

for(var i=0; i<ds_list_size(rainList); i++){
	var arr = rainList[| i];
	
	draw_sprite_ext(arr[pr.spr], arr[pr.sub], arr[pr.x], arr[pr.y],
		arr[pr.xscale], arr[pr.yscale], arr[pr.angle], -1, 1);
}

surface_reset_target();

//Draw
var tex = surface_get_texture(surf);
var texW = texture_get_texel_width(tex);
var texH = texture_get_texel_height(tex);

var appTex = surface_get_texture(application_surface);
var appTexW = texture_get_texel_width(appTex);
var appTexH = texture_get_texel_height(appTex);

shader_set(shRainEffect);
shader_set_uniform_f(uniTexel, texW, texH);
shader_set_uniform_f(uniAppTexel, appTexW, appTexH);
shader_set_uniform_f(uniAppSize, surfW, surfH);
shader_set_uniform_f(uniCatch, 1);
texture_set_stage(sampApp, appTex);

draw_surface(surf, 0, 0);
shader_set_uniform_f(uniCatch, 0);
draw_surface(rainSurf, 0, 0);

shader_reset();

//Debug
draw_text(5, 32, delta);