extends Node2D

onready var constructions = $Constructions
onready var houses = constructions.get_used_cells_by_id(constructions.tile_set.find_tile_by_name("house.png"))
onready var buildings = constructions.get_used_cells_by_id(constructions.tile_set.find_tile_by_name("building.png"))


func _ready():
	for house in houses:
		constructions.set_cell(house.x, house.y, -1)
	for building in buildings:
		constructions.set_cell(building.x, building.y, -1)
