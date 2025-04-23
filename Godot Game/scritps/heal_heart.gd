extends Node2D

var healAmount = 1
@onready var rocketanim = $rocketanim
@onready var area_2d = $Area2D
@onready var collision_shape_2d = $Area2D/CollisionShape2D
@onready var heal_heart = $HealHeart

var healed = false



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body.is_in_group("player") and not healed:
		heal_heart.visible = false
		healed = true
		rocketanim.visible = true
		rocketanim.play("rocket")
		body.heal(healAmount)


func _on_rocketanim_animation_finished():
	queue_free()
