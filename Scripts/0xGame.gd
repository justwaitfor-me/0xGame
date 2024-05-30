extends Node2D

@onready var platform_load:PackedScene = load("res://Scenes/platform_0.tscn")
var platform_inst
var last_pos = Vector2(0, -10)
var level = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	platform_inst = platform_load.instantiate()
	platform_inst.global_position = Vector2(90, 80)
	add_child(platform_inst)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $Player.global_position.y < last_pos.y:
		platform_inst = platform_load.instantiate()
		last_pos = Vector2(randf_range(-100, 100), last_pos.y - 410)
		platform_inst.global_position = last_pos
		add_child(platform_inst)
		level += 1
		$Camera2D/Label2.text = str(level)
