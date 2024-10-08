extends Label

@onready var delay = $"../../Sounds/Delay"
@onready var drunk = $"../../Sounds/Drunk"
@onready var inverted = $"../../Sounds/Inverted"
@onready var moving_target_yell = $"../../Sounds/Moving_Target_Yell"

var mode = "normal"
var smallToBig = true
var leftToRight = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if mode == "drunk":
		var random = randi_range(0, 3)
		
		if random == 0:
			$".".position.x = $".".position.x + 1
		elif random == 1:
			$".".position.x = $".".position.x - 1
		elif random == 2:
			$".".position.y = $".".position.y + 1
		elif random == 3:
			$".".position.y = $".".position.y - 1
	elif mode == "hesitation":
		if smallToBig == true:
			if $".".scale.x < 2.0:
				$".".scale.x = $".".scale.x + 0.025
				$".".scale.y = $".".scale.y + 0.025
			else: 
				smallToBig = false
		else:
			if $".".scale.x > 1.5:
				$".".scale.x = $".".scale.x - 0.025
				$".".scale.y = $".".scale.y - 0.025
			else:
				smallToBig = true
	elif mode == "moving target":
		if $".".position.x >= 50:
			leftToRight = false
		elif $".".position.x <= -50:
			leftToRight = true
			
		if leftToRight == true:
			$".".position.x = $".".position.x + 1
		elif leftToRight == false:
			$".".position.x = $".".position.x - 1
	
# Called to change this label's mode
func modeChange(modeName) -> void:
	
	mode = modeName
	$".".text = "Mode: " + modeName.capitalize()
	$".".rotation_degrees = 0
	$".".position.x = 0
	$".".position.y = 0
	$".".scale.x = 1.5
	$".".scale.y = 1.5
	
	
	if modeName == "drunk":
		drunk.play()
		$".".text = "Mode: " + modeName.capitalize()

	elif modeName == "inverted":
		inverted.play()
		$".".rotation_degrees = 180
		$".".position.x = 1159
		$".".position.y = 96
		$".".text = "Mode: " + modeName.capitalize()
		
	elif modeName == "hesitation":
		delay.play()
		smallToBig = true
		$".".text = "Mode: " + modeName.capitalize()
		
	elif modeName == "moving target":
		moving_target_yell.play()
		leftToRight = true;
	else: 
		$".".text = "Mode: " + modeName.capitalize()
