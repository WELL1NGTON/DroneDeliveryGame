extends Node2D


var simple_arrow_scene = preload("res://scenes/SimpleArrow.tscn")
onready var game_bg = $Background
onready var post_office_position = game_bg.get_post_office_position()
onready var player = $Player
onready var objective = $Objective

func _ready():
	player.position = post_office_position
	objective.position = post_office_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func new_objective():
	var random_construction_position = $Background.constructions.map_to_world($Background.get_random_construction())
	objective.position.x = random_construction_position.x + 128
	objective.position.y = random_construction_position.y + 30
	var simple_arrow = simple_arrow_scene.instance()
	objective.add_child(simple_arrow)
	

func package_delivered(simple_arrow : Node):
	objective.position = post_office_position
	objective.remove_child(simple_arrow)
	var timer = get_node_or_null("./Player/Camera2D/Interface/TimerLabel")
	timer.timer += 10

func game_over():
	$Player.set_process(false)
	$Player.set_physics_process(false)
	$BirdsBoidSpawner.set_process(false)
	$BirdsBoidSpawner/SpawnTimer.disconnect("timeout",$BirdsBoidSpawner,"_on_SpawnTimer_timeout")
	$Player/Camera2D/Interface/TimerLabel.set_process(false)
	$Player/Camera2D/Interface/EnergyBar.set_process(false)
	$Player/Camera2D/Interface/GameOverScreen/CenterContainer/VBoxContainer/Label.text = $Player/Camera2D/Interface/DeliveriesCounter/Label.text + " ENCOMENDAS ENTREGUES"
	$Player/Camera2D/Interface/GameOverScreen.visible = true
#	get_tree().change_scene("res://game_over_screen/GameOverScreen.tscn")
