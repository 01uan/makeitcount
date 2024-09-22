extends AnimatedSprite2D


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
	this.animation = "mad"

func defaultDamage() -> void:
	%Monster.animation = "defaultdamage"
	await get_tree().create_timer(0.5).timeout  
	%Monster.animation = "default"

func madDamage() -> void:
	%Monster.animation = "maddamage"
	await get_tree().create_timer(0.5).timeout  
	%Monster.animation = "mad"
