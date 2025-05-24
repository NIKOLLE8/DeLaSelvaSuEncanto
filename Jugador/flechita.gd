extends Area2D

@export var speedFle = 400
@export var direction = Vector2.RIGHT


func _physics_process(_delta):
	position.x += 50


func set_direction(new_direction):
	direction = new_direction
