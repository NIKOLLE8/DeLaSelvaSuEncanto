extends CharacterBody2D

var vida = 2
const SPEED = 300.0
@export var distanciaMov:  int
@export var retrasoInicial : float
@export var saber : int
const gravity := 30
@onready var impacto := $CollisionShape2D


@onready var sprite := $"Sprite2D"
@onready var BALA1 := preload("res://Enemigos/cacao.tscn")
@onready var BALA2 :=preload("res://Enemigos/cacao_izq.tscn")
var C

@onready var shoot_audio = $molesto
@onready var colision_chulla = $colision

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
	cacao()
	colision_chulla.play()

func cacao():
	var scene_cacao
	var punto_cacao
	if distanciaMov >= 0:
		scene_cacao = BALA1
		punto_cacao = $"cacao1".global_position
	else:
		scene_cacao = BALA2
		punto_cacao = $"cacao2".global_position
		
	C = scene_cacao.instantiate()
	C.position = punto_cacao
	get_parent().add_child(C)
	C.get_node("cacao")
	
	
func _on_area_2d_area_entered(area):
	if area.is_in_group("flecha"):
		vida -= 1  
		if vida <= 0:
			Puntuacion.update_score(30)
			queue_free()
			if saber == 3:
				cambiar_escena()
		area.queue_free() 
		shoot_audio.play()
		
func cambiar_escena():
	animation.change_scene("res://Mundos/nivel_3.tscn")
	Nivel.update_level(1)
