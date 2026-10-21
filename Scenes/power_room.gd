extends Node3D

@onready var warningLight = $OmniLight3D

@export var warningOn : bool = false
@export var camActive : bool = false

var kangarooInRoom : bool = false
var canActivateAlarm : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	warningLight.light_energy = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (camActive):
		canActivateAlarm = true
