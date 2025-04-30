extends CharacterBody2D

@onready var timer_drop_platform = $TimerDropPlatform
@onready var player_colision_detection = $player_enter/CollisionShape2D

@onready var is_falling = false;

func _physics_process(delta):

	# Add the gravity.
	if is_falling:
		velocity += get_gravity() * delta * 0.4
	move_and_collide(velocity * delta * 0.4)


func _on_timer_drop_platform_timeout():
	is_falling = true


func _on_player_enter_body_entered(body):
	if body.is_in_group("player"):
		print("palyer on palt")
		timer_drop_platform.start()
