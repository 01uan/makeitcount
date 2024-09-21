extends Sprite2D

var speed: float = 200

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var direction = Vector2.ZERO
	
	if Input.is_action_pressed("ui_right"):
		direction.x = 1
	elif Input.is_action_pressed("ui_left"):
		direction.x = -1
	else:
		direction.x = 0
	
	if Input.is_action_pressed("ui_down"):
		direction.y = 1
	elif Input.is_action_pressed("ui_up"):
		direction.y = -1
	else:
		direction.y = 0

	position += direction * speed * delta

			
