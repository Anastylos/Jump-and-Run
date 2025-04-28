class_name Arrow
extends CharacterBody2D

const SPEED = 1000
const ARROW_LAYER = 2  # Custom layer for arrows
const BOX_IMPACT_FORCE = 200  # Force with which the box is thrown away

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
@onready var bounce_cooldown = $bounce_cooldown

func _ready():
	if player != null:
		match player.get_totem_status():
			"fire":
				fire_animated_sprite_2d.visible = true
				fire = true
				add_to_group("bruning")
			"ice":
				ice_animated_sprite_2d_2.visible = true
				ice = true
				add_to_group("freezing")

	global_position = spawnPos
	var mouse_position = get_global_mouse_position()
	var direction_to_mouse = mouse_position - global_position
	dir = direction_to_mouse.angle()
	rotation = dir
	velocity = Vector2(SPEED, 0).rotated(dir)
	timer.start()

func _process(delta):
	# Save pre-collision velocity for correct bounce
	saved_velocity = velocity

	# Flip sprite based on travel direction
	scale.y = 1 if (rotation_degrees >= -90 and rotation_degrees <= 90) else -1


	if not is_frozen:
		# Perform a precise single collision query
		var collision = move_and_collide(velocity * delta)
		if collision:
			var body = collision.get_collider()

			# Box treffen -> wegschleudern
			if body.is_in_group("box"):
				# Falls KinematicBody2D mit velocity-Property
				if body.has_method("set_velocity"):
					body.set_velocity(body.velocity + saved_velocity.normalized() * BOX_IMPACT_FORCE)
				elif body.has("velocity"):
					body.velocity += saved_velocity.normalized() * BOX_IMPACT_FORCE
				# Make arrow stick to the box
				body.is_impacting = true
				remove_from_group("projectile")
				stick_to_body(body)
			# Handle bouncy surfaces normally
			elif body.is_in_group("Bouncy"):
				do_bounce(collision)
			# Other surfaces -> stick the arrow
			elif should_stick_to(body):
				stick_to_body(body)
	elif parent_body:
		# If stuck, keep position relative to parent
		global_position = parent_body.to_global(get_parent_attachment_point())

func should_stick_to(body: Node) -> bool:
	if body is Arrow:
		return false
	if body.is_in_group("player") or body.is_in_group("pass_projectile"):
		return false
	return true

func stick_to_body(body: Node) -> void:
	is_frozen = true
	velocity = Vector2.ZERO
	parent_body = body
	get_parent().remove_child(self)
	body.add_child(self)
	position = body.to_local(position)
	collision_mask = 2

func get_parent_attachment_point() -> Vector2:
	return position

func do_bounce(collision) -> void:
	if not bounced:
		var normal = collision.get_normal()
		velocity = saved_velocity.bounce(normal)
		rotation = velocity.angle()
		last_direction *= -1
		bounced = true
		bounce_cooldown.start()

func _on_timer_timeout() -> void:
	queue_free()

func _on_bounce_cooldown_timeout() -> void:
	bounced = false
