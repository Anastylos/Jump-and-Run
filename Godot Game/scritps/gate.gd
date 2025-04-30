extends Node2D
class_name Gate

@onready var animation_player = $AnimationPlayer


func openGate():
	animation_player.play("OpenGate")
