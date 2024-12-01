extends CharacterBody2D

var is_fall
var motion = Vector2()

func _physics_process(delta):
	if is_fall == false:
		motion.y += 20
	elif is_fall ==true:
		motion.y = 0
		position.y = 0
	move_and_slide()


func _on_player_enter_body_entered(body):
	if body.is_in_group('player'):
		$AnimationPlatform.play('Falling_down')

func fall():
	is_fall = false

func _on_player_enter_body_exited(body):
	$Timer.wait_time = 2
	$Timer.start()
	
func _on_Timer_timeout():
	is_fall = true




























#onready var animation_Platform = $AnimationPlatform
#onready var timer = $ResetTimer
#
#export var reset_time : float = 1.0
#
#onready var reset_position = gloabl_position
#
#var velocity = Vector2()
#var is_triggered = false
#
#
#func ready():
	#set_physics_process(false)
	#
#
#func _physics_process(delta):
	#velocity.y += Globals.gravity * delta 
	#position += velocity * delta
#
#func collide_with(collision : KinematicCollision2D, collider : CharacterBody2D):
	#if !is_triggered:
		#is_triggered = true
		#animation_player.player(falling_down)
		#velocity = Vector2.ZERO
#
#func _on_AnimationPlayer_animation_finished(anim_name):
	#set_physics_process(true)
	#timer.start(reset_time)
#
#
#func _on_ResetTimer_timeout():
	#set_physics_process(false)
	#yield(get_tree(), "physics_frame")
	#var temp = collision_layer
	#collision_layer = 0
	#global_position ? reset_position
	#yield(get_tree(), "physics_frame")
	#collision_layer = temp
	#is_triggered = false




#const SPEED = 300.0
#const JUMP_VELOCITY = -400.0
#
#
#func _physics_process(delta: float) -> void:
	## Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta
#
	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var direction := Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
#
	#move_and_slide()
