extends StaticBody2D  # Der Typ des Knoten, in dem das Skript liegt

@export var action_to_execute: String = "toggle_switch"  # Aktion, die ausgeführt wird
@onready var animation_player: AnimationPlayer = $AnimationPlayer  # Animation Player Knoten
@onready var timer: Timer = $Timer  # Timer Knoten

var is_pressed: bool = false  # Status der Druckplatte

func _ready():
	# Verbindung der Signale
	$Area2D.body_entered.connect(on_body_entered)

func on_body_entered(body):
	if body.is_in_group("MainPlayer"):  # Überprüfen, ob der betretende Körper der Spieler ist
		is_pressed = true
		execute_action()  # Aktion ausführen
		animation_player.play("pressed")  # Animation abspielen
		$CollisionShape2D.disabled = true  # Kollisionsform deaktivieren, um zu verhindern, dass weitere Spieler eintreten

		# Nach Ablauf des Timers wieder zurücksetzen
		timer.start()

func execute_action():
	if action_to_execute == "toggle_switch":
		# Beispiel-Aktion: Schalter umschalten
		# Hier kannst du deine spezifische Aktion definieren
		print("Schalter umgeschaltet!")

func respawn():
	is_pressed = false
	animation_player.stop()  # Animation stoppen
	$CollisionShape2D.disabled = false  # Kollisionsform wieder aktivieren

# Timer-Timeout: Plattform zurücksetzen
func _on_Timer_timeout():
	respawn()
