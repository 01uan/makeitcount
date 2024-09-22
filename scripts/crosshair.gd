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
	elif mode == "moving target":
		$"../HitZone".move_hitzone(delta)
		if Input.is_action_pressed("ui_right"):
			direction.x = 1 
		if Input.is_action_pressed("ui_left"):
			direction.x = -1
		if Input.is_action_pressed("ui_down"):
			direction.y = 1
		if Input.is_action_pressed("ui_up"):
			direction.y = -1
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

func on_shot_fired():
	var random_number = randi_range(3,15)

	if random_number <= 3:
		var random_mode = randi_range(0,3)
		if random_mode == 0:
			change_mode("drunk")
		elif random_mode == 1:
			change_mode("inverted")
		elif random_mode == 2:
			change_mode("moving target")
		else:
			change_mode("hesitation")
	else:
		change_mode("normal")
	$"../Control/Label".text = mode
