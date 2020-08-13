extends Node2D

onready var constructions = $Constructions
onready var houses = constructions.get_used_cells_by_id(constructions.tile_set.find_tile_by_name("house.png"))
onready var buildings = constructions.get_used_cells_by_id(constructions.tile_set.find_tile_by_name("building.png"))
onready var post_offices = constructions.get_used_cells_by_id(constructions.tile_set.find_tile_by_name("postoffice.png"))
var post_office_area_2d = preload("res://scenes/PostOffice/PostOffice.tscn")

var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
#	for house in houses:
#		constructions.set_cell(house.x, house.y, -1)
#	for building in buildings:
#		constructions.set_cell(building.x, building.y, -1)
	var static_body = StaticBody2D.new()
	var collision_shape_2d = CollisionShape2D.new()
	load_post_offices_areas(post_offices)
	
func get_random_construction():
	if rng.randi_range(0,1) == 0: #0 houses, 1 buildings
		print("house selected")
		return houses[rng.randi_range(0,houses.size() - 1)]
	else:
		print("another building selected")
		return buildings[rng.randi_range(0,buildings.size() - 1)]

func get_post_office_position():
	if post_offices.size() > 0:
		return constructions.map_to_world(post_offices[0]) + Vector2(215,100)
	else:
		return Vector2.ZERO

func load_post_offices_areas(post_offices : Array):
	for post_office in post_offices:
		var post_office_area_instance = post_office_area_2d.instance()
		post_office_area_instance.position = constructions.map_to_world(post_office)
		get_node("/root/DroneGame/PostOffices").add_child(post_office_area_instance)
