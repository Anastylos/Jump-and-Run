extends CharacterBody2D

signal health_geaendert(neue_health)
var health = 5
var speed = 250.0
const JUMP_VELOCITY = -400.0
var totem_status = "none"
var direction

var arrow = load("res://scenes/arrow.tscn")
var input_enabled = true
# Der normale Zeitablauf
const NORMAL_TIME_SCALE = 1.0
# Der Zeitablauf währenKid der Zeitlupe
const SLOW_MOTION_SCALE = 0.3

@onready var checkPoint_Pos = global_position

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var shoot_anim = $shootAnim
@onready var bow_ray_cast_2d = $shootAnim/BowRayCast2D
@onready var rundust_anim = $rundustAnim
@onready var dash_timer = $dashDuration
@onready var dash_cooldown = $dashCooldown

func _physics_process(delta):
	if health == 0:
		global_position = checkPoint_Pos
		health = 5
		emit_signal("health_geaendert", "heal", health)
	
	if input_enabled:
		if shoot_anim.get_rotation_degrees() >= -90 and shoot_anim.get_rotation_degrees() <= 90:
			shoot_anim.scale.y = 1
		else:
			shoot_anim.scale.y = -1

		 # Hole die aktuelle Position der Maus
		var mouse_position = get_global_mouse_position()
	
		# Berechne den Winkel zwischen dem Sprite und der Maus
		var directionToMouse = mouse_position - global_position
		shoot_anim.rotation = directionToMouse.angle();
	
		# Add the gravity.
		if not is_on_floor():
			velocity += get_gravity() * delta
		
		# Prüfe, ob die Taste für Zeitlupe gedrückt ist
		if Input.is_action_pressed("slowmow"):
			# Setze das Spiel in Zeitlupe
			Engine.time_scale = SLOW_MOTION_SCALE
		else:
			# Stelle den normalen Zeitablauf wieder her
			Engine.time_scale = NORMAL_TIME_SCALE
			
		
		# Handle jump.
		if Input.is_action_pressed("springen") and is_on_floor():
			velocity.y = JUMP_VELOCITY
		
	
		if Input.is_action_just_pressed("shoot"):
			shoot()
			
		if Input.is_action_just_pressed("dash"):
			if dash_cooldown.is_stopped():
				dash_timer.start()
				dash_cooldown.start()
				speed = 1000.0
				
		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		direction = Input.get_axis("left", "right")
		if direction:
				rundust_anim.visible = true
				animated_sprite_2d.play("ShootRunAtack")
				rundust_anim.play("rundust")
				velocity.x = direction * speed
		else:
			if shoot_anim.is_playing():
				animated_sprite_2d.play("Atack")
			else:
				rundust_anim.visible = false
				animated_sprite_2d.play("idle")
				velocity.x = move_toward(velocity.x, 0, speed)
		
		if direction > 0:
			animated_sprite_2d.scale.x = 1
			rundust_anim.scale.x = 1
		elif direction < 0:
			animated_sprite_2d.scale.x = -1
			rundust_anim.scale.x = -1
	
	move_and_slide()
	
func shoot():
	shoot_anim.visible = true	
	if !shoot_anim.is_playing():
		shoot_anim.play("shoot")
		var a = arrow.instantiate()
		a.spawnPos = bow_ray_cast_2d.global_position
		get_parent().get_parent().add_child.call_deferred(a)

func disable_input():
	input_enabled = false

func enable_input():
	input_enabled = true

func _on_shoot_anim_animation_finished():
	shoot_anim.visible = false


func _on_dash_timer_timeout():
	speed = 250
	
func set_totemStatus(status):
	totem_status = status
	
func get_totem_status():
	return totem_status
	
func schaden_nehmen(damage: float ):
	health -= damage
	health = clamp(health, 0, 5)
	emit_signal("health_geaendert", "damage" , health)
	
func heal(healAmount: float):
	health += 1
	health = clamp(health, 0, 5)
	emit_signal("health_geaendert", "heal" , health)
