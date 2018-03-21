//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

const float Pi = 3.14;
const float halfPi = (3.14)/2.0;

const float maxDist = 10.;

uniform vec2 texel;
uniform vec2 appTexel;

//App surf
uniform sampler2D appSurf;
uniform vec2 appSize;
uniform bool catchApp;

//Blur
const float blurDist = 32.;
const float blurDirs = 8.;
const float blurQual = 32.;

void main()
{
    vec4 baseColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	vec4 backColor = texture2D(appSurf, v_vTexcoord);
	
	//Get light value
	float light = 0.0;
	float lightDir = 0.0;
	float lightDist = 0.0;
	
	bool stop = false;
	
	for(float d=0.0; d<=halfPi; d+=halfPi/16.){
		for(float i=1.0; i<=maxDist; i+=1.0){
			//Check 1
			float dir = -halfPi + d;
			vec2 checkPos = vec2(v_vTexcoord.x + cos(dir)*i*texel.x, v_vTexcoord.y - sin(dir)*i*texel.y);
			vec4 checkFrag = texture2D(gm_BaseTexture, checkPos);
			
			//Empty pixel found
			if (checkFrag.a<=0.0){
				stop = true;
				light = (1.-(d/halfPi)) * (1.-(i/maxDist));
				lightDir = dir;
				lightDist = 1.-(i/maxDist);
				break;
			}
			
			//Check 2
			float dir2 = -halfPi - d;
			vec2 checkPosB = vec2(v_vTexcoord.x + cos(dir2)*i*texel.x, v_vTexcoord.y - sin(dir2)*i*texel.y);
			vec4 checkFragB = texture2D(gm_BaseTexture, checkPosB);
			
			//Empty pixel found
			if (checkFrag.a<=0.0){
				stop = true;
				light = (1.-(d/halfPi)) * (1.-(i/maxDist));
				lightDir = dir2;
				lightDist = 1.-(i/maxDist);
				break;
			}
		}
		
		//Break loop
		if (stop){
			break;
		}
	}
	
	//Distortion
	float distort = 1.-lightDist;
	
	vec2 backCoord = v_vTexcoord;
	
	if (baseColor.a>0.){
		backCoord.y += distort*4.*appTexel.y;
		backCoord -= vec2(cos(lightDir)*lightDist*appTexel.x*(appSize.x/8.)*light, -sin(lightDir)*lightDist*appTexel.y*(appSize.y/2.)*light);
	}
	
	//Get color
	backColor = texture2D(appSurf, backCoord);
	
	//Blur
	//if (baseColor.a>0.){
	//	for(float i=1.0; i<blurDist; i+=blurDist/blurQual){
	//		for(float d=0.0; d<Pi*2.; d+=(Pi*2.)/blurDirs){
	//			vec2 blurCoord = backCoord + vec2(cos(d)*i*appTexel.x, -sin(d)*i*appTexel.y);
	//			vec4 blurFrag = texture2D(appSurf, blurCoord);
			
	//			backColor += blurFrag;
	//		}
	//	}
	
	//	backColor /= 1. + (blurQual*blurDirs);
	//}
	
	//Color
	if (baseColor.a>0. || catchApp) gl_FragColor = backColor;
		//else discard;
	
	//if (baseColor.a>0.) gl_FragColor.rgb += vec3(light/2.);
}
