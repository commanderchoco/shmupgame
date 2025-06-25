extends Node2D
signal hit

@export var speed = 1000
var TaigaBullet_scene = preload("res://TaigaBullet.tscn")
var screen_size
const SHOT_READY = 5
var shot_timer = SHOT_READY


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size # Chages screen size
	position.x = 500
	position.y = 500

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity = Vector2.ZERO
	
	#movement
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("focus_movement"):
		speed = 500
	else:
		speed = 1000
		
	#shooting hopefully
	if Input.is_action_pressed("shoot"):
		if shot_timer == SHOT_READY:
			shoot()
		else:
			shot_timer += 1
		
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		
	
		
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)

	if velocity.x == 0:
		$Player/Taiga.animation = "default"
	if velocity.x < 0:
		$Player/Taiga.animation = "left"
	if velocity.x > 0:
		$Player/Taiga.animation = "right"
		
	
func shoot(): #function for shooting bullets
	var b1 = TaigaBullet_scene.instantiate()
	var b2 = TaigaBullet_scene.instantiate()
	var b3 = TaigaBullet_scene.instantiate()
	get_tree().root.add_child(b1)
	get_tree().root.add_child(b2)
	get_tree().root.add_child(b3)
	b1.transform = $Player/ShotStart1.global_transform
	b2.transform = $Player/ShotStart2.global_transform
	b3.transform = $Player/ShotStart3.global_transform
	#$Player/Shot_Cooldown.start()
	shot_timer = 0
	
func on_hit():
	hit.emit()
	
