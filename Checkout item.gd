extends Control

var res_name: String
var price: float
var amount: int

func get_class(): return "checkout_item"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _update():
	$"Resource label".text = res_name
	
	var text = str(amount) + " x " + str(price)
	text += "[color=green]$[/color] = "
	text += str(amount * price) + "[color=green]$[/color]"
	
	$RichTextLabel.bbcode_text = text

func init(res_name: String, price: float, amount: int):
	self.res_name = res_name
	self.price = price
	self.amount = amount
	_update()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
