extends Node

var money = 10

var res_names = ["Metal", "Concrete", "Plastic", "Rubber",
				 "Wood", "Cloth", "Tarpaper"]
var res_available = [0, 0, 0, 0,
					 0, 0, 0]
var res_prices = [2.05, 2.9, 3.78, 3.66, 5.99, 8.2, 13.39]

var items_names =  ["Parts", "Rebar", "Carpet", "Electronics",
					"Sofa", "Furniture", "Roof tile", "Wall tile",
					"Door", "Window", "Boiler", "Device",
					"Boiler room", "Kitchen", "Living room",
					"Building", "House"]
var items_stock =  [0, 0, 0, 0,
					0, 0, 0, 0,
					0, 0, 0, 0,
					0, 0, 0,
					0, 0,]
var items_prices = [2.8, 5.68, 49.8, 11.04,
					83.8, 44.83, 91.63, 37.76,
					39.79, 40.27, 57.65, 97.74,
					780.86, 1825.79, 2074.5,
					2263.81, 55689.45]

func _ready():
	pass # Replace with function body.

func _process(delta):
	pass
