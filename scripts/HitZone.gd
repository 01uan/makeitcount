extends Sprite2D  # Assuming this script is attached to the hitzone sprite

var pointsToMakeMonsterMad: int = 8

@onready var gun_hit = $"../Gun_Hit"
@onready var monster_hit = $"../Sounds/Monster_Hit"
@onready var _4_hit_combo: AudioStreamPlayer2D = $"../Sounds/4_Hit_Combo"

var points: int = 0
var explosion_sprite: AnimatedSprite2D
#var bullets: int = 3
var shot_streak: int = 0
var speed_x: float = 200;
var speed_y: float = 200;

var screen_size: Vector2
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _ready():
	explosion_sprite = get_node("../Explosion")  # Replace with the correct path to your explosion sprite
	explosion_sprite.hide()
	explosion_sprite.connect("animation_finished", Callable(self, "_on_explosion_animation_finished"))
	random_reposition()	
	screen_size = get_viewport_rect().size
	
func _process(delta):
	if Input.is_action_just_pressed("ui_select"):
		$"../Gun_Hit".play()
		if is_crosshair_in_hitzone():
			hide()
			play_explosion_animation()
			increment_point()
			random_reposition()
			show()
			monster_hit.play()
			$"../Crosshair".on_shot_fired()
			if points >= pointsToMakeMonsterMad:
				%Monster.madDamage()
			else:
				%Monster.defaultDamage()
				
		else:
			shot_streak = 0

# Check if the crosshair is within a small distance of the hitzone
func is_crosshair_in_hitzone() -> bool:
	var crosshair = get_node("../Crosshair")  # Path to your crosshair node
	var distance = crosshair.global_position.distance_to(global_position)  # Calculate distance
	print("Distance: ", distance)
	
	# Customize this threshold based on your sprite sizes (e.g., radius of hitzone)
	return distance < 35
	
# Reposition the hitzone randomly within the screen bounds
func random_reposition(): 
	global_position = Vector2(100 + randi() % 900, 150 + randi() % 450) # Random position based on screen size

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
	$"../Sounds/4_Hit_Combo"
	if shot_streak == 3:
		_4_hit_combo.play()
		$"../timer-node".elapsed_time = 0
		shot_streak = 0
	else:
		shot_streak += 1
	$"../Hud".points = points
	
	#var points_label = get_node("../PointsLabel")
	#points_label.text = "Points: " + str(points)
	
func set_random_direction():
	# Randomly set initial direction
	if randi() % 2 == 0:
		speed_x = -speed_x
	if randi() % 2 == 0:
		speed_y = -speed_y

func move_hitzone(delta: float):
	# Move hitzone
	position.x += speed_x * delta
	position.y += speed_y * delta

	# Bounce off left/right edges
	if position.x <= 0 or position.x >= screen_size.x - texture.get_size().x:
		speed_x = -speed_x
	
	# Bounce off top/bottom edges
	if position.y <= 0 or position.y >= screen_size.y - texture.get_size().y:
		speed_y = -speed_y
