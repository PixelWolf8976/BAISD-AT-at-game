shader_type canvas_item;

uniform float blur_amount : hint_range(0.0, 10.0) = 5.0;

uniform sampler2D SCREEN_TEXTURE;

void fragment() {
	vec2 blur_offset = vec2(blur_amount / SCREEN_PIXEL_SIZE.x, blur_amount / SCREEN_PIXEL_SIZE.y);
	vec4 color = vec4(0.0);
	
	color += texture(SCREEN_TEXTURE, SCREEN_UV - blur_offset);
	color += texture(SCREEN_TEXTURE, SCREEN_UV + blur_offset);
	color += texture(SCREEN_TEXTURE, SCREEN_UV - vec2(blur_offset.x, -blur_offset.y));
	color += texture(SCREEN_TEXTURE, SCREEN_UV + vec2(blur_offset.x, -blur_offset.y));
	
	color /= vec4(4.0);
	
	COLOR = color;
}
