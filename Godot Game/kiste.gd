extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const IMPACT_FORCE = 100.0  # Stärke des Impakts
const DECELERATION = 4.25  # Dämpfungsfaktor (wie schnell er stoppt)

var is_impacting = false  # Flag, um zu prüfen, ob ein Impact stattgefunden hat

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Wenn der Charakter einen Impact hatte, langsamer werden
	if is_impacting:
		# Reduziere die Geschwindigkeit mit einer Dämpfung
		velocity.x = lerp(velocity.x, 0.0, DECELERATION * delta)  # 0.0 ist jetzt ein float
		# Wenn die Geschwindigkeit fast 0 erreicht, stoppe den Dämpfungsprozess
		if abs(velocity.x) < 0.01:
			velocity.x = 0
			is_impacting = false  # Dämpfung abgeschlossen

	move_and_slide()
