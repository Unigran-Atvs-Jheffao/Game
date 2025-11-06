shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	if(texture(TEXTURE, UV).a != 0.0){
		float val = (1.0 + sin(TIME * 20.0)) / 2.0;
		COLOR = (vec4(val,val,val,1)) + texture(TEXTURE, UV);
	}
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
