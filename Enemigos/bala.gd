extends Area2D

@export var speedBalaizq = 100
@export var direction = Vector2.RIGHT


func _physics_process(_delta):
	position.x += 10


func set_direction(new_direction):
	direction = new_direction
