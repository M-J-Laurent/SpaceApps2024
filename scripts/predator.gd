extends CharacterBody2D
class_name Predator

var col= CollisionShape2D.new()
var image = Sprite2D.new()
var body

var maxHunger: float = 100
var currentHunger: float 
var speed: float = 50
	#Right now there is not a specific life that the predator is charging
var target: Vector2 = Vector2.ZERO
var huntingRadius: float = 5000000



static func create(location: Vector2, image, hunger:float):
	var this = Predator.new()
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
	#hunger goes down periodically
	currentHunger -= 0.1
	
	#When the hunger is below half of max hunger, find food 
	if target!=Vector2.ZERO: 
		goToTarget(delta)
	
	move_and_slide()
	
	
	
func is_Hungry():
	if currentHunger<= maxHunger/2: return true
	return false

			
	
func goToTarget(delta):
	
	if target!=Vector2.ZERO:
		#normalize to make it go to the target at the same speed each time
		var direction = global_position.direction_to(target)
		velocity = direction * speed
		
		
		
func eat(targethealth: float): 
	#every time it eats, the hunger bar goes up by 1/4
	if (maxHunger - currentHunger < 25):
		currentHunger = maxHunger
	else: 
		currentHunger += 25
	velocity=Vector2.ZERO
		
func _is_clicked_fish(event):
	if image.get_rect().has_point(to_local(event.position)):
		return true
	return false
	
	
	
	
