extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const IMPACT_FORCE = 100.0  # Strength of the impact
const DECELERATION = 4.25  # Damping factor (how quickly it slows down)

var is_impacting = false  # Flag to check if an impact occurred

func _physics_process(delta: float) -> void:
	# Add gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# If the character had an impact, start slowing down
	if is_impacting:
		# Reduce velocity with damping
		velocity.x = lerp(velocity.x, 0.0, DECELERATION * delta)  # 0.0 is now a float
		# If velocity is close to 0, stop the damping process
		if abs(velocity.x) < 0.01:
			velocity.x = 0
			is_impacting = false  # Damping complete

	move_and_slide()
