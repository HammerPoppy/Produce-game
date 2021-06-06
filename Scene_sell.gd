extends Control

var available_data: Array

var amount_slider
var option_btn
var summary_label

var sell_sound_player
var optionbttn_sound_player
var slidertick_sound_player

var cur_data

var vars

# Called when the node enters the scene tree for the first time.
func _ready():
	vars = get_node("/root/GlobalVars")
	amount_slider = get_node("Control/Amount slider")
	option_btn = get_node("Control/Option button")
	summary_label = get_node("Control/Summary label")
	
	sell_sound_player = get_node("SellSoundPlayer")
	optionbttn_sound_player = get_node("OptionButtonSoundPlayer")
	slidertick_sound_player = get_node("SliderTickSoundPlayer")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Sell_Panel_visibility_changed():
	_update_available_data()
	_update_option()
	_update_slider()
	_update_label()

func _update_available_data():
	available_data.clear()
	for i in range(0, vars.res_available.size()):
		if(vars.res_available[i] > 0):
			var new = [vars.res_names[i], vars.res_prices[i],
						vars.res_available[i], "res", i]
			available_data.append(new)
	for i in range(0, vars.items_stock.size()):
		if(vars.items_stock[i] > 0):
			var new = [vars.items_names[i], vars.items_prices[i],
						vars.items_stock[i], "item", i]
			available_data.append(new)

func _update_option():
	option_btn.clear()
	if(available_data.size() != 0):
		for i in range(0, available_data.size()):
			option_btn.add_item(available_data[i][0])
		cur_data = available_data[0]

func _update_slider():
	if(cur_data != null):
		amount_slider.editable = true
		amount_slider.max_value = cur_data[2]
	else:
		amount_slider.editable = false
	amount_slider.value = 0

func _update_label():
	if(cur_data != null):
		var text = "[center]" + str(amount_slider.value)
		text += " x " + str(cur_data[1]) + " = "
		text += str(amount_slider.value * cur_data[1]) + "[color=green]$[/color][/center]"
		summary_label.bbcode_text = text
	else:
		summary_label.bbcode_text = "[center]Nothing to sell[/center]"

func _on_Sell_btn_pressed():
	if(cur_data != null):
		var amount = amount_slider.value
		vars.money += amount * cur_data[1]
		if(cur_data[3] == "res"):
			vars.res_available[cur_data[4]] -= amount
		if(cur_data[3] == "item"):
			vars.items_stock[cur_data[4]] -= amount
		
		if(amount > 0):
			sell_sound_player.play()
		
		_update_available_data()
		_update_option()
		_update_slider()
		_update_label()


func _on_Option_button_item_selected(id):
	cur_data = available_data[id]
	optionbttn_sound_player.play()
	_update_slider()
	
	
func _on_Option_button_toggled(button_pressed):
	optionbttn_sound_player.play()


func _on_Amount_slider_value_changed(value):
	slidertick_sound_player.play()
	_update_label()
