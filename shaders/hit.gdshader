shader_type canvas_item;

uniform bool hit;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	if(hit && texture(TEXTURE, UV).a != 0.0){
		COLOR = vec4(1,1,1,1);
	}else {
		COLOR = texture(TEXTURE, UV);
	}
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
