extends Node


var score := 0

func _ready():
	
	score = 0

func update_score(points: int):
	score += points

func get_score() -> int:
	return score 
