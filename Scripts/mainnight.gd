extends Node3D

#planning a game out for once instead of yoloing it?!!??! that's insane.
@export var night : int = 1
@export var nealAI : int = 0
@export var caneToadAI : int = 0
@export var kangarooMafiaAI : int = 0
@export var evilAssEagleAI : int = 0

@onready var nealTime = $nealTimer
@onready var toadTime = $toadTimer
@onready var eagleTime = $eagleTimer
@onready var kangarooTime = $kangarooTimer

var nealProgress : int = 0
var toadProgress : int = 0
var eagleProgress : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	match night:
		1:
			nealAI = 0
			nealTime.start()
		2:
			nealAI = 3
			caneToadAI = 1
			nealTime.start()
			toadTime.start()
		3:
			nealAI = 7
			caneToadAI = 3
			evilAssEagleAI = 1
			nealTime.start()
			toadTime.start()
			eagleTime.start()
		4:
			nealAI = 10
			caneToadAI = 7
			evilAssEagleAI = 4
			kangarooMafiaAI = 1
			nealTime.start()
			toadTime.start()
			eagleTime.start()
			kangarooTime.start()
		5:
			nealAI = 15
			caneToadAI = 13
			evilAssEagleAI = 11
			kangarooMafiaAI = 10
			nealTime.start()
			toadTime.start()
			eagleTime.start()
			kangarooTime.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (nealTime.timeout):
		var moveNum : int = randi_range(1, 20)
		if (moveNum <= nealAI):
			nealProgress += 1
	if (toadTime.timeout):
		var moveNum : int = randi_range(1, 20)
		if (moveNum <= caneToadAI):
			toadProgress += 1
	if (eagleTime.timeout):
		var moveNum : int = randi_range(1, 20)
		if (moveNum <= evilAssEagleAI):
			eagleProgress += 1
			
	#these kangaroos might have the most amount of logic
	if (kangarooTime.timeout):
		var moveNum : int = randi_range(1, 20)
		if (moveNum <= kangarooMafiaAI):
			var choosePath = randi_range(1, 2)
			if (choosePath == 1):
				var chooseCam = randi_range(1, 4)
			elif (choosePath == 2):
				pass
