extends Sprite2D

@export var velocidad: float = 200.0
var direccion_frontal


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var area2d = $Area2D
	
	
	if area2d is Area2D:
		
		#definir la direccion hacia adelante
		direccion_frontal = Vector2(0,-1).rotated(rotation)
		#aplica velocidad a esta direccion 
		print("posicion actual ", area2d.position)
		
		
		#area2d.position += direccion_frontal * velocidad + delta
		#rigidbody.linear_velocity = direccion_frontal * velocidad
		#print(rigidbody.linear_velocity)
