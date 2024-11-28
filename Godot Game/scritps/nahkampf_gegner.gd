extends CharacterBody2D

var hp = 100
const speed = 45
var direction = -1
var frozen = false  # Zustand für eingefrorenen Gegner
var burning = false  # Zustand für brennenden Gegner

@onready var animated_sprite_2d = $enemy_AnimatedSprite2D
@onready var fire_animation = $enemy_AnimatedSprite2D/fire_AnimatedSprite2D
@onready var ice_animation = $enemy_AnimatedSprite2D/ice_AnimatedSprite2D
@onready var animation_timer: Timer = $enemy_AnimatedSprite2D/animation_Timer  # Timer für Freeze und Burn

# Called when the node enters the scene tree for the first time.
func _ready():
	if direction == 1:
		$enemy_AnimatedSprite2D.flip_h = true
	$floor_checker.position.x = $Area2D/CollisionShape2D.shape.size.x * direction
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if frozen:
		# Wenn eingefroren, stoppe die Bewegung und Animation
		velocity.x = 0
		ice_animation.visible = true  # Zeige die Eis-Animation
		ice_animation.play("ice")  # Spiegle die "Ice"-Animation ab
		return  # Keine weiteren Bewegungen, solange eingefroren

	if burning:
		# Wenn brennend, stoppe die Bewegung und spiele die Brenn-Animation
		velocity.x = 0
		fire_animation.visible = true  # Zeige die Feuer-Animation
		fire_animation.play("fire")  # Spiegle die "Fire"-Animation ab
		return  # Keine weiteren Bewegungen, solange brennend

	# Prüfen auf Wand oder Plattformkanten
	if is_on_wall() or not $floor_checker.is_colliding():
		direction = direction * -1  # Richtung wechseln
		$enemy_AnimatedSprite2D.flip_h = not $enemy_AnimatedSprite2D.flip_h
		$floor_checker.position.x = $Area2D/CollisionShape2D.shape.size.x * direction 
	
	# Gravitationslogik
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Gegner entfernen, wenn HP <= 0
	if hp <= 0:
		queue_free()

	# Bewegung des Gegners
	velocity.x = direction * speed
	move_and_slide()

	position.x += direction * speed * delta

# Funktion, um den Freeze-Effekt zu aktivieren
func freeze():
	frozen = true  # Den Gegner einfrieren
	animation_timer.start(2.0)  # Freeze für 2 Sekunden (die Zeit kannst du nach Bedarf anpassen)
	animated_sprite_2d.stop()  # Stoppe alle aktuellen Animationen, um "frozen" anzuzeigen
	ice_animation.visible = true  # Eis-Animation wird sichtbar
	ice_animation.play("ice")  # Die Eis-Animation abspielen, ohne dass sie sofort stoppt

# Funktion, um den Brenn-Effekt zu aktivieren


# Funktion, die aufgerufen wird, wenn der Animation Timer abgelaufen ist
func _on_animation_timer_timeout():
	frozen = false  # Gegner ist nicht mehr eingefroren
	burning = false  # Gegner ist nicht mehr brennend
	animated_sprite_2d.play("Idle")  # Zurück zur Idle-Animation
	update_sprite_flip()  # Richtungswechsel wieder aktivieren

# Funktion zur Änderung der Sprite-Richtung basierend auf der Bewegungsrichtung
func update_sprite_flip():
	$enemy_AnimatedSprite2D.flip_h = direction == 1  # Wenn Richtung 1, Sprite nach rechts spiegeln

# Wenn der Gegner von einem "ice"-Projektil getroffen wird
func _on_area_2d_body_entered(body):
	if body.is_in_group("projectile"):
		animated_sprite_2d.play("hit")
		hp -= 50
		if body.fire == true:
			fire_animation.visible = true
			fire_animation.play("fire")
			animation_timer.start()
			 # Wenn der Gegner mit "fire" getroffen wird, wird er brennen
		elif body.ice == true:
			ice_animation.visible = true
			ice_animation.play("ice")
			animation_timer.start()  # Der Timer startet auch für die "Ice"-Interaktion
			freeze()  # Wenn der Gegner mit "ice" getroffen wird, wird er eingefroren
