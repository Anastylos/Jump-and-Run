extends Node2D
class_name Gate

@onready var animation_player = $AnimationPlayer


func openGate():
	animation_player.play("OpenGate")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	queue_free()
