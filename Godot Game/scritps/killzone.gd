extends Area2D

@onready var timer = $Timer

func _on_body_entered(body):
	if body.is_in_group("player"):
		body.disable_input()
		print("you died!")
		timer.start()
	else:
		print("Player is null!")
		
	

func _on_timer_timeout():
	get_tree().reload_current_scene()
