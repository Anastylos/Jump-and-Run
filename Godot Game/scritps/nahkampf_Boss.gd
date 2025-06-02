extends CharacterBody2D

enum State { PATROL, ATTACK, STUNNED }

var state: State = State.PATROL
var hp: int = 500
const SPEED: float = 30.0
const ATTACK_SPEED: float = 200.0
var direction: int = 1
var gravity: float

var player_in_range: bool = false
var target: Node = null
var damage_dealt_this_attack: bool = false
var player_in_hitbox: Node = null


@onready var floor_checker: RayCast2D = $floor_checker
@onready var detector: Area2D = $Player_DEC_Area
@onready var anim: AnimatedSprite2D = $enemy_AnimatedSprite2D
@onready var fire_anim = $enemy_AnimatedSprite2D/fire_AnimatedSprite2D
@onready var ice_anim = $enemy_AnimatedSprite2D/ice_AnimatedSprite2D
@onready var effect_timer: Timer = $enemy_AnimatedSprite2D/animation_Timer
@onready var collision_shape_2d = $ArrowDetectArea/CollisionShape2D
@onready var attack_hitbox: Area2D = $AttackHitbox

func _ready() -> void:
	gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
	detector.body_entered.connect(_on_player_entered)
	detector.body_exited.connect(_on_player_exited)
	anim.animation_finished.connect(_on_enemy_AnimatedSprite2D_animation_finished)
	effect_timer.timeout.connect(_on_effect_timeout)
	attack_hitbox.body_entered.connect(_on_attack_hitbox_body_entered)
	attack_hitbox.body_exited.connect(_on_attack_hitbox_body_exited)

	anim.flip_h = direction < 0
	floor_checker.position.x = collision_shape_2d.shape.size.x * direction
	_update_floor_checker()

func _physics_process(delta: float) -> void:
	match state:
		State.PATROL:
			_patrol(delta)
		State.ATTACK:
			_attack(delta)
		State.STUNNED:
			if not is_on_floor():
				velocity.y += gravity * delta
			move_and_slide()

func _patrol(delta: float) -> void:
	velocity.x = SPEED * direction
	if not is_on_floor():
		velocity.y += gravity * delta
	move_and_slide()
	anim.play("Idle")

	if is_on_wall() or not floor_checker.is_colliding():
		direction *= -1
		_update_sprite_flip()
		attack_hitbox.scale.x *= -1
		detector.scale.y *= -1
		_update_floor_checker()

	if player_in_range:
		state = State.ATTACK

func _attack(delta: float) -> void:
	if target and target.position:
		var dir_to_player = (target.position - position).normalized()
		velocity.x = dir_to_player.x * ATTACK_SPEED
	else:
		velocity.x = 0

	if not is_on_floor():
		velocity.y += gravity * delta

	move_and_slide()

	if anim.animation != "atack":
		anim.play("atack")
		damage_dealt_this_attack = false  # Beim Start der Animation Schaden zurücksetzen

func _on_player_entered(body: Node) -> void:
	if body.is_in_group("player"):
		player_in_range = true
		target = body

func _on_player_exited(body: Node) -> void:
	if body.is_in_group("player"):
		player_in_range = false
		if state == State.ATTACK:
			state = State.PATROL
			anim.play("Idle")

func _on_enemy_AnimatedSprite2D_animation_finished() -> void:
	if anim.animation == "atack":
		if player_in_hitbox and not damage_dealt_this_attack:
			player_in_hitbox.take_damage(0.5)
			damage_dealt_this_attack = true	
		anim.play("Idle")
		move_and_slide()
		
func _on_attack_hitbox_body_entered(body: Node) -> void:
	player_in_hitbox = body
	if state != State.ATTACK:
			state = State.ATTACK
			anim.play("atack")
			damage_dealt_this_attack = false
	if body.is_in_group("player") and not damage_dealt_this_attack and anim.animation == "atack":
		body.take_damage(0.5)
		damage_dealt_this_attack = true
		
func _on_attack_hitbox_body_exited(body: Node) -> void:
	player_in_hitbox = null
	if state == State.ATTACK:
		state = State.PATROL
		

func _on_area_2d_body_entered(body: Node) -> void:
	if body.is_in_group("projectile"):
		hp -= 50
		if body.ice:
			velocity.x = 0
			_apply_effect("ice", 5.0)
		elif body.fire:
			_apply_effect("fire", 5.0)
		if hp <= 0:
			queue_free()

func _apply_effect(effect_type: String, duration: float) -> void:
	state = State.STUNNED
	if effect_type == "fire":
		fire_anim.play()
		fire_anim.visible = true
	elif effect_type == "ice":
		ice_anim.play()
		ice_anim.visible = true
	else:
		anim.play(effect_type)
	effect_timer.start(duration)

func _on_effect_timeout() -> void:
	state = State.PATROL
	fire_anim.visible = false
	ice_anim.visible = false
	anim.play("Idle")

func _update_sprite_flip() -> void:
	anim.flip_h = not anim.flip_h

func _update_floor_checker() -> void:
	floor_checker.position.x = abs(floor_checker.position.x) * direction
