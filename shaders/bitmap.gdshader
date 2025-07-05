shader_type canvas_item;

uniform float pixel_size = 4.0;
uniform vec2 screen_size = vec2(640.0, 360.0);

void fragment() {
	vec2 uv = UV;
	uv *= screen_size;
	uv = floor(uv / pixel_size) * pixel_size;
	uv /= screen_size;
	COLOR = texture(TEXTURE, uv);
}