extends Area2D

@onready var totem_fire_animation = $fire_totem_AnimatedSprite2D

func _on_body_entered(body):
	if body.is_in_group("player"):
		body.set_totemStatus("fire")
		totem_fire_animation.visible = true
		totem_fire_animation.play("fire")


func _on_body_exited(body):
	if body.is_in_group("player"):
		body.set_totemStatus("none")
		totem_fire_animation.visible = false
		
		
