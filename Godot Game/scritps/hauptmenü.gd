extends Node2D

@onready var level_scene = preload("res://scenes/Level0_game.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_button_pressed():
	await Fade.fade_out(0.5, Color.BLACK, "Diamond").finished
	get_tree().change_scene_to_file("res://scenes/Level0_game.tscn")
	Fade.fade_in(0.5, Color.BLACK, "Diamond")
	
