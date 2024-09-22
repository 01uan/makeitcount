extends Control

var rotate_direction = CLOCKWISE

func _ready() -> void:
	$AudioStreamPlayer2D.play()

func _process(_delta: float) -> void:
	if rotate_direction == CLOCKWISE:
		if $TextureRect/Label2.rotation < 0.4:
			$TextureRect/Label2.rotation += 0.005
		else:
			rotate_direction = COUNTERCLOCKWISE
	elif rotate_direction == COUNTERCLOCKWISE:
		if $TextureRect/Label2.rotation > -0.4:
			$TextureRect/Label2.rotation -= 0.005
		else:
			rotate_direction = CLOCKWISE


func _on_start_button_pressed() -> void:
	$AudioStreamPlayer2D.stop()
	get_tree().change_scene_to_file("res://scenes/main.tscn")
