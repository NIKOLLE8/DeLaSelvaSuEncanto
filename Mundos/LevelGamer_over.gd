extends Label


func _ready():
	update_level_label()

func _on_level_changed():
	update_level_label()

func update_level_label():
	text = "Nivel   "+str(Nivel.nivel())
