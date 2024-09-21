extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	#this is where you left off.
	#we want the hit zone to appear, and when it gets hit, dissapears and 
	#then another hitzone appears
	
	
	position.x = randi_range(1, 1900)
	position.y = randi_range(1, 1900)
