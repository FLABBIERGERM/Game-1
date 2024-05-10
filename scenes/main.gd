extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Menu"):
		get_tree().paused = not get_tree().paused
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

		
		$Pausemenu/VBoxContainer.visible = not $Pausemenu/VBoxContainer.visible 


func _on_exit_game_pressed():
	get_tree().quit() 
	
