extends Node2D

@onready var autoNode = preload("res://auto_0.tscn")


func _ready():
	inst(Vector2(0,0))
	
func inst(pos):
	var intancia = autoNode.instantiate()
	intancia.position = pos
	add_child(intancia)
	
	
