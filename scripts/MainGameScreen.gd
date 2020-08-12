extends Node2D


var simple_arrow_scene = preload("res://scenes/SimpleArrow.tscn")
onready var game_bg = $Background
onready var post_office_position = game_bg.get_post_office_position()
onready var player = $Player
onready var objective = $Objective

func _ready():
	player.position = post_office_position
	var random_construction_position = $Background.constructions.map_to_world($Background.get_random_construction())
	objective.position.x = random_construction_position.x + 128
	objective.position.y = random_construction_position.y + 30
	
	var simple_arrow = simple_arrow_scene.instance()
	get_tree().get_root().get_node("./DroneGame/Objective").add_child(simple_arrow)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
