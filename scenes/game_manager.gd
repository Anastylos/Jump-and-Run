extends Node

@onready var lbScore = %score

var score = 0

func _ready():
	lbScore.set_text("Collected Coins: " + str(score))

func add_point():
	score += 1
	lbScore.set_text("Collected Coins: " + str(score))
	
