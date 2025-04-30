extends Area2D

@onready var fire_totem_animated_sprite_2d = $fire_totem_AnimatedSprite2D


func _on_body_entered(body):
	if body.is_in_group("player"):
		body.set_totemStatus("fire")
		fire_totem_animated_sprite_2d.visible = true



func _on_body_exited(body):
	if body.is_in_group("player"):
		body.set_totemStatus("none")
		fire_totem_animated_sprite_2d.visible = false
