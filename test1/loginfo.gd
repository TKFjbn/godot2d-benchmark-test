extends TextEdit

@onready var totalAutos = $"../TotalAutos"
var texto = "";
var ultimoNum

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var total = totalAutos.text
	var totalInt = total.to_int()
	texto = $".".text
	
	if totalInt > 0 && totalInt % 50  == 0:
		if totalInt != ultimoNum:
			print(texto)
			ultimoNum = totalInt
