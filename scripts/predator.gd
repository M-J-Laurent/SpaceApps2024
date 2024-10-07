extends CharacterBody2D
class_name Predator

var col= CollisionShape2D.new()
var image = Sprite2D.new()
var body


var rng = RandomNumberGenerator.new()
var switch=0
var switchTime=rng.randf_range(3,6)
var randomDir=Vector2(1,0)
var maxHunger: float = 100
var currentHunger: float 
var speed: float = 50
var runSpeed: float = speed*2
	#Right now there is not a specific life that the predator is charging
var target: Vector2 = Vector2.ZERO
var huntingRadius: float = 5000000
var hungerDecay=-0.01



static func create(location: Vector2, image, hunger:float):
	var this = Predator.new()
	this.maxHunger = hunger
	this.currentHunger = hunger
	this.global_position = location
	this.image.texture = image
	
	var shape=CircleShape2D.new()
	shape.radius=max(image.get_size().x*0.5,image.get_size().y*0.5)
	this.col.shape=shape
	this.add_child(this.image)
	this.add_child(this.col)
	this.scale=Vector2(0.1,0.1)
	
	return this

	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if hungerDecay>-0.01:
		hungerDecay-=0.01
	#hunger changes at every frame
	if currentHunger+hungerDecay<=maxHunger:
		currentHunger += hungerDecay
	
	
	switch+=delta
	if switch>switchTime:
		switch=0
		var dir=[-1,1]
		randomDir=Vector2(dir[rng.randi_range(0,1)], global_position.direction_to(Vector2(global_position.x,700+rng.randf_range(-150,150))).y)
	
	
	
	if target!=Vector2.ZERO: 
		goToTarget(delta)
	else:
		if global_position.y>600 and global_position.y<800:
			returnToLevel()
		else:
			velocity.y=0
			goToRandom()
	move_and_slide()
	
	
	
func is_Hungry():
	if currentHunger<= (maxHunger/4)*3:
#		print(currentHunger, " ", maxHunger," ", (maxHunger/4)*3)
		return true
	return false

			
	
func goToTarget(delta):
	var direction = global_position.direction_to(target)
	velocity = direction * runSpeed

func returnToLevel():
	velocity.y=-speed

func goToRandom():
	velocity=randomDir*speed
		
func eat(targethealth: float): 
	#every time it eats, the hunger bar goes up by 1/4
	if (maxHunger - currentHunger < maxHunger/2):
		currentHunger = maxHunger
	else: 
		currentHunger += maxHunger/2
	hungerDecay+=2
	velocity=Vector2.ZERO
		

	
	
func _is_clicked_fish(event):
	if image.get_rect().has_point(to_local(event.position)):
		return true
	return false
	
	
	
	
