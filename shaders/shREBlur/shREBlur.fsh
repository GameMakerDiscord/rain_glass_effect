//
// Simple passthrough fragment shader
////
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

//const float Pi = 3.14;

//const float blurDirs = 8.;
//const float blurDist = 8.;
//const float blurQual = 2.;

//uniform vec2 appTexel;

void main()
{
//    //gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	
//	for(float i=1.0; i<=blurDist; i+=blurQual){
//		for(float d=0.0; d<Pi*2.; d+=(Pi*2.)/blurDirs){
//			vec2 blurCoord = v_vTexcoord + vec2(cos(d)*i*appTexel.x, -sin(d)*i*appTexel.y);
//			vec4 blurFrag = texture2D(appSurf, blurCoord);
			
//			backColor += blurFrag;
//		}
//	}
	
//	backColor /= 1. + (bDist*blurDirs);
}
