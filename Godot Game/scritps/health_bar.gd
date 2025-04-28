extends Control

var health
var hearts = []
var heart_scene = load("res://scenes/HealthHeart.tscn")
var x = 10
@export var player: Node


# Called when the node enters the scene tree for the first time.
func _ready():
	if player:
		# Connect signal from player
		player.connect("health_changed", Callable(self, "_on_health_changed"))
		health = player.health
		
	for i in player.health:
		var instance = heart_scene.instantiate()
		instance.position.y = 10
		instance.position.x = x
		x += 10
		hearts.append(instance)
	
	for heart in hearts:
		add_child(heart)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_player_health_changed(effecttype, new_health): 
	health = new_health
	if effecttype == "heal":
		for i in health:
			hearts[i].play("Full")
	else:
		if is_equal_approx(fmod(health, 1.0), 0.5)  :
			var heart = hearts[ceil(health-1)]
			print(health)
			heart.play("DMG_To_Half")
		else:
			var heart = hearts[health]
			print(health)
			heart.play("DMG_Empty")
