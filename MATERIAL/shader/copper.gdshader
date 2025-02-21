shader_type canvas_item;
uniform vec4 oxide_0 : source_color = vec4(1.0); // Allow the color to be set in the editor
uniform vec4 oxide_1 : source_color = vec4(1.0); // Allow the color to be set in the editor
uniform vec4 oxide_2 : source_color = vec4(1.0); // Allow the color to be set in the editor
uniform vec4 oxide_3 : source_color = vec4(1.0); // Allow the color to be set in the editor
uniform vec4 oxide_4 : source_color = vec4(1.0); // Allow the color to be set in the editor

void fragment() {
	COLOR = COLOR*oxide_0; // Set the pixel color to the uniform color

	if(distance(COLOR.rgb,vec3(0,0,0))<0.5){
		COLOR = COLOR*oxide_1;
	}else
	if(distance(COLOR.rgb,vec3(0,0,0))<0.6){
		COLOR = COLOR*oxide_2;
	}else
	if(distance(COLOR.rgb,vec3(0,0,0))<0.7){
		COLOR = COLOR*oxide_3;
	}else
	if(distance(COLOR.rgb,vec3(0,0,0))<0.8){
		COLOR = COLOR*oxide_4;
	}else
	if(distance(COLOR.rgb,vec3(0,0,0))<0.9){
		COLOR = COLOR*oxide_3;
	};

}
void vertex(){
	COLOR = COLOR*vec4(0.9,1,1,1); // Set the pixel color to the uniform color
	if(distance(COLOR.rgb,vec3(0.9,1,1))>0.1){
		COLOR = COLOR*vec4(0.7,0.5,0.2,1);
	}else{
		COLOR = COLOR*vec4(0.9,0.6,0.5,1);
	}
}
void light(){

}