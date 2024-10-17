extends CharacterBody2D

var hp = 100
@onready var animated_sprite_2d = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if hp <= 0:
		queue_free()

func _on_area_2d_body_entered(body):
	if body.is_in_group("projectile"):
		animated_sprite_2d.play("hit")
		hp -= 50
