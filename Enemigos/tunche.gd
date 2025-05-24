extends CharacterBody2D


const SPEED = 200.0
@export var distanciaMov:  int
@export var retrasoInicial : float
@export var saber : int
const gravity := 30
@onready var impacto := $CollisionShape2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
@onready var sprite := $"Sprite2D"
@onready var BALA1 := preload("res://Enemigos/bala.tscn")
@onready var BALA2 :=preload("res://Enemigos/bala_izq.tscn")
var B

@onready var shoot_audio = $piedrita
@onready var colision_tunche = $molesto

@onready var inicioX : float = position.x
@onready var objetivoX : float = position.x + distanciaMov
@onready var shoot_timer = Timer.new()

var tiempoPasado : float = 0.0
var empezarMovimiento : bool = false

func _ready():
	add_child(shoot_timer)
	shoot_timer.wait_time = 1.5
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
	balita()
	shoot_audio.play()

func balita():
	var scene_bala
	var punto_bala
	if distanciaMov >= 0:
		scene_bala = BALA1
		punto_bala = $"balita".global_position
	else:
		scene_bala = BALA2
		punto_bala = $"balita2".global_position
		
	B = scene_bala.instantiate()
	B.position = punto_bala
	get_parent().add_child(B)
	B.get_node("bala")
	
	
func _on_area_2d_area_entered(area):
	if area.is_in_group("flecha"):
		colision_tunche.play()
		Puntuacion.update_score(15)
		queue_free()
		if saber == 2:
			cambiar_escena()


func cambiar_escena():
	animation.change_scene("res://Mundos/nivel_2.tscn")
	Nivel.update_level(1)
