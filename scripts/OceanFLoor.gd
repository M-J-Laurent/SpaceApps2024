@tool
extends StaticBody2D
class_name Bounds
var ground = Polygon2D.new()
var groundCol = CollisionPolygon2D.new()
var left = Polygon2D.new()
var leftCol = CollisionPolygon2D.new()
var right = Polygon2D.new()
var rightCol = CollisionPolygon2D.new()
var border = Polygon2D.new()
var borderCol = CollisionPolygon2D.new()

var sandText= preload("res://sprites/abrasive-beige-surface.jpg")
	# Called when the node enters the scene tree for the first time.
func groundFunc(x:float):
	return Vector2((x)+(-1920/2.0), -100+0.8*sin((x)/10)+20*sin((x)/50.0)+60.0*sin((x)/134.0))
func leftWallFunc(x:float):
	return Vector2(50*(log(x + 80))-210, x-540)
func rightWallFunc(x:float):
	return Vector2(-50*log(x+80)+210,x-540)
	

func _ready() -> void:
	
	ground.global_position=Vector2(1920/2.0,1080)
	groundCol.global_position=Vector2(1920/2.0,1080)	 
		
	var points = PackedVector2Array([ Vector2(1920/2.0,0),Vector2(-1920/2.0,0)])
	for x in range(0,1920):
		points.append(groundFunc(x))
	ground.set_polygon(points)
	#print(points)
	var point2=PackedVector2Array([ Vector2(1920/2.0,0),Vector2(-1920/2.0,0)])
	for i in range(0,1920,10):
		point2.append(groundFunc(i))
	groundCol.set_polygon(point2)
	
	
	left.global_position=Vector2(0,1080/2.0)
	leftCol.global_position=Vector2(0,1080/2.0)
	var point3 = PackedVector2Array([ Vector2(0,540),Vector2(0,-540)])
	for x in range(0,1080):
		point3.append(leftWallFunc(x))
	left.set_polygon(point3)
	#print(points)
	var point4 = PackedVector2Array([ Vector2(0,540),Vector2(0,-540)])
	for i in range(0,1080,10):
		point4.append(leftWallFunc(i))
	leftCol.set_polygon(point4)
	
	
	right.global_position=Vector2(1920,1080/2)
	rightCol.global_position=Vector2(1920,1080/2)
	var point5 = PackedVector2Array([ Vector2(0,540),Vector2(0,-540)])
	for x in range(0,1080):
		point5.append(rightWallFunc(x))
	right.set_polygon(point5)

	var point6 = PackedVector2Array([ Vector2(0,540),Vector2(0,-540)])
	for i in range(0,1080,10):
		point6.append(rightWallFunc(i))
	rightCol.set_polygon(point6)
	
	
	
	ground.texture = sandText
	ground.texture_repeat=CanvasItem.TEXTURE_REPEAT_ENABLED
	left.texture = sandText
	left.texture_repeat=CanvasItem.TEXTURE_REPEAT_ENABLED
	right.texture = sandText
	right.texture_repeat=CanvasItem.TEXTURE_REPEAT_ENABLED
	
	add_child(ground)
	add_child(groundCol)
	add_child(left)
	add_child(leftCol)
	add_child(right)
	add_child(rightCol)
	
	ground.owner=get_tree().edited_scene_root
	groundCol.owner=get_tree().edited_scene_root
	left.owner=get_tree().edited_scene_root
	leftCol.owner=get_tree().edited_scene_root
	right.owner=get_tree().edited_scene_root	
	rightCol.owner=get_tree().edited_scene_root
	
	
	#border.global_position=Vector2(0.0,0.0)
	#border.global_position=Vector2(0.0,0.0)
	#
	#var rightinit = Vector2(1920,1080/2)
	#var bottominit = Vector2(1920/2.0,1080)
	#var leftinit =Vector2(0,1080/2.0)
	#
	#var initpoints=PackedVector2Array([Vector2(0,540)+rightinit,Vector2(0,-540)+rightinit,
									#Vector2(1920/2.0,0)+bottominit,Vector2(-1920/2.0,0)+bottominit,   
									#Vector2(0,540)+leftinit,Vector2(0,-540)+leftinit]
									#)
	#var Colinitpoints=initpoints
									#
	#for x in range(0,1920+(2*1080)+1-600):
		#if x <1080-200:
			#print("worked1")
			#initpoints.append(rightWallFunc(x))
			#if x % 10 == 0:
				#Colinitpoints.append(rightWallFunc(x))
		#elif x-(1080-200)<1920-200:
			#print("worked2")
			#initpoints.append(groundFunc(x-(1080-200))+rightinit)
			#if x % 10 == 0:
				#Colinitpoints.append(groundFunc(x-(1080))+rightinit)
		#else:
			#print("worked3")
			#initpoints.append(leftWallFunc(x-(1080)-(1980))+bottominit)
			#if x % 10 == 0:
				#Colinitpoints.append(leftWallFunc(x-(1080)-(1980))+bottominit)
	#border.set_polygon(initpoints)
	#borderCol.set_polygon(Colinitpoints)
	#
	#add_child(border)
	#add_child(borderCol)
	
	pass # Replace with function body.
	

func _process(_delta: float) -> void:
	pass



