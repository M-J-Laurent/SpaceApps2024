@tool
extends Node2D

class_name ChemicalGenerator

var image = Sprite2D.new()

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
var body = preload("res://sprites/icon.svg")


static func create(chemicals:Array[int], rates:Array[float], location:Vector2, radius:float):
#	if len(chemicals) != len(rates) and len(rates) !=1:
#		printerr("Need to have as many rates as you do chemicals")
	var this= ChemicalGenerator.new()
	for i in chemicals:
		this.chemicals.append(i)
	this.ratesOfProduction=rates
	this.global_position =location
	this.effectRadius=radius
	for i in range(len(chemicals)):
		this.concentrations.append(0)
	this.image.texture = this.body
	this.add_child(this.image)
	
	
	return this

# Called when the node enters the scene tree for the first time.
func _ready():
#	var image = Sprite2D.new()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func isProducingChemical(target:ChemicalType):
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
