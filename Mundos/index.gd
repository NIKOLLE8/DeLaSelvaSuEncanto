extends Node2D


func _on_jugar_pressed():
	animation.change_scene("res://Mundos/mundo.tscn")


func _on_salir_pressed():
	get_tree().quit()
	
