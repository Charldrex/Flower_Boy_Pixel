extends Node


@onready var score_label = $ScoreLabel


func add_point():
	Global.score += 1
	score_label.text = "Conseguiste " + str(Global.score) + " monedas."
	
