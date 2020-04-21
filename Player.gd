extends Area2D
const MOVE_SPEED = 150.0
const SCREEN_WIDTH = 320
const SCREEN_HEIGHT = 180

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var shot_scene = preload("res://shot.tscn")
var can_shot = true

func _process(delta):
	var input_dir = Vector2()
	if Input.is_key_pressed(KEY_UP) || Input.is_key_pressed(KEY_W):
		input_dir.y -= 1.0
	if Input.is_key_pressed(KEY_DOWN) || Input.is_key_pressed(KEY_S):
		input_dir.y += 1.0
	if Input.is_key_pressed(KEY_LEFT) || Input.is_key_pressed(KEY_A):
		input_dir.x -= 1.0
	if Input.is_key_pressed(KEY_RIGHT) || Input.is_key_pressed(KEY_D):
		input_dir.x += 1.0
	position += (delta * MOVE_SPEED) * input_dir
	
	if Input.is_key_pressed(KEY_SPACE) && can_shot:
		var upper_shot_instance = shot_scene.instance()
		var botton_shot_instance = shot_scene.instance()
		upper_shot_instance.position = position + Vector2(9,-5)
		botton_shot_instance.position = position + Vector2(9,5)
		# get_parent = stage
		get_parent().add_child(upper_shot_instance)
		get_parent().add_child(botton_shot_instance)
		
		can_shot = false
		$reload_timer.start()
	
	if position.x < 0.0:
		position.x = 0.0
	elif position.x > SCREEN_WIDTH:
		position.x = SCREEN_WIDTH
	if position.y < 0.0:
		position.y = 0.0
	elif position.y > SCREEN_HEIGHT:
		position.y = SCREEN_HEIGHT
		


func _on_reload_timer_timeout():
	can_shot = true

signal destroyed
var explosion_scene = preload("res://explosion.tscn")

func _on_Player_area_entered(area):
	if area.is_in_group("asteroid"):
		var explosion_instance = explosion_scene.instance()
		explosion_instance.position = position
		get_parent().add_child(explosion_instance)

		emit_signal("destroyed")	
		queue_free()
	
