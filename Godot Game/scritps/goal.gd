extends Area2D

@export var next_lvl: PackedScene

var anim_was_played = false

@onready var animation_player = $AnimationPlayer
@onready var blueRocketAnimSprite2d = $blueRocket
@onready var blueExplosionAnimSprite2d = $BlueExplosion
@onready var orange_rocket_anim = $orangeRocket
@onready var orange_explo_anim = $orangeExplo
@onready var next_lvl_load_timer = $NextLvlLoadTimer



func _on_body_entered(body):
	if body.is_in_group("player") and !anim_was_played:
			blueRocketAnimSprite2d.visible = true
			orange_rocket_anim.visible = true
			animation_player.play("Firework")
			blueRocketAnimSprite2d.play("default")
			orange_rocket_anim.play("default")
			anim_was_played = true
			if next_lvl != null:
				next_lvl_load_timer.start()


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


func _on_next_lvl_load_timer_timeout():
	await Fade.fade_out(0.5, Color.BLACK, "Diamond").finished
	get_tree().change_scene_to_packed(next_lvl)
	Fade.fade_in(0.5, Color.BLACK, "Diamond")
