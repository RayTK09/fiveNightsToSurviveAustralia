extends Node3D

@onready var warningLight = $OmniLight3D

@export var warningOn : bool = false
@export var camActive : bool = false
@export var kangarooInRoom : bool = false
@export var main : Node3D

var canActivateAlarm : bool = false
var startTimer : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	warningLight.light_energy = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (camActive):
		canActivateAlarm = true
		$Camera3D.current = true
	else:
		canActivateAlarm = false
		$Camera3D.current = false
	
	if (warningOn):
		$AnimationPlayer.play("blinkingLight")
	elif (!warningOn):
		$AnimationPlayer.stop()
	#kangaroos
	if (kangarooInRoom):
		$kangarooCam4.visible = true
	
	if (warningOn):
		if startTimer:
			startTimer = false
			$Timer.start()
		main.kangarooDeath.paused = true
	if (!warningOn):
		$Timer.stop()
		main.kangarooDeath.paused = false
		$AudioStreamPlayer.stop()


func _on_timer_timeout() -> void:
	if (kangarooInRoom and camActive):
		#print("deactivated")
		main.kangarooActive = false
		kangarooInRoom = false
		$kangarooCam4.visible = false
		main.kangarooDeath.stop()
