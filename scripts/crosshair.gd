extends Sprite2D

var speed: float = 400
var mode = "normal"

func change_mode(param_mode):
	mode = param_mode

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var direction = Vector2.ZERO
	if mode == "normal":
		if Input.is_action_pressed("ui_right"):
			direction.x = 1
		if Input.is_action_pressed("ui_left"):
			direction.x = -1
		if Input.is_action_pressed("ui_down"):
			direction.y = 1
		if Input.is_action_pressed("ui_up"):
			direction.y = -1
	elif mode == "inverted":
		if Input.is_action_pressed("ui_right"):
			direction.x = -1
		if Input.is_action_pressed("ui_left"):
			direction.x = 1
		if Input.is_action_pressed("ui_down"):
			direction.y = -1
		if Input.is_action_pressed("ui_up"):
			direction.y = 1
	elif mode == "drunk":
		var random = randi_range(0, 1)
		if Input.is_action_pressed("ui_right"):
			direction.x = 1
			if random == 0:
				direction.y = 1
			else:
				direction.y = -1
		if Input.is_action_pressed("ui_left"):
			direction.x = -1
			if random == 0:
				direction.y = 1
			else:
				direction.y = -1
		if Input.is_action_pressed("ui_down"):
			direction.y = 1
			if random == 0:
				direction.x = 1
			else:
				direction.x = -1
		if Input.is_action_pressed("ui_up"):
			direction.y = -1
			if random == 0:
				direction.x = 1
			else:
				direction.x = -1
		elif not (Input.is_action_pressed("ui_down") or Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right")):
			if random == 0:
				direction.x = 1
			else:
				direction.x = -1
			random = randi_range(0, 1)
			if random == 0:
				direction.y = 1
			else:
				direction.y = -1
		
	elif mode == "hesitation":
		
		if Input.is_action_pressed("ui_right"):
			await get_tree().create_timer(0.5).timeout
			direction.x = 1
		if Input.is_action_pressed("ui_left"):
			await get_tree().create_timer(0.5).timeout
			direction.x = -1
		if Input.is_action_pressed("ui_down"):
			await get_tree().create_timer(0.5).timeout
			direction.y = 1
		if Input.is_action_pressed("ui_up"):
			await get_tree().create_timer(0.5).timeout
			direction.y = -1
		pass
	#if Input.is_action_pressed("ui_right"):
		#direction.x = 1
	#elif Input.is_action_pressed("ui_left"):
		#direction.x = -1
	#else:
		#direction.x = 0
	#
	#if Input.is_action_pressed("ui_down"):
		#direction.y = 1
	#elif Input.is_action_pressed("ui_up"):
		#direction.y = -1
	#else:
		#direction.y = 0

	position += direction * speed * delta
	var viewportInfo : Rect2 = get_viewport().get_visible_rect()
	if position.x < viewportInfo.position.x:
		position.x = viewportInfo.position.x

	if position.y < viewportInfo.position.y:
		position.y = viewportInfo.position.y

	if position.x >= viewportInfo.end.x:
		position.x = viewportInfo.end.x-1
#
	if position.y >= viewportInfo.end.y:
		position.y = viewportInfo.end.y-1
