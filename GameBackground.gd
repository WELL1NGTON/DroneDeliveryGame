extends Node2D

onready var constructions = $Constructions
onready var houses = constructions.get_used_cells_by_id(constructions.tile_set.find_tile_by_name("house.png"))
onready var buildings = constructions.get_used_cells_by_id(constructions.tile_set.find_tile_by_name("building.png"))
onready var post_offices = constructions.get_used_cells_by_id(constructions.tile_set.find_tile_by_name("postoffice.png"))
var simple_arrow_scene = preload("res://scenes/SimpleArrow.tscn")

var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
#	for house in houses:
#		constructions.set_cell(house.x, house.y, -1)
#	for building in buildings:
#		constructions.set_cell(building.x, building.y, -1)
	var random_construction_position = constructions.map_to_world(get_random_construction())
	print("position = " + str(random_construction_position))
	var static_body = StaticBody2D.new()
	var collision_shape_2d = CollisionShape2D.new()
	var simple_arrow = simple_arrow_scene.instance()
	simple_arrow.position.x = random_construction_position.x + 128
	simple_arrow.position.y = random_construction_position.y + 30
	get_tree().get_root().get_node("./DroneGame/Objective").add_child(simple_arrow)
	pass
	
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
