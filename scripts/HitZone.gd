extends Sprite2D  # Assuming this script is attached to the hitzone sprite

var pointsToMakeMonsterMad: int = 5
var points: int = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_crosshair_in_hitzone() and Input.is_action_just_pressed("ui_select"):
		hide()
		increment_point()
		random_reposition()
		show() 

# Check if the crosshair is within a small distance of the hitzone
func is_crosshair_in_hitzone() -> bool:
	var crosshair = get_node("../Crosshair")  # Path to your crosshair node
	var distance = crosshair.global_position.distance_to(global_position)  # Calculate distance
	print("Distance: ", distance)
	
	# Customize this threshold based on your sprite sizes (e.g., radius of hitzone)
	return distance < 15
	
# Reposition the hitzone randomly within the screen bounds
func random_reposition():
	global_position = Vector2(randi() % 1000, randi() % 500) # Random position based on screen size

func increment_point():
	points += 1
	update_points_label()
	
	if points == pointsToMakeMonsterMad:
		%"Monster".changeMonsterPhaseMad()
	
func update_points_label():
	$"../Hud".points = points
	#var points_label = get_node("../PointsLabel")
	#points_label.text = "Points: " + str(points)
