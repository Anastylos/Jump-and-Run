extends Control

var health
var hearts = []
var heart_scene = load("res://scenes/HealthHeart.tscn")
var x = 10
@export var spieler: Node


# Called when the node enters the scene tree for the first time.
func _ready():
	if spieler:
		# Verbinde das Signal vom Spieler
		spieler.connect("health_changed", Callable(self, "_on_player_health_changed"))
		health = spieler.health
		
	for i in spieler.health:
		var instanz = heart_scene.instantiate()
		instanz.position.y = 10
		instanz.position.x = x
		x += 10
		hearts.append(instanz)
	
	for heart in hearts:
		add_child(heart)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_player_health_changed(effekttype, new_health): 
	health = new_health
	if effekttype == "heal":
		for i in health:
			hearts[i].play("Full")
	else:
		if is_equal_approx(fmod(health, 1.0), 0.5)  :
			var heart = hearts[ceil(health-1)]
			heart.play("DMG_To_Half")
		else:
			var heart = hearts[health]
			heart.play("DMG_Empty")
