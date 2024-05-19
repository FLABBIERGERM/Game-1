extends Node3D

var score = 0


@onready var spawns = $spawnholder
@onready var navigation_region = $NavigationRegion3D
# Called when the node enters the scene tree for the first time.
var spider = load("res://scenes/Spider.tscn") 
var instance
@export var player_path : NodePath
func _ready():
	randomize()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Menu"):
		get_tree().paused = not get_tree().paused
		if get_tree().paused:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
		$Pausemenu/VBoxContainer.visible = not $Pausemenu/VBoxContainer.visible

 


func _on_exit_game_pressed():
	get_tree().quit() 
	
func _get_random_child(parent_node):
	var random_id = randi() % parent_node.get_child_count()
	return parent_node.get_child(random_id)


func _on_spawn_timer_timeout():
	var spawn_point = _get_random_child(spawns).global_position
	instance = spider.instantiate()
	instance.position =  spawn_point
	navigation_region.add_child(instance)
	


