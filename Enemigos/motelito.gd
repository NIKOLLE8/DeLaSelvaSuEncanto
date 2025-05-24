extends CharacterBody2D

var vida = 4
const SPEED = 350.0
@export var distanciaMov:  int
@export var retrasoInicial : float
@export var saber : int
const gravity := 30
@onready var impacto := $CollisionShape2D

@onready var shoot_audio = $escupir
@onready var colision_motelito = $colision

# Get the gravity from the project settings to be synced with RigidBody nodes.
@onready var sprite := $"Sprite2D"
@onready var TOXICO1 := preload("res://Enemigos/toxico.tscn")
@onready var TOXICO2 :=preload("res://Enemigos/toxico_izq.tscn")
var T

@onready var inicioX : float = position.x
@onready var objetivoX : float = position.x + distanciaMov
@onready var shoot_timer = Timer.new()

var tiempoPasado : float = 0.0
var empezarMovimiento : bool = false

func _ready():
	direcion_sprite()

	add_child(shoot_timer)
	shoot_timer.wait_time = 1.0
	shoot_timer.connect("timeout", Callable(self, "_on_shoot_timer_timeout"))
	

func _physics_process(delta: float) -> void:
	
	tiempoPasado += delta
	
	if tiempoPasado >= retrasoInicial and !empezarMovimiento:
		empezarMovimiento = true
		shoot_timer.start()
		
	if empezarMovimiento:
		position.x = move_toward(position.x, objetivoX, SPEED * delta)
		
		
	velocity.y += gravity
		
	move_and_slide()
	
func _on_shoot_timer_timeout():
	toxico()
	shoot_audio.play()

func toxico():
	var scene_toxico
	var punto_toxico
	if distanciaMov <= 0:
		scene_toxico = TOXICO1
		punto_toxico = $"toxico1".global_position
	else:
		scene_toxico = TOXICO2
		punto_toxico = $"toxico2".global_position
		
	T = scene_toxico.instantiate()
	T.position = punto_toxico
	get_parent().add_child(T)
	T.get_node("toxico")
	
	
func _on_area_2d_area_entered(area):
	if area.is_in_group("flecha"):
		vida -= 1  
		if vida <= 0:
			Puntuacion.update_score(60)
			queue_free()
			if saber == 4:
				cambiar_escena()
		area.queue_free()
		colision_motelito.play()

func cambiar_escena():
	animation.change_scene("res://Mundos/final_ganador.tscn")
	
func direcion_sprite():
	if distanciaMov > 0:
		sprite.flip_h = not sprite.flip_h
