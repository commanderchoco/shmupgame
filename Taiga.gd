extends Node2D
signal hit

@export var speed = 1000
var TaigaBullet_scene = preload("res://TaigaBullet.tscn")
var screen_size
const SHOT_READY = 5
var shot_timer = SHOT_READY
var focus_movement = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size # Chages screen size
	#position.x = 500
	#position.y = 500

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity = Vector2.ZERO
	
	
	if Input.is_action_pressed("focus_movement"):
	#makes hurtbox appear
		if ($Player/HurtBox/HurtBoxCircle.self_modulate.a < 1):
			$Player/HurtBox/HurtBoxCircle.self_modulate.a += 0.10
		if !focus_movement: 
			#makes shots turn inward
			$Player/ShotStart2.rotation -= 0.3
			$Player/ShotStart3.rotation += 0.3
		focus_movement = true
	else:
		#returns speed to normal
		speed = 1000
		#makes hurtbox disappear
		if ($Player/HurtBox/HurtBoxCircle.self_modulate.a > 0):
			$Player/HurtBox/HurtBoxCircle.self_modulate.a -= 0.10
		if focus_movement: #retorns shots to normal angle
			$Player/ShotStart2.rotation += 0.3
			$Player/ShotStart3.rotation -=	0.3
		focus_movement = false

		
	#shooting check
	if Input.is_action_pressed("shoot"):
		if shot_timer == SHOT_READY: #makes sure the bullet doesn't fire every frams
			shoot()
		else:
			shot_timer += 1 #increases shot timer by 1 frame
		
		
	if velocity.length() > 0: #normalizees diagonal movement
		velocity = velocity.normalized() * speed
		
	
		
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)

	#changes the animation based on movement direction
	if $Player.velocity.x == 0:
		$Player/Taiga.animation = "default"
	if $Player.velocity.x < 0:
		$Player/Taiga.animation = "left"
	if $Player.velocity.x > 0:
		$Player/Taiga.animation = "right"
		
		
	
func shoot(): #function for shooting bullets
	#creates new instances of bullets
	var b1 = TaigaBullet_scene.instantiate()
	var b2 = TaigaBullet_scene.instantiate()
	var b3 = TaigaBullet_scene.instantiate()
	#adds them to taiga
	get_tree().root.add_child(b1)
	get_tree().root.add_child(b2)
	get_tree().root.add_child(b3)
	#sets their positions to the shot start locations
	b1.transform = $Player/ShotStart1.global_transform
	b2.transform = $Player/ShotStart2.global_transform
	b3.transform = $Player/ShotStart3.global_transform
	#$Player/Shot_Cooldown.start()
	shot_timer = 0 #resets the shot timer

	
func on_hit():
	hit.emit()
