extends RigidBody2D
class_name RigidKiste

@onready var is_burning = false
@onready var can_spread = false

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var destroyTimer = $DestroyTimer
@onready var spread_timer = $SpreadTimer


func _process(delta):
	for body in get_colliding_bodies():
		if body is RigidKiste:
			if  !body.is_burning and is_burning and can_spread:
				body.is_burning = true
				body.start_burn_anim(body)

func _on_child_entered_tree(node):
	if node.is_in_group("projectile"):
		if node.fire:
			is_burning = true
			start_burn_anim(self)
			

func start_burn_anim(body):
	body.animated_sprite_2d.visible = true
	body.animated_sprite_2d.play("Burning")
	spread_timer.start()
	destroyTimer.start()

func _on_destroy_timer_timeout():
	queue_free() # Replace with function body.


func _on_spread_timer_timeout():
	can_spread = true
