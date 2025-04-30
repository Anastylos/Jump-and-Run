extends Area2D

@onready var timer = $Timer
var entered_body


func _on_body_entered(body):
	entered_body = body
	if entered_body.is_in_group("player"):
		body.disable_input()
	timer.start()
		
	

func _on_timer_timeout():
	if entered_body.is_in_group("player"):
		entered_body.global_position = entered_body.checkPoint_Pos
		entered_body.enable_input()
	else:
		entered_body.queue_free()
