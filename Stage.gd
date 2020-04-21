extends Node2D
const SCREEN_WIDTH = 320
const SCREEN_HEIGHT = 180

var is_game_over = false
var asteroid = preload("res://asteroid.tscn")
var score = 0



# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.connect("destroyed", self, "on_Player_destroyed")
	$spawn_timer.connect("timeout",self,"_on_spawn_timer_timeout")
	# force asteroids to appear in diferent locations - randomization alghoritm on
	#randomize()
	
func _input(event):
	if (Input.is_key_pressed(KEY_ESCAPE)):
		get_tree().quit()
	if (is_game_over && Input.is_key_pressed(KEY_ENTER)):
		get_tree().change_scene("res://Stage.tscn")
		
func on_Player_destroyed():
	$ui/retry.show()
	is_game_over = true
	

func _on_spawn_timer_timeout():
	var asteroid_instance = asteroid.instance()
	asteroid_instance.position = Vector2(SCREEN_WIDTH + 8, rand_range(0, SCREEN_HEIGHT))
	asteroid_instance.connect("score", self, "_on_player_score")
	add_child(asteroid_instance)
	pass # Replace with function body.

func _on_player_score():
	score += 1
	$ui/score.text = "Score: " + str(score)
	
