extends CharacterBody2D
var speed = 1000

var focus_movement = false
		#movement
	#if Input.is_action_pressed("move_up"):
		#velocity.y -= 10
	#if Input.is_action_pressed("move_down"):
		#velocity.y += 10
	#if Input.is_action_pressed("move_left"):
		#velocity.x -= 10
	#if Input.is_action_pressed("move_right"):
		#velocity.x += 10
	#if Input.is_action_pressed("focus_movement"):
		##slows movement speed when focusing
		#speed = 500

func get_input():
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_dir * speed

func _physics_process(delta):
	get_input()
	move_and_slide()
	
	
