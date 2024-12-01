extends Node2D

var autoNode = preload("res://auto_0.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	inst(Vector2(576,320))



func inst(pos):
	var intancia = autoNode.instantiate()
	intancia.position = pos
	add_child(intancia)
