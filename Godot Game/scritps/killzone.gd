extends Area2D

@onready var timer = $Timer
@onready var main_player = %MainPlayer


func _on_body_entered(body):
	if body.is_in_group("player"):
		body.disable_input()
		timer.start()
		
	

func _on_timer_timeout():
	main_player.global_position = main_player.checkPoint_Pos
	main_player.enable_input()
