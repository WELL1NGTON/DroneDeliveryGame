extends Node2D

const MAX_SPEED = 20
const MAX_ACCELERATION = 40
const MAX_FORCE = 0.001
var motion = Vector2.ZERO
var direction = Vector2.ZERO
var velocity = Vector2.ZERO
var acceleration = Vector2.ZERO

var alignmentMultiplier = 0.1
var cohesionMultiplier = 0.1
var separationMultiplier = 0.1

func _physics_process(delta):
	flock()
	self.position += velocity
	self.velocity += acceleration
	self.velocity.clamped(MAX_SPEED)
	self.acceleration *= 0
#	apply_movement(direction * MAX_ACCELERATION * delta)
#	position += motion
	self.rotation = velocity.angle() - PI/2
	edges()

func apply_movement(acceleration):
	motion += acceleration
	motion = motion.clamped(MAX_SPEED)

func align(boids):
	var perceptionRadius = 320/2
	var steering = Vector2.ZERO
	var total = 0
	for boid in boids:
		var bird = boid.get_parent()
		steering += bird.velocity
		total += 1
	if total > 0:
		steering /= total
		steering = steering.normalized() * MAX_SPEED
		steering -= self.velocity
		steering.clamped(MAX_FORCE)
	return steering

func cohesion(boids):
	var perceptionRadius = 320
	var steering = Vector2.ZERO
	var total = 0
	for boid in boids:
		var bird = boid.get_parent()
		if self.position.distance_to(bird.position) < perceptionRadius:
			steering += bird.position
			total += 1
	if total > 0:
		steering /= total
		steering -= self.position
		steering = steering.normalized() * MAX_SPEED
		steering -= self.velocity
		steering.clamped(MAX_FORCE)
	return steering

func separation(boids):
	var perceptionRadius = 320/2
	var steering = Vector2.ZERO
	var total = 0
	for boid in boids:
		var bird = boid.get_parent()
		var distance = self.position.distance_to(bird.position)
		if distance < perceptionRadius:
			var diff = self.position - bird.position
			diff /= distance * distance
			steering += diff
			total += 1
	if total > 0:
		steering /= total
		steering = steering.normalized() * MAX_SPEED
		steering -= self.velocity
		steering.clamped(MAX_FORCE)
	return steering

func flock():
	var boids = $PerceptionRadius.get_overlapping_areas()
	var alignmentValue = self.align(boids)
	var cohesionValue = self.cohesion(boids)
	var separationValue = self.separation(boids)
	
	alignmentValue *= alignmentMultiplier
	cohesionValue *= cohesionMultiplier
	separationValue *= separationMultiplier
	
	acceleration += alignmentValue
	acceleration += cohesionValue
	acceleration += separationValue


func edges():
	if self.position.x > 3000:
		self.position.x = -6500
	elif self.position.x < -7000:
		self.position.x = 2500
		
	if self.position.y > 2500:
		self.position.y = -4000
	elif self.position.y < -4500:
		self.position.y = 2000
