shader_type canvas_item;

uniform vec4 edge_color : source_color = vec4(1.0, 0.0, 0.0, 1.0); // Farbe des Randes
uniform vec4 core_color : source_color = vec4(1.0, 0.0, 0.0, 0.5); // Farbe des Kerns (50 % Alpha)
uniform float core_radius = 0.3;
uniform float edge_thickness = 0.2;
uniform float wave_amplitude = 0.05;
uniform float wave_frequency = 200.0;
uniform float wave_speed = 2.0;

void fragment() {
    float time = TIME * wave_speed;

    // Abstand zur Mitte entlang der X-Achse (für vertikale Barriere)
    float dist = abs(UV.x - 0.5);

    // Wellenbewegung entlang der Y-Achse
    float wave = sin(UV.y * wave_frequency + time) * wave_amplitude;

    // Berechnung der inneren und äußeren Grenze mit Wellenoffset
    float outer_edge = core_radius + edge_thickness + wave;
    float inner_edge = core_radius + wave;

    // Alpha-Übergang von leuchtendem Rand zur Mitte
    float edge_alpha = smoothstep(outer_edge, inner_edge, dist);

    // Wenn innerhalb des Kerns → halbtransparent
    if (dist <= inner_edge) {
        COLOR = core_color;
    } else {
        COLOR = edge_color;
        COLOR.a *= edge_alpha;
    }
}
