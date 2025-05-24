extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	update_score_label()

func _process(delta):
	update_score_label()

func update_score_label():
	text = "Puntuacion  "+str(Puntuacion.get_score())
