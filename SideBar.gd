extends Control

var btn1
var btn2
var btn3

var sound_player

var cur_tab = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	btn1 = get_node("btn1")
	btn2 = get_node("btn2")
	btn3 = get_node("btn3")
	
	sound_player = get_node("SidebarButtonsSoundPlayer")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_btn1_pressed():
	sound_player.play()
	cur_tab = 1
	btn1.disabled = true
	btn2.disabled = true
	btn3.disabled = true
	SignalManager.emit_signal("first_tab")


func _on_btn2_pressed():
	sound_player.play()
	cur_tab = 2
	btn1.disabled = true
	btn2.disabled = true
	btn3.disabled = true
	SignalManager.emit_signal("second_tab")


func _on_btn3_pressed():
	sound_player.play()
	cur_tab = 3
	btn1.disabled = true
	btn2.disabled = true
	btn3.disabled = true
	SignalManager.emit_signal("third_tab")


func _on_Tween_tween_all_completed():
	if(cur_tab == 1):
		btn2.disabled = false
		btn3.disabled = false
	if(cur_tab == 2):
		btn1.disabled = false
		btn3.disabled = false
	if(cur_tab == 3):
		btn1.disabled = false
		btn2.disabled = false
