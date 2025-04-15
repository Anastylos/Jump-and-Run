extends Area2D

@onready var area_2d = $"."
@onready var animation_player = $AnimationPlayer
@onready var checkpoint_set = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_body_entered(body):
	if body.is_in_group("player"):
		body.checkPoint_Pos = area_2d.global_position
		if !checkpoint_set:
			checkpoint_set = true
			animation_player.play("Flagge")
		
