extends Node2D
var screen_size
var play_area
signal collide

#func _ready() -> void:
#	screen_size = get_viewport_rect().size # Chages screen size
	
func _process(delta: float) -> void:
	collide.emit()
	
	
	
