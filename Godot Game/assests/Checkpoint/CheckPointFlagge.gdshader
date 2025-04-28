shader_type canvas_item;

// Outline-Steuerung
uniform float outline_thickness = 1.0; // In Pixeln
uniform vec4 outline_color : source_color = vec4(0.0, 0.0, 0.0, 1.0);

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 tex_color = texture(TEXTURE, UV);
    float alpha = tex_color.a;
	 if (alpha < 0.1) {
        // Berechnung der Schrittweite in UV pro Pixel
        vec2 tex_size = vec2(textureSize(TEXTURE, 0));
        vec2 pixel_step = outline_thickness / tex_size;

        float neighbor_alpha = 0.0;

        // Nachbarn prüfen (8 Richtungen)
        neighbor_alpha += texture(TEXTURE, UV + vec2( pixel_step.x,  0)).a;
        neighbor_alpha += texture(TEXTURE, UV + vec2(-pixel_step.x,  0)).a;
        neighbor_alpha += texture(TEXTURE, UV + vec2( 0,  pixel_step.y)).a;
        neighbor_alpha += texture(TEXTURE, UV + vec2( 0, -pixel_step.y)).a;
        neighbor_alpha += texture(TEXTURE, UV + vec2( pixel_step.x,  pixel_step.y)).a;
        neighbor_alpha += texture(TEXTURE, UV + vec2(-pixel_step.x,  pixel_step.y)).a;
        neighbor_alpha += texture(TEXTURE, UV + vec2( pixel_step.x, -pixel_step.y)).a;
        neighbor_alpha += texture(TEXTURE, UV + vec2(-pixel_step.x, -pixel_step.y)).a;

        // Wenn ein sichtbarer Nachbar gefunden wurde → Outline setzen
        if (neighbor_alpha > 0.0) {
            COLOR = outline_color;  // Setze die Outline-Farbe
        } else {
            discard;  // Pixel verwerfen, wenn keine Outline nötig ist
        }
    }
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
