extends Sprite2D  # Assuming this script is attached to the hitzone sprite

var pointsToMakeMonsterMad: int = 5
@onready var monster_hit = $"../Monster_Hit"

var points: int = 0
var explosion_sprite: AnimatedSprite2D
#var bullets: int = 3
var shot_streak: int = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _ready():
	explosion_sprite = get_node("../Explosion")  # Replace with the correct path to your explosion sprite
	explosion_sprite.hide()
	explosion_sprite.connect("animation_finished", Callable(self, "_on_explosion_animation_finished"))
	
func _process(delta):
	if Input.is_action_just_pressed("ui_select"):
		$"../Gun_Hit".play()
		if is_crosshair_in_hitzone():
			hide()
			play_explosion_animation()
			increment_point()
			random_reposition()
			show() 
			$"../Crosshair".on_shot_fired()
		else:
			shot_streak = 0

# Check if the crosshair is within a small distance of the hitzone
func is_crosshair_in_hitzone() -> bool:
	var crosshair = get_node("../Crosshair")  # Path to your crosshair node
	var distance = crosshair.global_position.distance_to(global_position)  # Calculate distance
	print("Distance: ", distance)
	
	# Customize this threshold based on your sprite sizes (e.g., radius of hitzone)
	return distance < 20
	
# Reposition the hitzone randomly within the screen bounds
func random_reposition(): 
	global_position = Vector2(randi() % 1000, 150 + randi() % 450) # Random position based on screen size

func increment_point():
	points += 1
	update_points_label()
	
	if points == pointsToMakeMonsterMad:
		%"Monster".changeMonsterPhaseMad()
		$"../AudioStreamPlayer".stop()
		$"../AudioStreamPlayer2".play()
	


func play_explosion_animation():
	explosion_sprite.global_position = global_position
	explosion_sprite.show()
	explosion_sprite.play("default")

func _on_explosion_animation_finished():
	explosion_sprite.hide()  # Hide the explosion sprite after the animation is done


func update_points_label():
	#if $"../timer-node".elapsed_time <= 2:
		#$"../timer-node".elapsed_time
	#else:
		#$"../timer-node".elapsed_time -= 2
	
	if shot_streak == 3:
		$"../timer-node".elapsed_time = 0
		shot_streak = 0
	else:
		shot_streak += 1
	$"../Hud".points = points
	
	#var points_label = get_node("../PointsLabel")
	#points_label.text = "Points: " + str(points)
