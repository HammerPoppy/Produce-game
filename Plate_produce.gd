extends Control

export var item_name = "Item"
export var amount = 0
export var bars_active_num = 0

var item_id

var main

# recipe
var bars_num = 1000
export var rcp_metal = 0
export var rcp_concrete = 0
export var rcp_plastic = 0
export var rcp_rubber = 0
export var rcp_wood = 0
export var rcp_cloth = 0
export var rcp_tarpaper = 0

export var rcp_parts = 0
export var rcp_rebar = 0
export var rcp_carpet = 0
export var rcp_electronics = 0
export var rcp_sofa = 0
export var rcp_furniture = 0
export var rcp_roof_tile = 0
export var rcp_wall_tile = 0
export var rcp_door = 0
export var rcp_window = 0
export var rcp_boiler = 0
export var rcp_device = 0
export var rcp_boiler_room = 0
export var rcp_kitchen = 0
export var rcp_living_room = 0
export var rcp_building = 0
export var rcp_house = 0

export var rcp_work = 1

var res_required = [0, 0, 0, 0, 0, 0, 0]
var res_current =  [0, 0, 0, 0, 0, 0, 0]
var res_complete: bool = false
var item_required = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
var item_current =  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
var item_complete: bool = false
var work_required = 1
var work_current =  0

var vars
var prog_bar

# Called when the node enters the scene tree for the first time.
func _ready():
	vars = get_node("/root/GlobalVars")
	prog_bar = $"Progress bar"
	
	update_recipe_label()
	_update_price_label()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$"Bottom lane/Amount label".text = "Stock " + str(vars.items_stock[get_item_id()])
	update_recipe_label()

func _init_required():
	res_required[0] = rcp_metal
	res_required[1] = rcp_concrete
	res_required[2] = rcp_plastic
	res_required[3] = rcp_rubber
	res_required[4] = rcp_wood
	res_required[5] = rcp_cloth
	res_required[6] = rcp_tarpaper
	
	item_required[0] = rcp_parts
	item_required[1] = rcp_rebar
	item_required[2] = rcp_carpet
	item_required[3] = rcp_electronics
	item_required[4] = rcp_sofa
	item_required[5] = rcp_furniture
	item_required[6] = rcp_roof_tile
	item_required[7] = rcp_wall_tile
	item_required[8] = rcp_door
	item_required[9] = rcp_window
	item_required[10] = rcp_boiler
	item_required[11] = rcp_device
	item_required[12] = rcp_boiler_room
	item_required[13] = rcp_kitchen
	item_required[14] = rcp_living_room
	item_required[15] = rcp_building
	item_required[16] = rcp_house
	
	work_required = rcp_work

func update_recipe_label():
	var offset = 12
	
	var cur_text = "[center]Recipe:[/center]\n"
	for i in range(0, vars.res_names.size()):
		if(res_required[i] != 0):
			var res_line = vars.res_names[i]
			for j in range(0, (offset - res_line.length())):
				res_line += " "
			
			cur_text += res_line
			
			cur_text += str(res_current[i]) + "/" + str(res_required[i]) + " "
			
			if(vars.res_available[i] < res_required[i] - res_current[i]):
				cur_text += "[color=red](" + str(vars.res_available[i]) + ")[/color]\n"
			else:
				cur_text += "(" + str(vars.res_available[i]) + ")\n"
	for i in range(0, vars.items_names.size()):
		if(item_required[i] != 0):
			var item_line = vars.items_names[i]
			for j in range(0, (offset - item_line.length())):
				item_line += " "
			
			cur_text += item_line
			
			cur_text += str(item_current[i]) + "/" + str(item_required[i]) + " "
			
			if(vars.items_stock[i] < item_required[i] - item_current[i]):
				cur_text += "[color=red](" + str(vars.items_stock[i]) + ")[/color]\n"
			else:
				cur_text += "(" + str(vars.items_stock[i]) + ")\n"
	
	cur_text += "Work        "
	cur_text += str(work_current) + "/" + str(work_required) + " \n"
	$"Recipe/Recipe label".bbcode_text = cur_text


func _on_Produce_button_button_down():
	if (!res_complete):
		for i in range (0, res_required.size()):
			if (res_required[i] != 0):
				if(res_current[i] < res_required[i]):
					if (vars.res_available[i] > 0):
						prog_bar.denied = false
						prog_bar.activate(1)
						vars.res_available[i] -= 1
						res_current[i] += 1
						SignalManager.emit_signal("res_changed")
						return
					else:
						prog_bar.denied = true
						return
				else:
					continue
			else:
				continue
		res_complete = true
		
	if (!item_complete):
		for i in range (0, item_required.size()):
			if (item_required[i] != 0):
				if(item_current[i] < item_required[i]):
					if (vars.items_stock[i] > 0):
						prog_bar.denied = false
						prog_bar.activate(1)
						vars.items_stock[i] -= 1
						item_current[i] += 1
						SignalManager.emit_signal("item_changed")
						return
					else:
						prog_bar.denied = true
						return
				else:
					continue
			else:
				continue
		item_complete = true
		
	work_current += 1
	if (work_current != work_required):
		prog_bar.activate(1)
	else:
		vars.items_stock[get_item_id()] += 1
		prog_bar.activate(1)
		SignalManager.emit_signal("item_changed")
		
		for i in range(0, res_current.size()):
			res_current[i] = 0
		res_complete = false
		for i in range(0, item_current.size()):
			item_current[i] = 0
		item_complete = false
		work_current = 0

func get_item_id():
	if (item_id == null):
		for i in range(0, vars.items_names.size()):
			if(vars.items_names[i] == item_name):
				item_id = i
				break
	return item_id

func _on_Progress_bar_ready():
	var progress_bar = $"Progress bar"
	
	_init_required()
	bars_num = 0
	for i in range(0, res_required.size()):
		bars_num += res_required[i]
	for i in range(0, item_required.size()):
		bars_num += item_required[i]
	bars_num += work_required
	progress_bar.bars_num = bars_num
	
	progress_bar.bars_active_num = bars_active_num

func _on_Product_name_label_ready():
	$"Product name label".text = item_name


func _update_price_label():
	var text = "[center]"
	text += str(vars.items_prices[get_item_id()])
	text += "[color=green]$[/color]"
	$"Bottom lane/Price label".bbcode_text = text
