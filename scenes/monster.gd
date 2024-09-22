extends AnimatedSprite2D

@onready var phase_1 = $"../Sounds/Phase1"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# You can call changeMonsterPhaseMad() to make mad
	#if Input.is_action_pressed("ui_up"):
		#changeMonsterPhaseMad()
	pass

func changeMonsterPhaseMad() -> void:
	var this = $"."
	phase_1.play()
	this.animation = "mad"
