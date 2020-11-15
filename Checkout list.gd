extends Control

var total = 0

var vars

# Called when the node enters the scene tree for the first time.
func _ready():
	vars = get_node("/root/GlobalVars")


func redraw(items):
	var plates = _remove_zero_amounted(items)
	_remove_old_nodes()
	total = 0
	
	for i in range(0, plates.size()):
		var node = preload("res://Checkout item.tscn").instance()
		add_child(node)
		node.margin_bottom = 0
		node.margin_top = 24
		node.margin_left = 12
		node.margin_right = -4
		if(i == 0):
			node.anchor_top = 0.015
			node.anchor_bottom = 0.115
		else:
			node.anchor_top = (0.1 * i) + 0.015
			node.anchor_bottom = (0.1 * (i + 1)) + 0.015
		node.anchor_right = 1
		node.init(plates[i].res_name,
				 plates[i].price, plates[i].buy_amount)
		total += plates[i].price * plates[i].buy_amount
	
	var text = "Total: "
	if (total > vars.money):
		text += "[color=red]" + str(total) + "[/color]"
	else:
		text += str(total)
	text += "[color=green]$[/color]"
	$"Total label".bbcode_text = text

func _remove_old_nodes():
	var old_nodes_indexes: Array
	var children = get_children()
	for i in range(0, children.size()):
		if(children[i].get_class() == "checkout_item"):
			old_nodes_indexes.append(i)
	for i in range(old_nodes_indexes.size() -1, -1, -1):
		remove_child(children[old_nodes_indexes[i]])

func _remove_zero_amounted(var items):
	var zero_amounted_indexes: Array
	for i in range(0, items.size()):
		if(items[i].buy_amount == 0):
			zero_amounted_indexes.append(i)
	for i in range(zero_amounted_indexes.size() -1, -1, -1):
		items.remove(zero_amounted_indexes[i])
	return items

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Checkout_button_pressed():
	if (total < vars.money):
		SignalManager.emit_signal("checkout")
		SignalManager.emit_signal("res_changed")
	else:
		pass
