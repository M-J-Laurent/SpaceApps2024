@tool
extends Node2D

class_name OceanEnvironment

var tool = false
var arr = []
enum ChemicalType{
	SULFUR,
	CARBODIOXIDE,
	SULFIDE,
	OXYGEN
}
var rng = RandomNumberGenerator.new()
var Generators:Array[ChemicalGenerator]=[]
# Called when the node enters the scene tree for the first time.
func _ready():
	createEnergyProducers(10)
	pass # Replace with function body.
	
func groundFunc(x:float):
	return Vector2(x+70, 1080-100+0.8*sin(x/10.0)+20*sin(x/50.0)+60*sin(x/134.0))

func createEnergyProducers(amount:int):
	for i in range(amount):
		var rng = RandomNumberGenerator.new()
		var chemical1 = ChemicalType.values()[rng.randi_range(0, ChemicalType.size()-1)]
		var chemical2 = ChemicalType.values()[rng.randi_range(0, ChemicalType.size()-1)]
		Generators.append(ChemicalGenerator.create(
			[chemical1, chemical2], 
			[rng.randf_range(1, 10), rng.randf_range(1, 10)], 
			groundFunc(i*1920/amount), 
			10
		))
		add_child(Generators[i])
#		Generators.append(ChemicalGenerator.create([ChemicalType.find_key(rng.randi_range(0,3)), ChemicalType.find_key(rng.randi_range(0,3))], [rng.randf_range(1,10), rng.randf_range(1,10)], groundFunc(i), 10))
#		Generators[i].owner=get_tree().edited_scene_root
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	print(Generators[0].image.global_position)
#	if tool:
#		print(ChemicalType.find_key(rng.randi_range(0,3)))
	pass
