@tool
extends StaticBody2D
class_name Bounds
var ground = Polygon2D.new()
var groundCol = CollisionPolygon2D.new()

var sandText= preload("res://abrasive-beige-surface.jpg")
	# Called when the node enters the scene tree for the first time.
func groundfunc(x:float):
	return Vector2((x/10.0)+(-1920/2.0), -100+0.8*sin((x/10.0)/10)+20*sin((x/10.0)/50.0)+60.0*sin((x/10.0)/134.0))
	
func _ready() -> void:
	
	ground.global_position=Vector2(1920/2.0,1080)
	var points = PackedVector2Array([ Vector2(1920/2.0,0),Vector2(-1920/2.0,0)])
	for x in range(0,19200):
		points.append(Vector2((x/10.0)+(-1920/2.0), -100+0.8*sin((x/10.0)/10)+20*sin((x/10.0)/50.0)+60.0*sin((x/10.0)/134.0)))
	ground.set_polygon(points)
	#print(points)
	var points2=PackedVector2Array([Vector2(1920,1080),Vector2(0,1080)])
	for i in range(1,1920,10):
		points2.append(Vector2((i)+(0),1080 -100+0.8*sin((i)/10)+20*sin((i)/50.0)+60.0*sin((i)/134.0)))
	groundCol.set_polygon(points2)
	
	ground.texture= sandText
	ground.texture_repeat=CanvasItem.TEXTURE_REPEAT_ENABLED
	add_child(ground)
	add_child(groundCol)
	ground.owner=get_tree().edited_scene_root
	groundCol.owner=get_tree().edited_scene_root
#	print(ground.polygon)
	pass # Replace with function body.

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


#PackedVector2Array([Vector2(1920/2.0,-100.0), Vector2(1920/2.0,0),Vector2(-1920/2.0,0),Vector2(-1920/2.0,-100.0) 





#for i in range(0,19200):
		#points.append(Vector2((i/10.0)+(-1920/2.0), -100+0.8*sin((i/10.0)/10.0)+4*sin((i/10.0)/50.0)+24.0*sin((i/10.0)/200.0)))
	#ground.set_polygon(points)
