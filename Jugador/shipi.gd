extends CharacterBody2D


const SPEED = 180.0
var direction := 0.0
var jump := 750
const gravity := 30

@export var vida = 5
var inmune : bool = false

@onready var shoot_audio = $shoot_audio
@onready var colision_shipibo = $colision_shipibo

# Get the gravity from the project settings to be synced with RigidBody nodes.
@onready var sprite := $"Shipivitooño-removebg-preview"
@onready var fle := preload("res://Jugador/flechita.tscn")
@onready var fle_i :=preload("res://Jugador/flechita_izq.tscn")
var f


func _physics_process(_delta):

	# Movimiento horizontal
	direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		sprite.flip_h = direction > 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	# Add the gravity.
	velocity.y += gravity
	
	# Handle Jump. 
	if is_on_floor() and Input.is_action_just_pressed("ui_accept"):
		velocity.y -= jump
	
	
	if Input.is_action_just_pressed("shoot"):
		flechita()
		shoot_audio.play()
		
	move_and_slide()
	

	
func flechita():
	var scene_fle
	var punto_fle = $"punto de disparo".global_position
	
	if sprite.flip_h:
		scene_fle = fle
	else:
		scene_fle = fle_i
	
	f = scene_fle.instantiate()
	f.position = punto_fle
	get_parent().add_child(f)
	f.add_to_group("flecha")
	
	
func vida_control():
	if vida == 5:
		$"../UI/Sprite2D".visible = true
		$"../UI/Sprite2D2".visible = true
		$"../UI/Sprite2D3".visible = true
		$"../UI/Sprite2D4".visible = true
		$"../UI/Sprite2D5".visible = true
	if vida == 4:
		$"../UI/Sprite2D".visible = true
		$"../UI/Sprite2D2".visible = true
		$"../UI/Sprite2D3".visible = true
		$"../UI/Sprite2D4".visible = true
		$"../UI/Sprite2D5".visible = false
	if vida == 3:
		$"../UI/Sprite2D".visible = true
		$"../UI/Sprite2D2".visible = true
		$"../UI/Sprite2D3".visible = true
		$"../UI/Sprite2D4".visible = false
		$"../UI/Sprite2D5".visible = false
	if vida == 2:
		$"../UI/Sprite2D".visible = true
		$"../UI/Sprite2D2".visible = true
		$"../UI/Sprite2D3".visible = false
		$"../UI/Sprite2D4".visible = false
		$"../UI/Sprite2D5".visible = false
	if vida == 1:
		$"../UI/Sprite2D".visible = true
		$"../UI/Sprite2D2".visible = false
		$"../UI/Sprite2D3".visible = false
		$"../UI/Sprite2D4".visible = false
		$"../UI/Sprite2D5".visible = false
	if vida == 0:
		$"../UI/Sprite2D".visible = false
		$"../UI/Sprite2D2".visible = false
		$"../UI/Sprite2D3".visible = false
		$"../UI/Sprite2D4".visible = false
		$"../UI/Sprite2D5".visible = false
		
	
func _on_area_2d_area_entered(area):
	if area.is_in_group("bala"):
		if vida >0:
			vida -= 1
		if vida <= 0 :
			animation.change_scene("res://Mundos/final_perdido.tscn")
		vida_control()
		area.queue_free()
		colision_shipibo.play()
	if area.is_in_group("cacao"):
		if vida >0:
			vida -= 2
		if vida <= 0 :
			animation.change_scene("res://Mundos/final_perdido.tscn")
		vida_control()
		area.queue_free()
		colision_shipibo.play()
	if area.is_in_group("toxico"):
		if vida >0:
			vida -= 3
		if vida <= 0 :
			animation.change_scene("res://Mundos/final_perdido.tscn")
		vida_control()
		area.queue_free()
		colision_shipibo.play()
	
	
		
		
