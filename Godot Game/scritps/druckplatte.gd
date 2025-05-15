extends Node2D
class_name Druckplatte

@onready var animation_player = $AnimationPlayer
@export var gate: Gate

var triggered = false

func _on_area_2d_body_entered(body):
	if body.is_in_group("player") and not triggered:
		open_gate()
		
	if body.is_in_group("projectile") and not triggered:
		open_gate()

func open_gate():
	animation_player.play("Button_Move")
	gate.openGate()
	triggered = true
	
