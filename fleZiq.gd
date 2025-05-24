extends Area2D

@export var speedFle = 400

func _physics_process(_delta):
	position.x -= 50
