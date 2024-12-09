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

# Wenn ein Projektil den Area2D betritt
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("projectile") :  # Sicherstellen, dass es ein Projektil ist
		body.remove_from_group("projectile")
		# Berechne die Richtung basierend auf der Position des Projektils
		var impact_direction = sign(global_position.x - body.global_position.x)

		# Wende die Impact-Kraft an (nach links oder rechts)
		velocity.x += impact_direction * IMPACT_FORCE
		is_impacting = true  # Setze das Flag, dass ein Impact stattgefunden hat
