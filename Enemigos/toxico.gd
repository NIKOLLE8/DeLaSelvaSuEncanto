extends Area2D

@export var speedcacao = 200
@export var direction = Vector2.RIGHT


func _physics_process(_delta):
	position.x -= 18


func set_direction(new_direction):
	direction = new_direction
