extends StaticBody2D

@onready var screen_size = get_viewport_rect().size

#var screen_size = get_viewport_rect().sizes


func _physics_process(_delta: float) -> void:
	position += Vector2(0,-5)
	screen_wrap()


func screen_wrap():
	#position = position.posmodv(screen_size)
	position.y =wrapf(position.y, 0, screen_size.y)
