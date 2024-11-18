extends CanvasGroup


var fps = 0
var fTime = 0.0
var fpsList = []
var fpsAvg = 0
var fpsMin = INF
var fpsMax = 0
var fpsCeroUnoP
var fpsUnoP
var memoriaTotal
var memoriaTotalMB

var capMuestreoFps = 1024
var intervalo = 2.0


# Called when the node enters the scene tree for the first time.
func _ready():
	#configura un temporizador para que inicie cada 5 segundo
	var timer = Timer.new()
	timer.wait_time = intervalo
	timer.one_shot = false
	timer.timeout.connect(_on_timer_timeout)
	#timer.timeout.connect(Callable(self, "_on_timer_timeout")) 
	add_child(timer)
	timer.start()
	
	#DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta) -> void:
	#var last_tick := 0
	fps = Engine.get_frames_per_second()
	fTime = Performance.get_monitor(Performance.TIME_PROCESS) * 1000
	#var frametime := (Time.get_ticks_usec() - last_tick) * 0.001
	
	memoriaTotal = Performance.get_monitor(Performance.MEMORY_STATIC)
	memoriaTotalMB = memoriaTotal / (1024 * 1024)
	
	# Guardar los FPS actuales en la lista de muestras
	fpsList.append(fps)
	
	# limitar el numero de muestras almacenadas
	if fpsList.size() > capMuestreoFps:
		fpsList.pop_front()
	
	#contador de FPS
	$FPSMeter.text = "FPS: "+str(fps)
	$FtimeMeter.text = ""+str("%.2f" % fTime)+" ms"
	$FPSAvg.text = "avg: "+str("%.f" % fpsAvg)
	$FPSMax.text = "max: "+str(fpsMax)
	$FPSMin.text = "min: "+str(fpsMin)
	$FPSUno.text = "1% bajo: "+str(fpsUnoP)
	$FPSCeroUno.text = "0.1% bajo: "+str(fpsCeroUnoP)
	$Memoria.text = "memoria: "+str("%.2f" % memoriaTotalMB)+" MB"
	pass
	
func _on_timer_timeout():
	
	#calcular el minimo y el maximo
	fpsMin = min(fpsMin, fps)
	fpsMax = max(fpsMax, fps)
	
	
	if fpsList.size() > 0:
		#calcular fps promedio
		var total_fps = 0
		for sample in fpsList:
			total_fps += sample
		fpsAvg = total_fps / fpsList.size()
		
		#ordena los fps para encontrar los porcentiles
		fpsList.sort()
		
		#calcula el indice de los 0.1% y 1% bajos
		var index_fpsCeroUnoP = int(fpsList.size() * 0.001)
		var index_fpsUnoP = int(fpsList.size() * 0.01)
		
		#calcula los 0.1% y 1% bajos
		fpsCeroUnoP = fpsList[min(index_fpsCeroUnoP, fpsList.size() -1 )]
		fpsUnoP = fpsList[min(index_fpsUnoP, fpsList.size() -1 )]
		
		#reiniciar la lista de muestras para el siguiente intervalo
		fpsList.clear()
	
	
