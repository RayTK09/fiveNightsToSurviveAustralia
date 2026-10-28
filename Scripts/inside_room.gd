class_name insideRoom
extends Node3D

@onready var cam1Light : SpotLight3D = $Camera3D/SpotLight3D
@onready var cam2Light : SpotLight3D = $Camera3D2/SpotLight3D

#Im gonna do a funny
@export var cam1Active : bool = false
@export var cam2Active : bool = false
@export var isNealCam2 : bool = false
@export var isKangarooCam1 : bool = false
@export var isKangarooCam2 : bool = false
@export var alarmActiveInside : bool = false
@export var main : Node3D

var startTimer : bool = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (cam1Active):
		cam1Light.light_energy = 1
		$Camera3D.current = true
	else:
		cam1Light.spot_attenuation = 0
		$Camera3D.current = false
	if (cam2Active):
		cam2Light.light_energy = 1
		$Camera3D2.current = true
	else:
		cam2Light.light_energy = 0
		$Camera3D2.current = false
	
	if (alarmActiveInside):
		$AnimationPlayer.play("blinkingLight")
	elif (!alarmActiveInside):
		$AnimationPlayer.stop()
		
	if (isNealCam2):
		$nealCam2.visible = true
	else:
		$nealCam2.visible = false
	#kangaroos
	if (isKangarooCam1):
		$kangarooCam1.visible = true
	elif (isKangarooCam2):
		$kangarooCam2.visible = true
	
	if (alarmActiveInside):
		if startTimer:
			startTimer = false
			$Timer.start()
	if (!alarmActiveInside):
		$Timer.stop()
		main.kangarooDeath.paused = false
		$AudioStreamPlayer.stop()


func _on_timer_timeout() -> void:
	if (isKangarooCam1 and cam2Active):
		#print("deactivated")
		isKangarooCam1 = false
		main.kangarooActive = false
		$kangarooCam1.visible = false
		main.kangarooDeath.stop()
	elif (isKangarooCam2 and cam1Active):
		#print("deactivated")
		isKangarooCam2 = false
		main.kangarooActive = false
		$kangarooCam2.visible = false
		main.kangarooDeath.stop()
