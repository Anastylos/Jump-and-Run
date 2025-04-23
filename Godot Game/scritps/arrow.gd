class_name Arrow
extends CharacterBody2D

const SPEED = 1000
const ARROW_LAYER = 2  # Custom layer for arrows

var bounced = false
var MIN_VELOCITY = 0.1
var dir: float
var spawnPos: Vector2
var is_frozen: bool = false
var parent_body: Node = null
var fire: bool = false
var ice: bool = false
var saved_velocity

var last_direction : int

@onready var timer: Timer = $Timer
@onready var player = get_node("/root/Game/MainPlayer")

@onready var fire_animated_sprite_2d = $Sprite2D/fire_AnimatedSprite2D
@onready var ice_animated_sprite_2d_2 = $Sprite2D/ice_AnimatedSprite2D2



func _ready():
	if player != null:
		if player.get_totem_status() == "fire":
			fire_animated_sprite_2d.visible = true
			fire = true
		elif player.get_totem_status() == "ice":
			ice_animated_sprite_2d_2.visible = true
			ice = true
		
	var mouse_position = get_global_mouse_position()
	global_position = spawnPos
	var directionToMouse = mouse_position - global_position
	var spawnRot = directionToMouse.angle()
	rotation = spawnRot
	dir = spawnRot
	velocity = Vector2(SPEED, 0).rotated(dir)
	
	timer.start()
	

func _process(delta):
	saved_velocity = velocity
	if get_rotation_degrees() >= -90 and get_rotation_degrees() <= 90:
		scale.y = 1
	else:
		scale.y = -1
	
	if last_direction == null or last_direction == 0:
		if velocity.x < 0:
			last_direction = -1

		elif velocity.x > 0:
			last_direction = 1

	if not is_frozen:
		move_and_slide()
		
		for i in get_slide_collision_count():
			var collision = get_slide_collision(i)
			var collided_body = collision.get_collider()
			if collided_body.is_in_group("Bouncy"):
				do_bounce(collision)
				break
			elif should_stick_to(collided_body):
				stick_to_body(collided_body)
				break
			
	elif parent_body:
		global_position = parent_body.to_global(get_parent_attachment_point())

func should_stick_to(body: Node) -> bool:
	# Don't stick to other arrows
	if body is Arrow:
		return false
	
	# Don't stick to the player
	if body.is_in_group("player") or body.is_in_group("pass_projectile"):
		return false
	
	# Stick to everything else
	return true

func stick_to_body(body):
	is_frozen = true
	velocity = Vector2.ZERO
	parent_body = body
	# Remove the arrow from its current parent
	get_parent().remove_child(self)
	# Add the arrow as a child of the collided body
	body.add_child(self)
	# Set the arrow's position relative to its new parent
	position = body.to_local(position)
	
	collision_layer = 2
	collision_mask = 2

func get_parent_attachment_point() -> Vector2:
	return position
	
		
func do_bounce(collision):
	if not bounced:
		var normal = collision.get_normal()
		velocity = saved_velocity.bounce(normal)
		rotation = velocity.angle()
		bounced = true

func _on_timer_timeout() -> void:
	queue_free()
