@tool
extends Node2D

class_name ChemicalGenerator



enum ChemicalType{
	SULFUR,
	CARBODIOXIDE,
	SULFIDE,
	OXYGEN
}

var chemicals:Array[ChemicalType] = []
var concentrations=[]
var effectRadius =0
var ratesOfProduction:Array[float]=[]
var image = CPUParticles2D.new()
var clickBox = Sprite2D.new()
var body = preload("res://sprites/vecteezy_white-circle-png_21115771.png")
var boxText = preload("res://sprites/icon.svg")


static func create(chemicals:Array[int], rates:Array[float], location:Vector2, radius:float):
	if len(chemicals) != len(rates) and len(rates) !=1:
		printerr("Need to have as many rates as you do chemicals")
	var this= ChemicalGenerator.new()
	for i in chemicals:
		this.chemicals.append(i)
	this.ratesOfProduction=rates
	this.global_position =location
	this.effectRadius=radius
	for i in range(len(chemicals)):
		this.concentrations.append(0)
	
	this.image.texture = this.body
	this.clickBox.texture = this.boxText
	
	this.image.amount = 25.0
	this.image.lifetime = 6.0
	this.image.speed_scale = 2.94
	this.image.randomness = 1.0
	this.image.lifetime_randomness = 0.13
	this.image.emission_shape = this.image.EMISSION_SHAPE_SPHERE_SURFACE
	this.image.emission_sphere_radius = 10.0
	this.image.set_gravity(Vector2(0,-10))
	this.image.z_as_relative = false
	this.image.set_z_index(-4)
	
	this.clickBox.visible = false
	this.clickBox.scale = Vector2(0.4, 1)
	
	
	this.add_child(this.image)
	this.add_child(this.clickBox)
	
	return this

# Called when the node enters the scene tree for the first time.
func _ready():
#	var image = Sprite2D.new()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for i in range(len(concentrations)):
		if len(ratesOfProduction)>1:
			concentrations[i]+=ratesOfProduction[i]
		else:
			concentrations[i]+=ratesOfProduction[0]
	pass

func isProducingChemical(target:int):
	for i in range(len(chemicals)):
		if chemicals[i]==target:
			return true
	return false
	
func canTakeChemicals(position:Vector2):
	if (global_position-position).length()<effectRadius:
		return true
	
func takeChemical(chemical:int, portion) -> float:
	var index
	var amount:float=0
	for i in range(len(chemicals)):
		if chemical==chemicals[i]:
			index=i
	if index:
		if portion<=concentrations[index]:
			amount=portion
			concentrations[index]-=portion
		else:
			amount=concentrations[index]
			concentrations[index]=0
	return amount
	
	
func _is_clicked(event):
	if clickBox.get_rect().has_point(to_local(event.position)):
		return true
	return false

