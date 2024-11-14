extends CharacterBody2D

var hp = 100
@onready var animated_sprite_2d = $enemy_AnimatedSprite2D
@onready var fire_animation = $enemy_AnimatedSprite2D/fire_AnimatedSprite2D
@onready var ice_animation = $enemy_AnimatedSprite2D/ice_AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if not is_on_floor():
			velocity += get_gravity() * delta
	
	if hp <= 0:
		queue_free()
		
	move_and_slide()

func _on_area_2d_body_entered(body):
	if body.is_in_group("projectile"):
		animated_sprite_2d.play("hit")
		hp -= 50
		if body.fire == true:
			fire_animation.visible = true
			fire_animation.play("fire")
		if body.ice == true:
			ice_animation.visible = true
			ice_animation.play("ice")
			
			


func _on_animated_sprite_2d_animation_finished():
	if animated_sprite_2d.animation == "hit":
		animated_sprite_2d.play("Idle")
