shader_type canvas_item;

uniform sampler2D normal_map;
uniform vec2 light_position = vec2(0.5, 0.5); // Light position (0-1 range)
uniform float light_height = 1.0; // Light height (adjust for depth)
uniform float normal_scale = 1.0; // Scale of the normal map effect

void fragment() {
    vec2 uv = UV;
    vec3 normal = texture(normal_map, uv).rgb * 2.0 - 1.0; // Convert normal map to -1 to 1 range
    normal.xy *= normal_scale;

    vec2 light_dir = light_position - uv;
    float dist = length(light_dir);
    vec3 light_vector = normalize(vec3(light_dir, light_height));

    float diffuse = max(0.0, dot(normal, light_vector));

    COLOR = texture(TEXTURE, uv) * diffuse;
}
