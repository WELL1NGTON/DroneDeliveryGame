extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var game_bg = $Background
onready var post_office_position = game_bg.get_post_office_position()
onready var player = $Player

func _ready():
	player.position = post_office_position
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
