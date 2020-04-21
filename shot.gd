extends Area2D
const SCREEN_WIDTH = 320
const MOVE_SPEED = 500.0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += Vector2(MOVE_SPEED * delta, 0.0)
	if position.x >= SCREEN_WIDTH + 8:
		queue_free()


func _on_shot_area_entered(area):
	queue_free()
