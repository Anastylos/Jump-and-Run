extends Area2D

@onready var totem_ice_animation = $ice_totem_AnimatedSprite2D

func _on_body_entered(body):
	if body.is_in_group("player"):
		body.set_totemStatus("ice")
		totem_ice_animation.visible = true
		totem_ice_animation.play("ice")


func _on_body_exited(body):
	if body.is_in_group("player"):
		body.set_totemStatus("none")
		totem_ice_animation.visible = false
