extends Node2D

const DEFAULT_BIRTS_TO_SPAWN = 2

var rng = RandomNumberGenerator.new()
var bird_scene = preload("res://scenes/Enemy/birds/Bird.tscn")

func _ready():
	rng.randomize()
	spawn_n_birds(20)

func _physics_process(delta):
	align(self.get_children())

func align(birds : Array):
	var steering = Vector2.ZERO
	var total = 0

func spawn_n_birds(n : int):
	for i in range(n):
		self.add_child(generate_new_bird())

func generate_new_bird():
	var bird_position = Vector2.ZERO
	match rng.randi_range(0,3):
		0:
			bird_position = Vector2(rng.randf_range(-6500,-5500), rng.randf_range(-3500,1500))
		1:
			bird_position = Vector2(rng.randf_range(2000,3000), rng.randf_range(-3500,1500))
		2:
			bird_position = Vector2(rng.randf_range(-6000,2500), rng.randf_range(-4500,-3500))
		3:
			bird_position = Vector2(rng.randf_range(-6000,2500), rng.randf_range(1500,2500))
	
	var bird = bird_scene.instance()
	bird.position = bird_position
	bird.direction = Vector2(rng.randf_range(-1,1),rng.randf_range(-1,1)).normalized()
	bird.motion = Vector2(rng.randf_range(-1,1),rng.randf_range(-1,1)).normalized()
	bird.acceleration = Vector2(rng.randf_range(-1,1),rng.randf_range(-1,1)).normalized()
	bird.velocity = Vector2(rng.randf_range(-1,1),rng.randf_range(-1,1)).normalized() * bird.MAX_SPEED
	return bird

func _on_SpawnTimer_timeout():
	spawn_n_birds(DEFAULT_BIRTS_TO_SPAWN)
