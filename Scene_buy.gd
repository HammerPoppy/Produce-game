extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.connect("buy_amount_change", self, "_on_buy_amount_change")
	_update_checkout_list()


func _process(delta):
	pass

func _on_buy_amount_change():
	_update_checkout_list()

func _update_checkout_list():
	var children = get_children()
	children = _remove_non_plates(children)
	$"Checkout list".redraw(children)

func _remove_non_plates(var children):
	var non_plates_indexes: Array
	for i in range(0, children.size()):
		if(children[i].get_class() != "plate_buy"):
			non_plates_indexes.append(i)
	for i in range(non_plates_indexes.size() -1, -1, -1):
		children.remove(non_plates_indexes[i])
	return children
