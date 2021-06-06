extends Node2D

var tween

const vector_3 = Vector2(-3840, 0)
const vector_2 = Vector2(-1920, 0)
const vector1 = Vector2(0, 0)
const vector2 = Vector2(1920, 0)
const vector3 = Vector2(3840, 0)

var layers
var scenes

var cur_scene = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	OS.window_size = Vector2(1280, 720)
	
	layers = [$CanvasLayerBuy, $CanvasLayerProduce, $CanvasLayerSell]
	scenes = [$"CanvasLayerBuy/Buy Panel", $"CanvasLayerProduce/Produce Panel", $"CanvasLayerSell/Sell Panel"]
	tween = get_node("Tween")
	
	SignalManager.connect("first_tab", self, "_on_SideBar_first_tab")
	SignalManager.connect("second_tab", self, "_on_SideBar_second_tab")
	SignalManager.connect("third_tab", self, "_on_SideBar_third_tab")

func _input(event):
	if event.is_action_pressed("toggle_fullscreen"):
		_on_Toggle_Fullscreen()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_SideBar_first_tab():
	_query_scene_slide(1)
	_query_sidebar_frame_slide(1)
	tween.start()


func _on_SideBar_second_tab():
	_query_scene_slide(2)
	_query_sidebar_frame_slide(2)
	tween.start()

func _on_SideBar_third_tab():
	_query_scene_slide(3)
	_query_sidebar_frame_slide(3)
	tween.start()

func _query_scene_slide(to: int):
	var from: int = cur_scene
	
	match[from]:
		[1]:
			match[to]:
				[2]:
					tween.interpolate_property(layers[0],
						"offset", vector1, vector_2,
						0.25, Tween.TRANS_EXPO, Tween.EASE_IN_OUT, 0)
					tween.interpolate_property(scenes[0],
						"visible", true, false,
						0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 0.25)
					tween.interpolate_property(layers[1],
						"offset", vector2, vector1,
						0.25, Tween.TRANS_EXPO, Tween.EASE_IN_OUT, 0)
					scenes[1].visible = true
					cur_scene = 2
				[3]:
					tween.interpolate_property(layers[0],
						"offset", vector1, vector_3,
						0.25, Tween.TRANS_EXPO, Tween.EASE_IN_OUT, 0)
					tween.interpolate_property(scenes[0],
						"visible", true, false,
						0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 0.25)
					scenes[1].visible = true
					tween.interpolate_property(layers[1],
						"offset", vector2, vector_2,
						0.25, Tween.TRANS_EXPO, Tween.EASE_IN_OUT, 0)
					tween.interpolate_property(scenes[1],
						"visible", true, false,
						0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 0.25)
					tween.interpolate_property(layers[2],
						"offset", vector3, vector1,
						0.25, Tween.TRANS_EXPO, Tween.EASE_IN_OUT, 0)
					scenes[2].visible = true
					cur_scene = 3
		[2]:
			match[to]:
				[1]:
					tween.interpolate_property(layers[1],
						"offset", vector1, vector2,
						0.25, Tween.TRANS_EXPO, Tween.EASE_IN_OUT, 0)
					tween.interpolate_property(scenes[1],
						"visible", true, false,
						0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 0.25)
					tween.interpolate_property(layers[0],
						"offset", vector_2, vector1,
						0.25, Tween.TRANS_EXPO, Tween.EASE_IN_OUT, 0)
					scenes[0].visible = true
					cur_scene = 1
				[3]:
					tween.interpolate_property(layers[1],
						"offset", vector1, vector_2,
						0.25, Tween.TRANS_EXPO, Tween.EASE_IN_OUT, 0)
					tween.interpolate_property(scenes[1],
						"visible", true, false,
						0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 0.25)
					tween.interpolate_property(layers[2],
						"offset", vector2, vector1,
						0.25, Tween.TRANS_EXPO, Tween.EASE_IN_OUT, 0)
					scenes[2].visible = true
					cur_scene = 3
		[3]:
			match[to]:
				[2]:
					tween.interpolate_property(layers[2],
						"offset", vector1, vector2,
						0.25, Tween.TRANS_EXPO, Tween.EASE_IN_OUT, 0)
					tween.interpolate_property(scenes[2],
						"visible", true, false,
						0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 0.25)
					tween.interpolate_property(layers[1],
						"offset", vector_2, vector1,
						0.25, Tween.TRANS_EXPO, Tween.EASE_IN_OUT, 0)
					scenes[1].visible = true
					cur_scene = 2
				[1]:
					tween.interpolate_property(layers[2],
						"offset", vector1, vector3,
						0.25, Tween.TRANS_EXPO, Tween.EASE_IN_OUT, 0)
					tween.interpolate_property(scenes[2],
						"visible", true, false,
						0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 0.25)
					scenes[1].visible = true
					tween.interpolate_property(layers[1],
						"offset", vector_2, vector2,
						0.25, Tween.TRANS_EXPO, Tween.EASE_IN_OUT, 0)
					tween.interpolate_property(scenes[1],
						"visible", true, false,
						0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 0.25)
					tween.interpolate_property(layers[0],
						"offset", vector_3, vector1,
						0.25, Tween.TRANS_EXPO, Tween.EASE_IN_OUT, 0)
					scenes[0].visible = true
					cur_scene = 1

func _query_sidebar_frame_slide(position: int):
	tween.interpolate_property($CanvasLayerHUD/SideBar/Frame,
		"rect_position", $CanvasLayerHUD/SideBar/Frame.rect_position, Vector2(0, (position - 1) * 100),
		0.25, Tween.TRANS_EXPO, Tween.EASE_IN_OUT, 0)

func _on_Toggle_Fullscreen():
	OS.window_fullscreen = !OS.window_fullscreen
	get_node("ButtonSoundPlayer").play()
