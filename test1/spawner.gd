extends Node2D



@onready var autoNode = preload("res://auto_0.tscn")
@onready var screen_size = get_viewport_rect().size
var xMid
var yMid

var intervaloSpawn: float = 0.4
var nextSpawnTime: float

var rotacionMin: float = 0
var rotacionMax: float = 360
var rngRotacion = RandomNumberGenerator.new()


func _ready():
	nextSpawnTime = intervaloSpawn
	
	xMid = screen_size.x / 2
	yMid = screen_size.y / 2

func _process(delta: float) -> void:
	var fps = Engine.get_frames_per_second()
	nextSpawnTime -= delta
	
	if fps > 30:
		if(nextSpawnTime <= 0.0):
			generaAutos(Vector2(xMid,yMid))
			nextSpawnTime = intervaloSpawn
	else:
		print("ya no se generan más objetos por limite de fps")
	
	
	

func generaAutos(pos):
	#genera el auto en la posicion del spawner
	var nuevoAuto = autoNode.instantiate()
	nuevoAuto.position = pos
	#asigna una rotacion aleatoria
	var rotacionAleatoria = rngRotacion.randf_range(rotacionMin,rotacionMax)
	nuevoAuto.rotation = rotacionAleatoria
	
	add_child(nuevoAuto)
