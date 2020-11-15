extends Control

export var bars_num = 7
export var bars_active_num = 1
export var denied = true setget set_denied

var _bars: Array

# Called when the node enters the scene tree for the first time.
func _ready():
	recreate()
	update()

func activate(amount: int):
	bars_active_num = (bars_active_num + amount) % bars_num
	update()

func recreate():
	for i in _bars:
		remove_child(i)
	_bars.clear()
	
	var offset = rect_size.x / bars_num
	
	for i in bars_num:
		var rect = ColorRect.new()

		var this_rect_size = self.rect_size
		if(i != bars_num - 1):
			this_rect_size.x = offset + 1
		else:
			this_rect_size.x = offset
		rect.rect_size = this_rect_size
		
		var this_rect_pos = Vector2(offset * i, 0)
		rect.rect_position = this_rect_pos
		
		_bars.append(rect)
		add_child(rect)

func update():
	var flag = true
	var counter = _bars.size()
	
	for i in range(0, _bars.size()):
		if(i < bars_active_num):
			# active bars
			_bars[i].color = Color("bde70e")
			move_child(_bars[i], counter)
			counter -= 1
		else:
			# red flash bar
			if(flag):
				flag = false
				move_child($ColorRect, counter)
				counter -= 1
				
				if(denied):
					blink_denied(0.2, 3)
			
			# inactive bars
			_bars[i].color = Color("C2DED8")
			move_child(_bars[i], counter)
			counter -=1

func blink_denied(duration: float, times: int):
	var cur_color = $ColorRect.color
	cur_color.a = 0
	var new_color = cur_color
	new_color.a = 1
	$Tween.stop_all()
	for i in times:
		$Tween.interpolate_property($ColorRect, "color",
			cur_color, new_color, duration,
			Tween.TRANS_LINEAR, Tween.EASE_OUT, i * 2 * duration)
		$Tween.interpolate_property($ColorRect, "color",
			new_color, cur_color, duration,
			Tween.TRANS_LINEAR, Tween.EASE_IN, (i * 2 + 1) * duration)
	$Tween.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func set_denied(new_value: bool):
	denied = new_value
	update()


func _on_Control_resized():
	recreate()
	update()
