shader_type canvas_item;

uniform sampler2D normal_texture;
uniform float normal_scale = 1.0;

void fragment() {
    vec3 normal = texture(normal_texture, UV).rgb * 2.0 - 1.0;
    normal.xy *= normal_scale;

    // Get the light direction (simplified, you might want to pass this as a uniform)
    vec3 light_direction = normalize(vec3(0.5, 0.5, 1.0));

    // Calculate the dot product between the normal and light direction
    float diffuse = max(dot(normal, light_direction), 0.0);

    // Apply the diffuse lighting to the base texture (if you have one)
    vec4 base_color = texture(TEXTURE, UV); //or COLOR
    COLOR = base_color * diffuse;
}