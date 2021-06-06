extends Control

export var res_name = "Resource"
export var price: float = 0

var buy_amount = 0
var res_id

var init_res_amount = 0

var sound_player

var vars

func get_class(): return "plate_buy"

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.connect("checkout", self, "_on_checkout")
	
	sound_player = get_node("ButtonSoundPlayer")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$"Amount label".text = "Stock " + str(vars.res_available[get_res_id()])
	# helps with displaying bug MAGIC DONT TOUCH
	_on_Price_label_ready()

func _on_Add_pressed():
	sound_player.play()
	buy_amount += 1
	_buy_amount_changed()

func _on_Sub_pressed():
	sound_player.play()
	if(buy_amount > 0):
		buy_amount -= 1
		_buy_amount_changed()

func _buy_amount_changed():
	_update_main_label()
	SignalManager.emit_signal("buy_amount_change")

func _update_main_label():
	var text = " " + str(buy_amount) + " x " + str(price) + "$\n"
	var text_offset = str(buy_amount).length() + str(price).length() + 4 - (str(buy_amount * price).length() + 3) 
	for i in range (0, text_offset):
		text += " "
	text += " = " + str(buy_amount * price) + "$"
	$"Bot line/Buy amount label".text = text

func _get_amount():
	return vars.res_available[get_res_id()]

func _on_Buy_amount_label_ready():
	_init_amounts()
	_update_main_label()

func _init_amounts():
	vars = get_node("/root/GlobalVars")
	vars.res_available[get_res_id()] = init_res_amount

func get_res_id():
	if (res_id == null):
		for i in range(0, vars.res_names.size()):
			if(vars.res_names[i] == res_name):
				res_id = i
				break
	return res_id

func _on_checkout():
	vars.money -= buy_amount * price
	vars.res_available[get_res_id()] += buy_amount
	buy_amount = 0
	_buy_amount_changed()

func _on_Resource_name_label_ready():
	$"Resource name label".text = res_name

func _on_Price_label_ready():
	$"Price label".bbcode_text = "[center]" + str(price) + "[color=green]$[/color][/center]"
