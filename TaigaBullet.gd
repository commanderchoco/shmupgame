extends Node2D
var speed = 3000


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Bullet/BulletSprite.animation = "default"
	#rotate(1)
	
	
func _physics_process(delta: float) -> void:
	position -= transform.y * delta * speed
	#position -= transform.y * speed * delta

func _on_Bullet_body_entered(body):
	if body.is_in_group("mobs"):
		body.queue_free()
	queue_free()
