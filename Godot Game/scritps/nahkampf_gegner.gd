extends CharacterBody2D

var hp = 100
const speed = 30
var direction = 1
var frozen = false  # Zustand für eingefrorenen Gegner
var burning = false  # Zustand für brennenden Gegner
var damagTaken = false
var collider = null

var standstill = false

@onready var floor_checker = $floor_checker
@onready var collision_shape_2d = $ArrowDetectArea/CollisionShape2D
@onready var animated_sprite_2d = $enemy_AnimatedSprite2D
@onready var fire_animation = $enemy_AnimatedSprite2D/fire_AnimatedSprite2D
@onready var ice_animation = $enemy_AnimatedSprite2D/ice_AnimatedSprite2D
@onready var animation_timer: Timer = $enemy_AnimatedSprite2D/animation_Timer  # Timer für Freeze und Burn
@onready var player_detector = $Player_Detector



# Called when the node enters the scene tree for the first time.
func _ready():
	if direction == 1:
		$enemy_AnimatedSprite2D.flip_h = false
	floor_checker.position.x = collision_shape_2d.shape.size.x * direction 
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if frozen:
		# Wenn eingefroren, stoppe die Bewegung und Animation
		velocity.x = 0
		ice_animation.visible = true  # Zeige die Eis-Animation
		ice_animation.play("ice")  # Spiegle die "Ice"-Animation ab
		return  # Keine weiteren Bewegungen, solange eingefroren

	if burning:
		fire_animation.visible = true  # Zeige die Feuer-Animation
		fire_animation.play("fire")  # Spiegle die "Fire"-Animation ab
		return

	# Prüfen auf Wand oder Plattformkanten
	if is_on_wall() or not floor_checker.is_colliding():
		direction = direction * -1  # Richtung wechseln
		update_sprite_flip();
		floor_checker.position.x = collision_shape_2d.shape.size.x * direction 
		
	
	# Gravitationslogik
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Gegner entfernen, wenn HP <= 0
	if hp <= 0:
		queue_free()

	if player_detector.is_colliding():
		collider = player_detector.get_collider()
		if collider.is_in_group("player"):
			if not damagTaken:  # Schaden nur beim ersten Eintritt in die Kollision
				animated_sprite_2d.play("atack")
				standstill = true
				velocity.x = 0
				damagTaken = true  # Schaden wurde zugefügt, also setzen wir die Variable auf true
	else:
		damagTaken = false  # Wenn keine Kollision mehr vorhanden ist, zurücksetzen
		standstill = false
		
	if not standstill:
		# Bewegung des Gegners
		animated_sprite_2d.play("Idle")
		velocity.x = direction * speed
		position.x += direction * speed * delta
	move_and_slide()

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
	$enemy_AnimatedSprite2D.flip_h = not $enemy_AnimatedSprite2D.flip_h 
	player_detector.target_position *= -1

# Wenn der Gegner von einem "ice"-Projektil getroffen wird
func _on_area_2d_body_entered(body):
	if body.is_in_group("projectile"):
		if not animated_sprite_2d.animation == "atack" or animated_sprite_2d.animation == "Idle":
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
			
	


func _on_enemy_animated_sprite_2d_animation_finished():
	if animated_sprite_2d.animation == "atack":
		collider.schaden_nehmen(0.5)
		# Nach der Animation erneut prüfen, ob Spieler noch in der Zone ist
		if player_detector.is_colliding():
			var collider = player_detector.get_collider()
			if collider.is_in_group("player"):
				# Spieler ist noch da, also erneut angreifen
				damagTaken = false  # Rücksetzen, damit Angriff erneut möglich ist
