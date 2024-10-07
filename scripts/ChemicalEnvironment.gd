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
var life = preload("res://sprites/tubeWorm.png")
var pred = preload("res://sprites/li04_vw8z_210520-removebg-preview.png")

var rng = RandomNumberGenerator.new()
var Generators:Array[ChemicalGenerator]=[]
var ChemosyntheticOrganisms:Array[ChemosyntheticLife]=[]
var Predators:Array[Predator] = []

@onready var info = %info
# Called when the node enters the scene tree for the first time.
func _ready():
	createEnvironment(10)
	pass # Replace with function body.
	
func groundFunc(x:float):
	return Vector2(x+70, 1080-100+0.8*sin(x/10.0)+20*sin(x/50.0)+60*sin(x/134.0))

func createEnvironment(Amount:int):
	createEnergyProducers(Amount)
	createChemosyntheticLife(Amount)
	createPredator(Amount/2)

func createPredator(amount: int): 
	for i in range(amount):
		var spawnRadius=Generators[i%amount].effectRadius
		var xlocal= rng.randf_range(-spawnRadius,spawnRadius) + Generators[i%amount].global_position.x
		Predators.append(Predator.create(
			Vector2(xlocal, groundFunc(xlocal).y - 200), 
			pred,
			rng.randf_range(70.0,170.0)
		))
		add_child(Predators[i])
		Predators[i].owner=get_tree().edited_scene_root

func createEnergyProducers(amount:int):
	for i in range(amount):
		var GenChemical1 = rng.randi_range(0, ChemicalType.size()-1)
		var GenChemical2 = rng.randi_range(0, ChemicalType.size()-1)
		Generators.append(ChemicalGenerator.create(
			[GenChemical1, GenChemical2], 
			[rng.randf_range(1, 10), rng.randf_range(1, 10)], 
			groundFunc(i*1920/amount), 
			10
		))
		add_child(Generators[i])
		Generators[i].owner=get_tree().edited_scene_root

func createChemosyntheticLife(amount:int):
	var ChemosyntheticChemical = rng.randi_range(0, ChemicalGenerator.ChemicalType.size()-1)
	for i in range(amount*2):
		var spawnRadius=Generators[i%amount].effectRadius
		var xlocal= rng.randf_range(-spawnRadius,spawnRadius)+Generators[i%amount].global_position.x
		ChemosyntheticOrganisms.append(ChemosyntheticLife.create(
			ChemosyntheticChemical,
			500,
			Vector2(xlocal, 1080-120+0.8*sin(xlocal/10.0)+20*sin(xlocal/50.0)+60*sin(xlocal/134.0)),
			life
		))
		add_child(ChemosyntheticOrganisms[i])
		ChemosyntheticOrganisms[i].owner=get_tree().edited_scene_root
		
		
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			for i in range(0,len(ChemosyntheticOrganisms)):
				if ChemosyntheticOrganisms[i]._is_clicked_worm(event):
					info.set_Visible()
					info.textInfo("Worm")
					return 0
			for i in range(0,len(Generators)):
				if Generators[i]._is_clicked(event):
					info.set_Visible()
					info.textInfo("Vent")
					return 0
			for i in range(0,len(Predators)):
				if Predators[i]._is_clicked_fish(event):
					info.set_Visible()
					info.textInfo("Fish")
					return 0
			info.set_Invisible()

func _process(delta):
	ChemosyntheticOrganisms.shuffle()
	for i in range(len(ChemosyntheticOrganisms)):
		for j in range(len(Generators)):
			if Generators[j].canTakeChemicals(ChemosyntheticOrganisms[i].global_position):
				if ChemosyntheticOrganisms[i].neededEnergy in Generators[j].chemicals:
					ChemosyntheticOrganisms[i].eat(Generators[j].takeChemical(ChemosyntheticOrganisms[i].neededEnergy, ChemosyntheticOrganisms[i].getPortion()))
#	print(Generators[0].image.global_position)
	for i in range( len(Predators) ):
		if Predators[i].is_Hungry() and len(Predators) >0 and len(ChemosyntheticOrganisms)>0:
			var minDist=[Predators[0].global_position.distance_to(ChemosyntheticOrganisms[0].global_position),0,0]
			for j in range(len(ChemosyntheticOrganisms)-1,-1,-1):
				var distance = Predators[i].global_position.distance_to(ChemosyntheticOrganisms[j].global_position)
				if distance <= Predators[i].huntingRadius and distance < minDist[0]:
					minDist=[distance,i,j] 
			Predators[minDist[1]].target=ChemosyntheticOrganisms[minDist[2]].global_position
					
			
			for j in range(len(ChemosyntheticOrganisms)-1,-1,-1):
				var Dist=Predators[i].global_position.distance_to(ChemosyntheticOrganisms[j].global_position)
				if Dist < 100:
					Predators[i].eat(ChemosyntheticOrganisms[j].health)
					var dead=ChemosyntheticOrganisms[j]
					ChemosyntheticOrganisms.remove_at(j)
					dead.queue_free()
	for i in range(len(ChemosyntheticOrganisms)-1,-1,-1):
		if ChemosyntheticOrganisms[i].health<=0:
			var dead=ChemosyntheticOrganisms[i]
			ChemosyntheticOrganisms.remove_at(i)
			dead.queue_free()
	for i in range(len(Predators)-1,-1,-1):
		if Predators[i].currentHunger<=0:
			var dead=Predators[i]
			Predators.remove_at(i)
			dead.queue_free()
				
				
#	if tool:
#		print(ChemicalType.find_key(rng.randi_range(0,3)))
	pass
