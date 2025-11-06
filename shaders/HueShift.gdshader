shader_type canvas_item;

uniform vec4 color;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.

	if(color == vec4(0,0,0,0)){
		COLOR = texture(TEXTURE, UV);
	}else{
		if(texture(TEXTURE, UV).r > 0.35 && texture(TEXTURE, UV).g >= 0.6){
			COLOR = color;
		}else if(texture(TEXTURE, UV).r >= 0.23 && texture(TEXTURE, UV).g >= 0.6){
			COLOR = vec4(color.rgb * 0.8, color.a);
		}else {
			COLOR = texture(TEXTURE, UV);
		}
	}
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
