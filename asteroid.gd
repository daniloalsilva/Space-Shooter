extends Area2D

var explosion_scene = preload("res://explosion.tscn")
var move_speed = 100.0
var score_emitted = false
signal score

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position -= Vector2(move_speed * delta, 0.0)
	if position.x <= -100:
		queue_free()


func _on_asteroid_area_entered(area):
	if area.is_in_group("shot") or area.is_in_group("player"):
		if not score_emitted:
			score_emitted = true
			emit_signal("score")
			queue_free()
			
			var explosion_instance = explosion_scene.instance()
			explosion_instance.position = position
			get_parent().add_child(explosion_instance)
		
