extends CharacterBody2D

@onready var screen_size = get_viewport_rect().size
@onready var ZonaDelantera = $ZonaDelantera

var vel: float
var velActual: float
var velObjetivo: float
var velMinima: float = 4
var velMaxima: float = 6
var velRedTrasera: float = 0.5
var velRedLateral: float = 1
var velo = Vector2.ZERO
var suavizado: float = 0.5
var rngVel = RandomNumberGenerator.new()
var rngTono = RandomNumberGenerator.new()
var nuevaPos = Vector2()

func _ready() -> void:
	
	#asigna un color aleatorio
	colorAleatorio()
	#asigna una velocidad aleatoria al script del auto
	vel = rngVel.randf_range(velMinima,velMaxima)
	velActual = vel
	velObjetivo = vel

func colorAleatorio():
	var tono = rngTono.randf_range(0.0,1.0) 
	modulate = Color.from_hsv(tono, 0.38, 1, 1)

func _physics_process(delta):
	velActual = lerpf(velActual,velObjetivo, delta / suavizado)
	velocity = Vector2.ZERO
	velocity += -transform.y  * velActual
	velo = move_and_collide(velocity)
	LimitePantalla()
	triggeEnter()
	
func LimitePantalla():
	position = position.posmodv(screen_size)
	
func triggeEnter():
	if ZonaDelantera.is_colliding():
		var collider = ZonaDelantera.get_collider().get_name()

		if collider == "AreaTrasera":
			velObjetivo = velRedTrasera
			pass
		if collider == "AreaLateral":
			velObjetivo = velRedLateral
			pass
	else:
		velObjetivo = vel
		pass	
	

	pass
