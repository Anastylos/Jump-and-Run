extends Area2D

var anim_was_played = false

@onready var animation_player = $AnimationPlayer
@onready var blueRocketAnimSprite2d = $blueRocket
@onready var blueExplosionAnimSprite2d = $BlueExplosion
@onready var orange_rocket_anim = $orangeRocket
@onready var orange_explo_anim = $orangeExplo


func _on_body_entered(body):
	if body.is_in_group("player") and !anim_was_played:
			blueRocketAnimSprite2d.visible = true
			orange_rocket_anim.visible = true
			animation_player.play("Firework")
			blueRocketAnimSprite2d.play("default")
			orange_rocket_anim.play("default")
			anim_was_played = true


func _on_animated_sprite_2d_animation_finished():
	blueRocketAnimSprite2d.visible = false
	blueExplosionAnimSprite2d.visible = true
	blueExplosionAnimSprite2d.play("default")


func _on_animated_sprite_2d_2_animation_finished():
	blueExplosionAnimSprite2d.visible = false


func _on_orange_rocket_animation_finished():
	orange_rocket_anim.visible = false
	orange_explo_anim.visible = true
	orange_explo_anim.play("default")


func _on_orange_explo_animation_finished():
	orange_explo_anim.visible = false
