extends AnimatedSprite2D

@onready var phase_1 = $"../Sounds/Phase1"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Attempting to pre-load the animations
	$".".animation = "mad"
	$".".animation = "default"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func changeMonsterPhaseMad() -> void:
	var this = $"."
	phase_1.play()
	this.animation = "mad"
