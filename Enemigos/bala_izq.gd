extends Area2D

@export var speedBala = 100

func _physics_process(_delta):
	position.x -= 10
