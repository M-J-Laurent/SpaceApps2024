@tool
class_name ChemosyntheticLife
extends CharacterBody2D

var col= CollisionShape2D.new()
var image = Sprite2D.new()
var body


enum ChemicalType{
	SULFUR,
	CARBODIOXIDE,
	SULFIDE,
	OXYGEN
}
var neededEnergy
var maxhealth:float
var health:float
var rateOfHunger:float=0.1
var SPEED:float = 10
var direction:int = 0
var infood:bool=true

static func create(chemical:int, health:float, location:Vector2, image):
	var this= ChemosyntheticLife.new()
	this.neededEnergy=chemical
	this.maxhealth=health
	this.health=health
	this.global_position =location
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
	health-=rateOfHunger
	
	if not is_on_floor():
		velocity.y += 9.8 * delta

	if infood and health>maxhealth/4:
		direction=0
	else:
		findfood()
	
	if direction!=0:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	pass

func eat(portion:float):
	if health+portion<=maxhealth:
		health+=portion
	else:
		health=maxhealth
func getPortion()->float:
	return (maxhealth-health)/2

func findfood():
	var rng=RandomNumberGenerator.new()
	var dir = [-1,1]
	direction=dir[rng.randi_range(0,1)]

func _is_clicked_worm(event):
	if image.get_rect().has_point(to_local(event.position)):
		return true
	return false
