extends Label

var vars

# Called when the node enters the scene tree for the first time.
func _ready():
	vars = get_node("/root/GlobalVars")

func _process(delta):
	text = str(vars.money) + "$"
