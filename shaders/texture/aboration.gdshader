shader_type canvas_item;

uniform float offset : hint_range(-10.0, 10.0) = 5.0f;

void fragment()
{
	vec4 green = texture(TEXTURE, UV);
	vec4 red = texture(TEXTURE, vec2(UV.x + offset * TEXTURE_PIXEL_SIZE.x, UV.y));
	vec4 blue = texture(TEXTURE, vec2(UV.x - offset * TEXTURE_PIXEL_SIZE.x, UV.y));
	COLOR = vec4(red.r, green.g, blue.b, (red.a + green.a + blue.a));
}